module GroupsHelper
  def set_class_post(index)
    if (index % 2).eql? 0
      'no-padding-right'
    else
      'no-padding-left'
    end
  end

  def value_name(params)
    if !params.nil? && params[:name]
      params[:name]
    end
  end

  def checked_categories(params)
    if !params.nil? && params[:categories]
      params[:categories]
    end
  end

  def selected_sort(params)
    if !params.nil? && params[:sort]
      params[:sort]
    else
      'newest'
    end
  end
end