Fabricator(:blog_post, :from => "WordifyCms::Blog::Post") do
  title Faker::Lorem.words(4)
  text  Faker::Lorem.phrases
end

Fabricator(:account, :from => :"WordifyCms::Account") do
  email                 { sequence(:email) { |i| "user#{i}@example.com" } }
  password              "sample123456"
  password_confirmation "sample123456"
end

Fabricator(:preference, :from => :"WordifyCms::Preference") do

end

Fabricator(:blog_category, :from => "WordifyCms::Blog::Category") do
  name Faker::Lorem.words(1)
end
