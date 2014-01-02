module WordifyCms
  module Blog
    module Aliasable

      def blog_aliasing(record)
        lambda do |plugin|
          blog_config = WordifyCms::Blog::Configuration.last
          if blog_config.present?
            permalink_prefix = blog_config.blog_prefix_slug
          else
            permalink_prefix = ""
          end

          page_alias          = WordifyCms::PageAlias.new
          page_alias.subject  = record

          config = {
            :blog_config  => blog_config,
            :record       => record,
            :permalink_prefix => permalink_prefix,
            :page_alias   => page_alias

          }
          return plugin.send(:new).call(config)
        end
      end

    end
  end
end