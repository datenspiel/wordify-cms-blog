require 'spec_helper'

describe WordifyCms::Blog::ConfigurationController do
  wordify_routes
  wordify_preferences

  # For Rabl templates
  render_views

  before do
    Fabricate(:page_dictionary)
  end

  let(:blog_config){ Fabricate(:blog_config) }

  describe "GET" do

    describe "#show" do

      context "as user that isnt logged in" do
        before { get :show, :format => "json" }

        it_behaves_like "user is not logged in"
      end

      context "as user that is logged in" do
        login_user

        before do
          WordifyCms::Blog::Configuration.should_receive(:last).
                                          and_return(blog_config)
          get :show, :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "responses with a blog configuration item" do

          expect(subject).to_not be_empty

          expect(subject).to have_key("blog_prefix_slug")
          expect(subject["blog_prefix_slug"]).to eq "/blog"
        end

      end
    end

  end

  describe "PUT" do

    describe "#update" do

      context "as user that isnt logged in" do

        before do
          put :update, :blog_config => {:blog_main_page_id => 12},
              :format => "json"
        end

        it_behaves_like "user is not logged in"

      end

      context "as user that is logged in" do
        login_user

        let(:blog_page){ Fabricate(:page, :slug => "/my_blog") }
        let(:detail_page){ Fabricate(:page, :slug => "/post_detail")}
        let(:category_page){ Fabricate(:page, :slug => "/blog_categories")}

        before do
          params = {
            :blog_main_page_id         => blog_page.id,
            :blog_post_detail_page_id  => detail_page.id,
            :category_page_id          => category_page.id
          }
          WordifyCms::Blog::Configuration.should_receive(:last).
                                          and_return(blog_config)
          put :update,
              :blog_config => params,
              :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "is allowed to update blog configuration" do
          expect(subject).to_not be_empty

          expect(subject).to have_key("blog_prefix_slug")
          expect(subject["blog_prefix_slug"]).to eq "/my_blog"
        end

      end

    end

  end

end