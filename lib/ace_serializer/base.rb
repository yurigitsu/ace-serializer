# frozen_string_literal: true
# typed: true

require "panko_serializer"
require "sorbet-runtime"
require "pry"

module AceSerializer
  # This class serves as the base serializer for AceSerializer based on OJ Panko::Serializer.
  class Base < Panko::Serializer
    StructHash = T.type_alias { T::Hash[T.any(Symbol, String), T.untyped] }
    OptHash     = T.type_alias { T::Hash[Symbol, T.untyped] }
    NilSymbol   = T.type_alias { T.nilable(Symbol) }
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
      prepend ViewFilterPrepend

      sig { params(key: NilSymbol).returns(NilSymbol) }
      def root(key = nil)
        @root ||= key
      end

      sig { params(key: NilSymbol).returns(NilSymbol) }
      def root_item(key = nil)
        @root_item ||= key
      end

      sig { params(key: NilSymbol).returns(NilSymbol) }
      def root_array(key = nil)
        @root_array ||= key
      end

      def view(name, &block)
        _view_map[name] = block
      end

      sig { params(item: T.untyped, view: NilSymbol, opt: OptHash).returns(T.untyped) }
      def serialize_item(item, view: nil, **opt)
        ctx = _serializer_context(opt, view)
        item = _hash_to_struct(item) if item.is_a?(Hash)

        root_key = root_item || root
        return new(**opt).serialize_to_json(item) if root_key.nil?

        Panko::Response.create { |r| { root_key => r.serializer(item, self, **ctx) } }
      end

      # WIP: so far assumed homogeneous collection
      sig { params(array: T::Array[T.any(StructHash, T.untyped)], view: NilSymbol, opt: OptHash).returns(T.untyped) }
      def serialize_array(array, view: nil, **opt)
        ctx = _serializer_context(opt, view)
        array = array.map { |item| _hash_to_struct(item) } if array.first.is_a?(Hash)

        root_key = root_array || root
        collection = Panko::ArraySerializer.new(array, each_serializer: self, **ctx)
        return collection.to_json if root_key.nil?

        Panko::Response.new(root_key => collection)
      end

      # private

      sig { returns(T::Hash[Symbol, FilterBlock]) }
      def _view_map
        @view_map ||= {}
      end

      sig { params(opt: OptHash, view: NilSymbol).returns(OptHash) }
      def _serializer_context(opt, view)
        return opt unless view

        opt[:context] ||= {}
        opt[:context][:view] = view

        opt
      end

      sig { params(hash: StructHash).returns(Struct) }
      def _hash_to_struct(hash)
        transformed_hash = hash.transform_values { |value| value.is_a?(Hash) ? _hash_to_struct(value) : value }

        _struct(transformed_hash)
      end

      def _struct(hash)
        Struct.new(*hash.keys).new(*hash.values)
      end
    end

    private_class_method :_serializer_context, :_hash_to_struct, :_struct, :_view_map
  end
end
