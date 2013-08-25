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
  # this is taken from the will_paginate Link Renderer wiki.
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => WillPaginateHelper::BootstrapLinkRenderer
    end
    super *[collection_or_options, options].compact
  end

  # append a unique string for caching based on the page
  def page_cache(page)
    if page
      "/page-#{page}"
    else
      ""
    end
  end

end
