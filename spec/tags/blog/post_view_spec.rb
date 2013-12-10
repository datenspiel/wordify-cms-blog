require 'spec_helper'

describe WordifyCms::Blog::Tags::PostView do
  mock_controller

  before do
    Fabricate(:page_dictionary)
    Fabricate(:blog_config)
  end

  let(:post){ Fabricate(:blog_post) }
  let(:template) do
    <<-HTML.strip_heredoc
      {% blog_post_view %}
      <article>
        <h1>{{ post.title }}</h1>
        <div>
          {{ post.text }}
        </div>
      </article>
      {% endblog_post_view %}
    HTML
  end

  context "blog post exists" do

    it "renders the template with all blog post entries" do
      options = {
        :controller       => my_controller,
        :model_collection => post.class_definition.name.tableize,
        :model_id         => post.id
      }
      compiled = Liquid::Template.parse(template).render({},:registers => options)
      expect(compiled).to include(%Q{<h1>#{post.title}</h1>})
    end

  end

  context "blog post didn not exist" do

    it "renders an empty String" do
      options ={
        :model_collection => post.class_definition.name.tableize,
        :model_id         => "12345676543"
      }
      compiled = Liquid::Template.parse(template).
                                  render({},:registers => options)
      compiled.gsub!(/\n/, "")
      expect(compiled).to eq ""
    end

  end

end