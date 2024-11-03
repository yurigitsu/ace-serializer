# frozen_string_literal: true
# typed: true

require "panko_serializer"
require "sorbet-runtime"

module AceSerializer
  # This class serves as the base serializer for AceSerializer based on OJ Panko::Serializer.
  class Base < Panko::Serializer
    class << self
      extend T::Sig

      StructHash = T.type_alias { T::Hash[T.any(Symbol, String), T.untyped] }
      OptHash = T.type_alias { T::Hash[Symbol, T.untyped] }
      NilSymbol = T.type_alias { T.nilable(Symbol) }

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

      sig { params(item: T.untyped, opt: OptHash).returns(T.untyped) }
      def serialize_item(item, **opt)
        root_key = root_item || root

        item = hash_to_struct(item) if item.is_a?(Hash)
        return new(**opt).serialize_to_json(item) if root_key.nil?

        Panko::Response.create { |r| { root_key => r.serializer(item, self, **opt) } }
      end

      sig { params(array: T::Array[T.any(StructHash, T.untyped)], opt: OptHash).returns(T.untyped) }
      def serialize_array(array, **opt)
        root_key = root_array || root

        # WIP: so far assumed homogeneous collection
        array = array.map { |item| hash_to_struct(item) } if array.first.is_a?(Hash)
        collection = Panko::ArraySerializer.new(array, each_serializer: self, **opt)

        return collection.to_json if root_key.nil?

        Panko::Response.new(root_key => collection)
      end

      sig { params(hash: StructHash).returns(Struct) }
      def hash_to_struct(hash)
        transformed_hash = hash.transform_values { |value| value.is_a?(Hash) ? hash_to_struct(value) : value }

        struct(transformed_hash)
      end

      def struct(hash)
        Struct.new(*hash.keys).new(*hash.values)
      end
    end

    private_class_method :hash_to_struct, :struct
  end
end
