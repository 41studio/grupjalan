module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = <<-HTML
    <div class="alert alert-danger">
      Please review the problems below:
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end