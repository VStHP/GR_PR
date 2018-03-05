module UsersHelper
  def define_color_permission user
    case user.permission
    when "admin"
      "success"
    when "trainer"
      "primary"
    else
      "warning"
    end
  end
end
