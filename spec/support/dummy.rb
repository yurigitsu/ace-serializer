# typed: false
# frozen_string_literal: true

module Dummy
  def support_dummy_serializer(attributes)
    stub_const("DummySerializer", Class.new(AceSerializer::Base) do
      attributes(*attributes)
    end)
  end

  def support_dummy_struct(hash)
    Struct.new(*hash.keys).new(*hash.values)
  end
end
