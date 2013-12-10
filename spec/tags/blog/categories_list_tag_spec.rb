require 'spec_helper'

describe WordifyCms::Blog::Tags::CategoriesList do
  mock_controller

  before do
    Fabricate(:page_dictionary)
    Fabricate(:blog_config)
  end

  let(:template) do
    <<-HTML
      {% blog_categories %}
        <ul>
          {% for category in categories %}
            <li>{{ category.name }} ({{ category.post_count }})</li>
          {% endfor %}
        </ul>
      {% endblog_categories %}
    HTML
  end

  before do
    3.times do
      Fabricate(:blog_category)
    end
  end

  let(:categories){ WordifyCms::Blog::Category.all }

  it "" do
    options = {:controller => my_controller }
    compiled = Liquid::Template.parse(template).
                                render({}, :registers => options)

    categories.each do |category|
      template_line = <<-HTML
        <li>#{category.name} (#{category.posts.count})</li>
      HTML
      expect(compiled).to include(template_line)
    end
  end

end