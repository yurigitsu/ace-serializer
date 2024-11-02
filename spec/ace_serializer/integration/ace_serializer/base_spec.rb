# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe AceSerializer::Base do
  before do
    support_dummy_serializer(:user)
    DummySerializer.root(:data)
  end

  context "when root is set" do
    let(:payload) { { user: "Joe Doe" } }
    let(:user) { support_dummy_struct(payload) }

    describe "#serialize_item" do
      it "serializes the item with the root" do
        json = "{\"data\":{\"#{payload.keys.first}\":\"#{payload.values.first}\"}\n}\n"

        expect(DummySerializer.serialize_item(user).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array with the root" do
        json = "{\"data\":[{\"user\":\"Joe Doe\"}]\n}\n"

        expect(DummySerializer.serialize_array([user]).to_json).to eq(json)
      end
    end
  end

  context "when root and root_item are set" do
    before do
      DummySerializer.root_item(:data_item)
    end

    let(:payload) { { user: "Joe Doe" } }
    let(:user) { support_dummy_struct(payload) }

    describe "#serialize_item" do
      it "serializes the item with the root_item" do
        json = "{\"data_item\":{\"#{payload.keys.first}\":\"#{payload.values.first}\"}\n}\n"

        expect(DummySerializer.serialize_item(user).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array with the root_item" do
        json = "{\"data\":[{\"#{payload.keys.first}\":\"#{payload.values.first}\"}]\n}\n"

        expect(DummySerializer.serialize_array([user]).to_json).to eq(json)
      end
    end
  end

  context "when root and root_array are set" do
    before do
      DummySerializer.root_array(:data_array)
    end

    let(:payload) { { user: "Joe Doe" } }
    let(:user) { support_dummy_struct(payload) }

    describe "#serialize_item" do
      it "serializes the item" do
        json = "{\"data\":{\"#{payload.keys.first}\":\"#{payload.values.first}\"}\n}\n"

        expect(DummySerializer.serialize_item(user).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array" do
        json = "{\"data_array\":[{\"#{payload.keys.first}\":\"#{payload.values.first}\"}]\n}\n"

        expect(DummySerializer.serialize_array([user]).to_json).to eq(json)
      end
    end
  end
end
