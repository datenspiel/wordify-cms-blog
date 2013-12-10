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

  it "provides perma_link" do
    expect(subject).to respond_to(:permalink)
  end

  it "validates the title for presence" do
    expect(subject).to validate_presence_of(:title)
  end

  it "validates the text for presence" do
    expect(subject).to validate_presence_of(:text)
  end

  it "provides #to_liquid method" do
    expect(subject).to respond_to(:to_liquid)
  end

  it "provides a #class_definition" do
    expect(subject).to respond_to(:class_definition)
  end

  describe "has associations that" do

    it "belongs to a category" do
      expect(subject).to belong_to(:category)
    end

    it "belongs to an author" do
      expect(subject).to belong_to(:author)
    end

    it "belongs to a page alias" do
      expect(subject).to belong_to(:permalink_alias)
    end

  end

  describe "#to_liquid" do

    before do
      subject.title = Faker::Lorem.words(3).join(",")
      subject.text  = Faker::Lorem.paragraph
      subject.category = Fabricate.build(:blog_category)
    end

    let(:to_liquid){ subject.to_liquid }

    it "has #title key" do
      expect(to_liquid).to have_key("title")
    end

    it "has #text key" do
      expect(to_liquid).to have_key("text")
    end

    it "has #category key" do
      expect(to_liquid).to have_key("category")
    end

    describe "the key #title" do

      it "is the blog post's title" do
        expect(to_liquid["title"]).to eq subject.title
      end

    end

    describe "the key #text" do

      it "is the blog post's text" do
        expect(to_liquid["text"]).to eq subject.text
      end

    end

    describe "the key #category" do

      it "is the blog posts category association" do
        expect(to_liquid["category"]).to have_key("name")
        expect(to_liquid["category"]["name"]).to eq subject.category.name
      end

    end

    describe "the key #link" do

      before do
        Fabricate(:page_dictionary)
        Fabricate(:blog_config)
      end

      let(:post){ Fabricate(:blog_post) }
      let(:to_liquid){ post.to_liquid }

      it "is the posts permalink" do
        expect(to_liquid["link"]).to eq post.permalink_alias.url
      end

    end

  end

  describe "#class_definition" do

    let(:class_definition){ subject.class_definition }

    it "provides #name" do
      expect(class_definition).to respond_to(:name)
    end

    describe "#name" do

      it "is the blog post class name" do
        expect(class_definition.name).to eq subject.class.name
      end

    end

  end

  describe "#permalink_alias" do
    before do
      [:page_dictionary, :blog_config].each {|mock| Fabricate(mock) }
    end

    context "no permalink attribute given" do

      it "is generated from the blog post title" do
        blog_post     = Fabricate(:blog_post)
        blog_post.save
        permalink_url = WordifyCms::Blog::Configuration.last.blog_prefix_slug
        permalink_url += "/#{blog_post.title.gsub(/[\s]+/, "_").dasherize}"

        expect(blog_post.permalink_alias).to_not be nil
        expect(blog_post.permalink_alias.url).to eq permalink_url
      end

    end

    context "permalink attribute given" do

      it "is taken from the permalink attribute" do
        blog_post     =   Fabricate(:blog_post, :permalink => "/my/hello-world")
        permalink_url =   WordifyCms::Blog::Configuration.last.blog_prefix_slug
        permalink_url +=  "#{blog_post.permalink}"

        expect(blog_post.permalink_alias.url).to eq permalink_url
      end

    end

  end

end