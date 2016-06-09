module BlogHelper
  def link_to_previous(post_id)
    previous_post_id = post_id - 1
    if previous_post_id > 0
      link_to "Previous", "/blog/#{previous_post_id}", { :class => "btn left" }
    end
  end

  def link_to_next(post_id)
    next_post_id = post_id + 1
    link_to "Next", "/blog/#{next_post_id}", { :class => "btn right" }
  end

  def link_to_post(id)
    link_to "Read More...", "/blog/#{id}", { :class => "btn" }
  end
end
