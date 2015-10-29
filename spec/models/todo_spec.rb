require 'spec_helper'

RSpec.describe Todo, type: :model do
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:is_completed) }

  describe "valid todo" do
    let(:todo) { build(:todo) }
    it "has title and is incomplete" do
      expect(todo).to be_valid
      expect(todo.title).to be_a(String)
      expect(todo.is_completed).to eq(false)
    end
  end
end
