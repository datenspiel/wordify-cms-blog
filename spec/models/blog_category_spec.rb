require 'spec_helper'

describe WordifyCms::Blog::Category do

  it "provides name attribute" do
    expect(subject).to respond_to(:name)
  end

  it "validates the name for presence" do
    expect(subject).to validate_presence_of(:name)
  end

  describe "associations that" do

    it "has_many posts" do
      expect(subject).to have_many(:posts)
    end

  end

end