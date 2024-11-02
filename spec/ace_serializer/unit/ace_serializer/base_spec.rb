# typed: false
# frozen_string_literal: true

require "json"
require "spec_helper"

RSpec.describe AceSerializer::Base do
  before { support_dummy_serializer(:user) }

  context "when class api" do
    describe ".root" do
      it "sets the root key" do
        expect(DummySerializer.root(:data)).to eq(:data)
      end
    end

    describe ".root_item" do
      it "sets the root item key" do
        expect(DummySerializer.root_item(:user)).to eq(:user)
      end
    end

    describe ".root_array" do
      it "sets the root array key" do
        expect(DummySerializer.root_array(:users)).to eq(:users)
      end
    end
  end

  context "when serialize api" do
    let(:payload) { { user: "Joe Doe" } }
    let(:user) { support_dummy_struct(payload) }

    describe ".serialize_item" do
      it "serializes the classy item" do
        json = "#{payload.to_json}\n"

        expect(DummySerializer.serialize_item(user)).to eq(json)
      end

      it "serializes the hash item" do
        json = "#{payload.to_json}\n"

        expect(DummySerializer.serialize_item(payload)).to eq(json)
      end
    end

    describe ".serialize_array" do
      it "serializes the classy array" do
        json = "#{[payload].to_json}\n"

        expect(DummySerializer.serialize_array([user])).to eq(json)
      end

      it "serializes the hash array" do
        json = "#{[payload].to_json}\n"

        expect(DummySerializer.serialize_array([payload])).to eq(json)
      end
    end
  end
end
