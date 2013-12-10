require 'spec_helper'

describe WordifyCms::Blog::DisqusConfigController do
  wordify_routes
  wordify_preferences

  let(:config){ Fabricate(:disqus_config) }

  describe "GET" do

    describe "#show" do

      context "as user that is logged in" do
        login_user

        before do
          WordifyCms::Blog::DisqusConfig.should_receive(:last).and_return(config)
          get :show, :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "responses with a disqus config item" do
          expect(subject).to_not be_empty

          expect(subject).to have_key("api_key")
          expect(subject).to have_key("api_secret")
          expect(subject).to have_key("access_token")

          expect(subject["api_key"]).to eq config.api_key
          expect(subject["api_secret"]).to eq config.api_secret
          expect(subject["access_token"]).to eq config.access_token
        end

      end

      context "as user that isnt logged in" do
        before do
          get :show, :format => "json"
        end

        it_behaves_like "user is not logged in"

      end

    end
  end

  describe "PUT" do

    describe "#update" do

      context "as user that is logged in" do

        login_user

        let(:new_params) do
          {
            :api_key      => "1234567",
            :api_secret   => "456789",
            :access_token => "zstzshksl123"
          }
        end

        before do
          WordifyCms::Blog::DisqusConfig.should_receive(:last).
                                          and_return(config)
          put :update, :blog_disqus_config => new_params,
              :format => "json"
        end

        subject{ ActiveSupport::JSON.decode(response.body) }

        it "is allowed to update config" do
          expect(subject["api_key"]).to eq new_params[:api_key]
          expect(subject["api_secret"]).to eq new_params[:api_secret]
          expect(subject["access_token"]).to eq new_params[:access_token]
        end

      end

      context "as user that isnt logged in" do

        before do
          put :update, :blog_disqus_config => {:access_token => "1234"},
              :format => "json"
        end

        it_behaves_like "user is not logged in"

      end

    end

  end

end