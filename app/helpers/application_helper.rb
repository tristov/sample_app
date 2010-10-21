# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = t(:sample_app)
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end

  def logo
    image_tag("logo.png", :alt => t(:sample_app), :class => "round")
  end

  def en_flag
    image_tag("uk.gif", 
      :alt => "EN",
      :size => '20x10',
      :locale => 'en',
      :style => "padding: 0px"
    )
  end

  def mk_flag
    image_tag("macedonia.gif", 
      :alt => "MK",
      :size => '20x10',
      :locale => 'mk',
      :style => "padding: 0px"
    )
  end
 
end
