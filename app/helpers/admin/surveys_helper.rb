module Admin::SurveysHelper
  def define_color_status_survey survey
    case survey.status
    when "ready"
      @color = "default"
      @class = "info"
      @icon = "unlock"
      @title = "CLICK để khóa bài thi"
    else
      @color = "danger"
      @class = "danger"
      @icon = "lock"
      @title = "CLICK để mở bài thi"
    end
  end
end
