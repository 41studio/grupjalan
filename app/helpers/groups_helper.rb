module GroupsHelper
  def set_class_post(index)
    if (index % 2).eql? 0
      'no-padding-right'
    else
      'no-padding-left'
    end
  end
end