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

    it "belongs to a link alias" do
      expect(subject).to belong_to(:link_alias)
    end

  end

  describe "#to_liquid" do

    before do
      posts = [Fabricate.build(:blog_post)]
      page_alias = double("WordifyCms::PageAlias")
      page_alias.stub(:url){ "/url"}
      posts.stub!(:desc).and_return(posts)
      subject.stub!(:posts).and_return(posts)
      subject.stub(:link_alias){ page_alias }
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

    it "has the #link key" do
      expect(to_liquid).to have_key("link")
    end

    describe "the key #name" do

      it "is the category's name" do
        expect(to_liquid["name"]).to eq subject.name
      end

    end

  end

  it_behaves_like "having a class definition", "blog post"

  describe "#link_alias" do

    before do
      #[:page_dictionary, :blog_config].each {|mock| Fabricate(mock) }
      Fabricate(:page_dictionary)
      Fabricate(:blog_config)
    end

    describe "url" do

      it "is the category name prefixed with blog config category main page" do
        category = Fabricate(:blog_category, :name => "RSpec")
        blog_config = WordifyCms::Blog::Configuration.last
        url ="/blog#{blog_config.category_page.url}/#{category.dasherized_name}"
        expect(category.link_alias.url).to eq url
      end

    end

  end



end