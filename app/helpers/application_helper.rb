module ApplicationHelper

  def release_date(movie)
    date = movie.release_date
    if date.respond_to? :strftime
      date.strftime("%b %d, %Y")
    else
      Time.parse(date).strftime("%b %d, %Y")
    end
  rescue ArgumentError
    ""
  end

  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => BootstrapLinkRenderer
    end
    super *[collection_or_options, options].compact
  end

  class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
    def html_container(html)
      tag(:ul, html, container_attributes)
    end

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, link(page, page, :rel => rel_value(page)), class: "active")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page, :class => classname))
      else
        tag(:li, link(text, page, :class => classname), class: "disabled")
      end
    end

  end

end
