module WordifyCms
  module RSpec

    module Controller

      def wordify_routes
        before do
          @routes = WordifyCms::Engine.routes
        end
      end

      def login_user
        before do
          entitled_user = Fabricate(:account, account_name: 'master')
          entitled_user.confirm!
          sign_in :wordify_cms_account, entitled_user#, :bypass => true
        end
      end
    end
  end
end