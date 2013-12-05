require 'spec_helper'

describe WordifyCms::Blog::CategoryController do
  wordify_routes

  let(:blog_category) do
    Fabricate(:blog_category)
  end

  before do
    controller.class_eval do
      def current_preferences
        Fabricate(:preference)
      end
    end
  end

  describe "GET" do

    describe "#index" do

      context "categories exists" do

        let(:categories) do
          [Fabricate(:blog_category), Fabricate(:blog_category)]
        end

        before do
          WordifyCms::Blog::Category.should_receive(:all).and_return(categories)

          get :index, :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "responses with all categories" do
          expect(subject).to have(categories.size).items
        end

      end

      context "no categories exists" do

        it_behaves_like "an empty response"

      end

    end

    describe "#show" do

      before do
        WordifyCms::Blog::Category.should_receive(:find).
                                    and_return(blog_category)

        get :show, :id => 12, :format => "json"
      end

      subject{ ActiveSupport::JSON.decode(response.body) }

      it "responses with category" do
        expect(subject["name"]).to eq blog_category.name
      end

    end
  end

  describe "POST" do

    describe "#create" do

      let(:category_params){ {:name => Faker::Lorem.word }}

      context "logged in user" do
        login_user

        it "is allowed to create a category" do
          expect do
            post :create, :blog_category => category_params, :format => "json"
          end.to change(WordifyCms::Blog::Category, :count).by(1)
        end

      end

      context "user that isnt logged in" do

        before do
          post :create, :blog_category => category_params, :format => "json"
        end

        it_behaves_like "handle not logged in user"
      end

    end
  end

  describe "PUT" do

    let(:new_params){ {:name => "New Category Name"} }

    describe "#update" do

      context "logged in user" do
        login_user

        before do
          WordifyCms::Blog::Category.should_receive(:find).
                                    and_return(blog_category)

          put :update, :id => 12, :blog_category => new_params,
              :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "is allowed to update the category" do
          expect(subject["name"]).to eq new_params[:name]
        end

      end

      context "user that isnt logged in" do
        before do
          put :update, :id => 12,
              :format => "json"
        end

        it_behaves_like "handle not logged in user"
      end

    end

  end

  describe "DELETE" do

    describe "#destroy" do
      context "logged in user" do
        login_user

        before do
          WordifyCms::Blog::Category.should_receive(:find).
                                      and_return(blog_category)
        end

        it "is allowed to delete a category" do
          action = lambda do
            delete :destroy, :id => 12, :format => "json"
          end

          expect{ action.call }.to change(WordifyCms::Blog::Category, :count).
                                    by(-1)
        end
      end

      context "user that isnt logged in" do

        before do
          delete :destroy, :id => 12, :format => "json"
        end

        it_behaves_like "handle not logged in user"
      end
    end
  end
end