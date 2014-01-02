Fabricator(:blog_post, :from => "WordifyCms::Blog::Post") do
  title { sequence(:title) { |n| "#{Faker::Lorem.words(4).join(" ")}"} }
  text  { sequence(:text) { Faker::Lorem.phrases.join("") } }
end

Fabricator(:account, :from => :"WordifyCms::Account") do
  email                 { sequence(:email) { |i| "user#{i}@example.com" } }
  password              "sample123456"
  password_confirmation "sample123456"
end

Fabricator(:preference, :from => :"WordifyCms::Preference") do

end

Fabricator(:blog_category, :from => "WordifyCms::Blog::Category") do
  name do
    sequence(:name) { Faker::Lorem.words(1).join("") }
  end
  posts(count: 3) do |attrs, i|
    Fabricate(:blog_post)
  end
  link_alias{ Fabricate(:page_alias) }

end

Fabricator(:disqus_config, :from => "WordifyCms::Blog::DisqusConfig") do
  api_key       "your_api_key"
  api_secret    "your_api_secret"
  access_token  "12345"
end

Fabricator(:html_pages, :from => "WordifyCms::HTMLPage") do
  name "Just a div"
  identifier "fabricator-page"
  template <<-LIQUID
    <div data-page-type-facade="fabricator-page.body"></div>
  LIQUID
end

Fabricator(:page, :from => "WordifyCms::Page") do
  title "My awesome blog start page"
  slug "/fooo"
  page_type { Fabricate(:html_pages) }
  site { Fabricate(:site) }
end

Fabricator(:blog_config, :from => "WordifyCms::Blog::Configuration") do
  blog_main_page { Fabricate(:page, :slug => "/blog") }
  blog_post_detail_page { Fabricate(:page, :slug => "/blog_view") }
  category_page { Fabricate(:page, :slug => "/category_page") }
end

Fabricator(:page_dictionary, :from => "WordifyCms::PageDictionary") do
end

Fabricator(:site, :from => :"WordifyCms::Site") do
  name { sequence(:name) { |i| "My wonderful Page #{i}" } }
end

Fabricator(:page_alias, :from => "WordifyCms::PageAlias") do
  url do
    sequence(:url){ |i| "/slug_#{i}" }
  end
  page { Fabricate(:page) }
end