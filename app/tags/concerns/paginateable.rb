module WordifyCms
  module Blog
    module Tags
      module Paginateable

        def initialize(tag_name, params, tokens)
          options       = json_to_hash.call([params.gsub(/\|{1,}/, ",")])
          pagination    = options.fetch("pagination", true)
          @per_page     = options.fetch("per_page",
                                        WordifyCms::Blog::Configuration.last.
                                                          per_page_pagination)
          @window_size  = 3
          super
        end

        def build_pagination(collection, context)
          params      = context.registers[:params]
          at_page     = params["page"] ? params["page"] : context['current_page']
          pagination  = Kaminari.paginate_array(collection).page(at_page).
                                  per(per_page).
                                  to_liquid.
                                  stringify_keys
          current_page = pagination['current_page']

          path = sanitize_path(context['fullpath'])

          if pagination['previous_page']
            pagination['previous'] = link(I18n.t('pagination.previous'),
                                          current_page - 1,
                                          path)
          end

          if pagination['next_page']
            pagination['next'] = link(I18n.t('pagination.next'),
                                      current_page + 1,
                                      path)
          end

          build_parts(pagination, current_page, path)
        end

        def build_parts(pagination, current_page, path)
          page_count          = pagination['total_pages']
          pagination['parts'] = []

          hellip_break = false

          if page_count > 1
            1.upto(page_count) do |page|
              if current_page == page
                pagination['parts'] << no_link(page)
              elsif page == 1
                pagination['parts'] << link(page, page, path)
              elsif page == page_count - 1
                pagination['parts'] << link(page, page, path)
              elsif page <= current_page - window_size or page >= current_page + window_size
                next if hellip_break
                pagination['parts'] << no_link('&hellip;')
                hellip_break = true
                next
              else
                pagination['parts'] << link(page, page, path)
              end

              hellip_break = false
            end
          end
          pagination
        end

        def sanitize_path(path)
          #_path = path.gsub(/page=[0-9]+&?/, '').gsub(/_pjax=true&?/, '')
          #_path = _path.slice(0..-2) if _path.last == '?' || _path.last == '&'
          #_path
          ""
        end

        def no_link(title)
          {
            'title'         => title,
            'is_link'       => false,
            'hellip_break'  => title == '&hellip;'
          }
        end

        def link(title, page, path)
          _path = %(#{path}#{path.include?('?') ? '&' : '?'}page=#{page})
          { 'title' => title, 'url' => _path, 'is_link' => true }
        end

        module_function :build_pagination,
                        :build_parts,
                        :sanitize_path,
                        :no_link,
                        :link
      end
    end
  end
end