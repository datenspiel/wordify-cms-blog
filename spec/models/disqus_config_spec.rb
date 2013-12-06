require 'spec_helper'

describe WordifyCms::Blog::DisqusConfig do

  it "provides #public_key" do
    expect(subject).to respond_to(:api_key)
  end

  it "provides #client_secret" do
    expect(subject).to respond_to(:api_secret)
  end

  it "provides #access_token" do
    expect(subject).to respond_to(:access_token)
  end

  it "provides #blog_authorized" do
    expect(subject).to respond_to(:blog_authorized)
  end

  describe "#blog_authorized" do

    it "defaults to false" do
      expect(subject.blog_authorized).to be false
    end

  end

  it "validates the access_token for presence" do
    expect(subject).to validate_presence_of(:access_token)
  end

  it "validates the api_secret for presence" do
    expect(subject).to validate_presence_of(:api_secret)
  end

  it "validates api_key for presence" do
    expect(subject).to validate_presence_of(:api_key)
  end

end