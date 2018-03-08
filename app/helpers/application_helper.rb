module ApplicationHelper
  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end

  def check_errors object, name_attribute
    "has-error" if object.errors.messages[name_attribute].present?
  end
end
