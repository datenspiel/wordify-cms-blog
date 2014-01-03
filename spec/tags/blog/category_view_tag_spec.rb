require 'spec_helper'

describe WordifyCms::Blog::Tags::CategoryView do
  mock_controller
  let(:category){ Fabricate(:blog_category) }
  let(:template) do
    <<-HTML
    {% blog_category %}
      <ul>
      {% for post in posts %}
        <li>{{ post.title }}</li>
      {% endfor %}
      </ul>
    {% endblog_category %}
    HTML
  end

  before do
    Fabricate(:page_dictionary)
    Fabricate(:blog_config)
    5.times { Fabricate(:blog_post, :category => category) }
  end

  it "renders all posts of the category" do
    options = { :controller => my_controller,
                :model_id   => category.id,
                :params     => {}  }
    compiled = Liquid::Template.parse(template).
                                render({}, :registers => options)
    post_line = "<li>#{WordifyCms::Blog::Post.last.title}</li>"
    expect(compiled).to include(post_line)

  end

end