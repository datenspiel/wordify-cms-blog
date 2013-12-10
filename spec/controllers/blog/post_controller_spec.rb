require 'spec_helper'

describe WordifyCms::Blog::PostController do
  wordify_routes

  before do
    controller.class_eval do
      def current_preferences
        Fabricate(:preference)
      end
    end
    Fabricate(:page_dictionary)
    Fabricate(:blog_config)
  end

  let(:blog_post) do
    Fabricate(:blog_post)
  end

  describe "GET" do

    describe "#index" do

      context "no posts exists" do

        it_behaves_like "an empty response"

      end

      context "posts exists" do

        let(:posts) do
          [Fabricate(:blog_post), Fabricate(:blog_post)]
        end

        before do
          WordifyCms::Blog::Post.should_receive(:all).and_return(posts)
          get :index, :format => "json"
        end

        subject { ActiveSupport::JSON.decode(response.body) }

        it "fetches all blog posts" do
          expect(subject).to have(posts.size).items
          subject.each_with_index do |item,index|
            expect(item).to have_key("title")
            expect(item).to have_key("text")
            expect(item["title"]).to eql(posts[index].title)
            expect(item["text"]).to eql(posts[index].text)
          end
        end

      end

    end

    describe "#show" do

      context "post exists" do

        before do
          WordifyCms::Blog::Post.should_receive(:find).and_return(blog_post)
          get :show, :id => 12, :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "responses with post" do
          expect(subject["title"]).to eq blog_post.title
          expect(subject["text"]).to eq blog_post.text
        end

      end
    end

  end

  describe "POST" do

    describe "#create" do

      let(:params) do
        {
          :title  => Faker::Lorem.words.join(","),
          :text   => Faker::Lorem.phrases.join(".")
        }
      end

      context "logged in user" do
        login_user

        it "is allowed to write a post" do
          create_post = lambda do
            post :create, :blog_post => params, :format => "json"
          end
          expect { create_post.call }.to change(WordifyCms::Blog::Post, :count)
                                          .by(1)
          create_post.call
          data = ActiveSupport::JSON.decode(response.body)
          expect(data).to_not be_empty
          expect(data).to have_key("title")
          expect(data).to have_key("text")
          expect(data["title"]).to eql params[:title]
          expect(data["text"]).to eql params[:text]
          expect(data["author_id"]).to include  controller.
                                                current_wordify_cms_account.id
        end


      end

      context "user that isnt logged in" do

        before do
          post :create, :blog_post => params, :format => "json"
        end

        it_behaves_like "user is not logged in"

      end

    end
  end

  describe "PUT" do

    describe "#update" do

      context "user that isnt logged in" do
        before do
          put :update, :id => 12, :format => "json"
        end

        it_behaves_like "user is not logged in"
      end

      context "user that is logged in" do
        login_user

        let(:new_params) do
          {
            :title => "Let's spec here!"
          }
        end

        before do
          WordifyCms::Blog::Post.should_receive(:find).and_return(blog_post)
          controller.current_wordify_cms_account
          put :update, :id => 12, :blog_post => new_params, :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "is allowed to update a post" do
          expect(assigns[:blog_post]).to eq blog_post
          expect(subject["title"]).to eq new_params[:title]
        end

      end

    end

  end

  describe "DELETE" do

    describe "#destroy" do

      context "user that isnt logged in" do

        before do
          delete :destroy, :id => 12, :format => "json"
        end

        it_behaves_like "user is not logged in"

      end

      context "user that is logged in" do
        login_user

        before do
          WordifyCms::Blog::Post.should_receive(:find).
                                and_return(blog_post)
        end

        it "is allowed to delete a post" do
          action = lambda do
            delete :destroy, :id => 12, :format => "json"
          end
          expect{ action.call }.to change(WordifyCms::Blog::Post, :count).by(-1)
        end

      end

    end

  end

end