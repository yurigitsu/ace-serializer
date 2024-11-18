# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe "AceSerializer::Base" do
  before do
    support_dummy_serializer(:user, :age)
    DummySerializer.root(:data)
  end

  let(:payload) { { user: "Joe Doe", age: 25 } }
  let(:user) { support_dummy_struct(payload) }

  context "when root is set" do
    describe "#serialize_item" do
      it "serializes the item with the root" do
        json = "{\"data\":#{payload.to_json}\n}\n"

        expect(DummySerializer.item(user).to_json).to eq(json)
      end

      it "serializes the item with the root and view" do
        json = "{\"data\":#{payload.except(:age).to_json}\n}\n"

        expect(DummySerializer.item(user, view: :user_details).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array with the root" do
        json = "{\"data\":[{\"user\":\"Joe Doe\",\"age\":25}]\n}\n"

        expect(DummySerializer.array([user]).to_json).to eq(json)
      end
    end
  end

  context "when root and root_item are set" do
    before { DummySerializer.root_item(:data_item) }

    describe "#serialize_item" do
      it "serializes the item with the root_item" do
        json = "{\"data_item\":{\"user\":\"Joe Doe\",\"age\":25}\n}\n"

        expect(DummySerializer.item(user).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array with the root_item" do
        json = "{\"data\":[{\"user\":\"Joe Doe\",\"age\":25}]\n}\n"

        expect(DummySerializer.array([user]).to_json).to eq(json)
      end

      it "serializes the array with the root and view" do
        json = "{\"data\":[{\"user\":\"Joe Doe\"}]\n}\n"

        expect(DummySerializer.array([user], view: :user_details).to_json).to eq(json)
      end
    end
  end

  context "when root and root_array are set" do
    before { DummySerializer.root_array(:data_array) }

    describe "#serialize_item" do
      it "serializes the item" do
        json = "{\"data\":{\"user\":\"Joe Doe\",\"age\":25}\n}\n"

        expect(DummySerializer.item(user).to_json).to eq(json)
      end
    end

    describe "#serialize_array" do
      it "serializes the array" do
        json = "{\"data_array\":[{\"user\":\"Joe Doe\",\"age\":25}]\n}\n"

        expect(DummySerializer.array([user]).to_json).to eq(json)
      end
    end
  end
end
