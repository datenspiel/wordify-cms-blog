module WordifyCms
  module Blog
    class BaseController < WordifyController

      before_filter :authenticate_wordify_cms_account!, :only => [:create,
                                                                  :update,
                                                                  :destroy]
    end
  end
end