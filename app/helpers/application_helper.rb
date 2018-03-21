module ApplicationHelper
  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end

  def check_errors object, name_attribute
    "has-error" if object.errors.messages[name_attribute].present?
  end

  # def define_more_link_sidebar
  #   if current_user.admin?
  #     @link_to_subjects = admin_subjects_path
  #     @link_to_new_subject = new_admin_subject_path
  #   else
  #     @link_to_subjects = trainer_subjects_path
  #     @link_to_new_subject = new_trainer_subject_path
  #   end
  # end
end
