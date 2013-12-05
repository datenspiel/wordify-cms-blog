module WordifyCms
  class BlogListTag < Tag

    register_tag "blog_list"

    def render(context)
      p "context"
      p context.registers
      p "-----"

      page    = context.registers[:page]
      params  = context.registers[:params]
      page_count = params[:page] ? params[:page] : 1

      return <<-HTML.strip_heredoc
        <p> Funny tagging at #{page_count}</p>
      HTML
    end

  end
end