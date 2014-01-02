require 'spec_helper'

describe WordifyCms::Blog::Configuration do

  it "provides #blog_url_prefix" do
    expect(subject).to respond_to(:blog_prefix_slug)
  end

  it "provides #per_page_pagination" do
    expect(subject).to respond_to(:per_page_pagination)
  end

  describe "#per_page_pagination" do

    it "is 10 per default" do
      expect(subject.per_page_pagination).to eq 10
    end
  end

  describe "associations that" do

    it "belongs to main blog page" do
      expect(subject).to belong_to(:blog_main_page)
    end

    it "belongs to a blog post detail page" do
      expect(subject).to belong_to(:blog_post_detail_page)
    end

    it "belongs to a category page" do
      expect(subject).to belong_to(:category_page)
    end

  end

end