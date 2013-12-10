require 'spec_helper'

describe WordifyCms::Blog::Category do

  it "provides name attribute" do
    expect(subject).to respond_to(:name)
  end

  it "validates the name for presence" do
    expect(subject).to validate_presence_of(:name)
  end

  it "provides #to_liquid method" do
    expect(subject).to respond_to(:to_liquid)
  end

  describe "associations that" do

    it "has_many posts" do
      expect(subject).to have_many(:posts)
    end

  end

  describe "#to_liquid" do

    before(:all) do
      posts = [Fabricate.build(:blog_post)]
      posts.stub!(:desc).and_return(posts)
      subject.stub!(:posts).and_return(posts)
    end

    let(:to_liquid){ subject.to_liquid }

    it "has #name key" do
      expect(to_liquid).to have_key("name")
    end

    it "has the #posts key" do
      expect(to_liquid).to have_key("posts")
    end

    it "has the #post_count key" do
      expect(to_liquid).to have_key("post_count")
    end

    describe "the key #name" do

      it "is the category's name" do
        expect(to_liquid["name"]).to eq subject.name
      end

    end

  end

end