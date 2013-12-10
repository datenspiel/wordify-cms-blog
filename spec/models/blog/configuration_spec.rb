require 'spec_helper'

describe WordifyCms::Blog::Configuration do

  it "provides #blog_url_prefix" do
    expect(subject).to respond_to(:blog_prefix_slug)
  end

  describe "associations that" do

    it "belongs to main blog page" do
      expect(subject).to belong_to(:blog_main_page)
    end

    it "belongs to a blog post detail page" do
      expect(subject).to belong_to(:blog_post_detail_page)
    end

  end

end