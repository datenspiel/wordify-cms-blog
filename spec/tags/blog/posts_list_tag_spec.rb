require 'spec_helper'

describe WordifyCms::Blog::Tags::PostsList do
  mock_controller

  before do
    Fabricate(:page_dictionary)
    Fabricate(:blog_config)
  end

  let(:template) do
    <<-HTML
      {% blog %}
        {% for post in posts %}
          <h1> {{ post.title }} </h1>
          <section>
            {{ post.text }}
          </section>
        {% endfor %}
      {% endblog %}
    HTML
  end

  before do
    3.times do
      Fabricate(:blog_post)
    end
  end

  let(:posts){ WordifyCms::Blog::Post.all }

  it "" do
    options = { :controller => my_controller }
    compiled = Liquid::Template.parse(template).
                                render({},{:registers => options})
    posts.each do |post|
      expect(compiled).to include(post.title)
      expect(compiled).to include(post.text)
    end
  end

end