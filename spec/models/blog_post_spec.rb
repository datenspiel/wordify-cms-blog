require 'spec_helper'

describe WordifyCms::Blog::Post do

  it "provides title attribute" do
    expect(subject).to respond_to(:title)
  end

  it "provides text attribute" do
    expect(subject).to respond_to(:text)
  end

  it "provides created_at attribute" do
    expect(subject).to respond_to(:created_at)
  end

  it "validates the title for presence" do
    expect(subject).to validate_presence_of(:title)
  end

  it "validates the text for presence" do
    expect(subject).to validate_presence_of(:text)
  end

  describe "has associations that" do

    it "belongs to a category" do
      expect(subject).to belong_to(:category)
    end

    it "belongs to an author" do
      expect(subject).to belong_to(:author)
    end

  end

end