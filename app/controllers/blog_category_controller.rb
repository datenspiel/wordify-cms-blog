module WordifyCms
  module Blog
    class CategoryController < BaseController

      respond_to :json

      before_filter :find_blog_category, :only => [:show, :update, :destroy]

      def index
        @categories = WordifyCms::Blog::Category.all
        respond_with(@categories)
      end

      def show
        respond_with(@blog_category)
      end

      def create
        @blog_category = WordifyCms::Blog::Category.new(params[:blog_category])
        @blog_category.save!
        respond_with(@blog_category)
      end

      def update
        @blog_category.update_attributes(params[:blog_category])
        respond_with(@blog_category) do |format|
          format.json do
            render :json => @blog_category
          end
        end
      end

      def destroy
        @blog_category.destroy
        respond_with(@blog_category)
      end

      private

      def find_blog_category
        @blog_category = WordifyCms::Blog::Category.find(params["id"])
      end

    end
  end
end