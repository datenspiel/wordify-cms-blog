module WordifyCms
  module Blog

    class PostController < BaseController
      respond_to :json

      before_filter :find_blog_post, :only => [:update,
                                               :show,
                                               :destroy]
      def index
        @posts = WordifyCms::Blog::Post.all
        respond_with(@posts)
      end

      def create
        @blog_post = WordifyCms::Blog::Post.new(params[:blog_post])
        @blog_post.author = current_wordify_cms_account
        @blog_post.save
        respond_with(@blog_post)
      end

      def show
        respond_with(@blog_post)
      end

      def update
        @blog_post.update_attributes(params[:blog_post])
        respond_with(@blog_post) do |format|
          format.json do
            render :json => @blog_post
          end
        end
      end

      def destroy
        @blog_post.destroy
        respond_with(@blog_post)
      end

      private

      def find_blog_post
        @blog_post = WordifyCms::Blog::Post.find(params["id"])
      end

    end

  end
end