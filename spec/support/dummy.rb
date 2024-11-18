# typed: false
# frozen_string_literal: true

module Dummy
  def support_dummy_serializer(*attributes, klass: "DummySerializer")
    stub_const(klass, Class.new(AceSerializer::Base) do
      plugin :view
      plugin :hash_wrapper

      attributes(*attributes)

      view :user_details do |_context, _scope|
        {
          only: [:user]
        }
      end
    end)
  end

  def support_dummy_struct(hash)
    Struct.new(*hash.keys).new(*hash.values)
  end
end
