# subclass LinkRenderer to override tags and classes, to match
# twitter bootstrap 3.0.0 styling
module WillPaginateHelper

  class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
    # put pagination inside an unordered list tag.
    def html_container(html)
      tag(:ul, html, container_attributes)
    end

    # tag each page with a list item tag.
    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, rel: rel_value(page)))
      else
        tag(:li, tag(:span, page), class: "active")
      end
    end

    # override previous and next styles
    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page, class: classname))
      else
        tag(:li, tag(:span, text), class: "disabled")
      end
    end

    def gap
      text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
      tag(:li, tag(:span, text))
    end
  end
end