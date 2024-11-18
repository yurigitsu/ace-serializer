# frozen_string_literal: true
# typed: true

require "panko_serializer"
require "sorbet-runtime"
require "pry"

module AceSerializer
  # This class serves as the base serializer for AceSerializer based on OJ Panko::Serializer.
  class Base < Panko::Serializer
    PLUGINS = %i[hash_wrapper view].freeze

    StructHash  = T.type_alias { T::Hash[T.any(Symbol, String), T.untyped] }
    OptHash     = T.type_alias { T::Hash[Symbol, T.untyped] }
    NilSym      = T.type_alias { T.nilable(Symbol) }
    FilterBlock = T.type_alias { T.proc.params(context: OptHash, scope: T.untyped).returns(T.untyped) }

    # This module provides view filtering capabilities for the serializer.
    module ViewFilterPrepend
      include Kernel
      extend T::Sig

      sig { params(context: T.nilable(OptHash), scope: T.untyped).returns(OptHash) }
      def filters_for(context, scope)
        view_map = send(:_view_map)
        view_name = context && context[:view]
        has_view = !view_map.empty? && view_name

        return {} unless has_view

        view_map[view_name].call(context, scope)
      end
    end

    class << self
      extend T::Sig

      sig { params(key: NilSym).returns(NilSym) }
      def root(key = nil)
        @root ||= key
      end

      sig { params(key: NilSym).returns(NilSym) }
      def root_item(key = nil)
        @root_item ||= key
      end

      sig { params(key: NilSym).returns(NilSym) }
      def root_array(key = nil)
        @root_array ||= key
      end

      def plugin(name)
        raise "Unsupported plugin: #{name}" unless PLUGINS.include?(name)

        _plugin_hash_wrapper if name == :hash_wrapper
        _plugin_view         if name == :view

        plugins[name] = true
      end

      def plugins
        @plugins ||= {}
      end

      # rubocop:disable Metrics/MethodLength
      def _plugin_hash_wrapper
        define_singleton_method(:_hash_to_struct) do |hash|
          transformed_hash = hash.transform_values do |value|
            value.is_a?(Hash) ? send(:_hash_to_struct, value) : value
          end

          send(:_struct, transformed_hash)
        end

        define_singleton_method(:_struct) do |hash|
          Struct.new(*hash.keys).new(*hash.values)
        end

        define_singleton_method(:_array_struct) do |array|
          array.map { |item| send(:_hash_to_struct, item) }
        end

        private_class_method :_hash_to_struct, :_struct, :_array_struct
      end
      # rubocop:enable Metrics/MethodLength

      def _plugin_view
        # Class-level prepend wrapper
        class << self
          prepend ViewFilterPrepend
        end

        define_singleton_method(:_view_map) do
          @view_map ||= {}
        end

        define_singleton_method(:view) do |name, &block|
          send(:_view_map)[name] = block
        end

        private_class_method :_view_map
      end

      sig { params(item: T.untyped, view: NilSym, opt: OptHash).returns(T.untyped) }
      def item(item, view: nil, **opt)
        ctx = {}

        # plugins dependent context
        ctx = _serializer_context(opt, view) if plugins[:view]
        item = send(:_hash_to_struct, item) if plugins[:hash_wrapper] && item.is_a?(Hash)

        root_key = root_item || root
        return new(**opt).serialize_to_json(item) if root_key.nil?

        Panko::Response.create { |r| { root_key => r.serializer(item, self, **ctx) } }
      end

      # WIP: so far assumed homogeneous collection
      sig { params(array: T::Array[T.any(StructHash, T.untyped)], view: NilSym, opt: OptHash).returns(T.untyped) }
      def array(array, view: nil, **opt)
        ctx = {}

        # plugins dependent context
        ctx = _serializer_context(opt, view) if plugins[:view]
        array = send(:_array_struct, array) if plugins[:hash_wrapper] && array.first.is_a?(Hash)

        root_key = root_array || root
        collection = Panko::ArraySerializer.new(array, each_serializer: self, **ctx)
        return collection.to_json if root_key.nil?

        Panko::Response.new(root_key => collection)
      end

      # private

      sig { params(opt: OptHash, view: NilSym).returns(OptHash) }
      def _serializer_context(opt, view)
        return opt unless view

        opt[:context] ||= {}
        opt[:context][:view] = view

        opt
      end
    end

    private_class_method :_serializer_context, :_plugin_hash_wrapper, :_plugin_view
  end
end
