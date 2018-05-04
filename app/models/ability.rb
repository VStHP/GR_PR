class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    # return undefine_user if user.blank?
    if user.present?
      case user.permission
      when "admin"
        permission_admin
      when "trainer"
        permission_trainer user
      else
        permission_user user
      end
    else
      can :create, Registration
    end
  end

  private

  def permission_admin
    cannot [:read, :update], CourseUserLesson
    can :manage, :all
  end

  def permission_trainer user
    can :manage, [ Subject, Lesson, Link, Question, Answer ]
    can :manage, CourseSubject, course_id: user.courses.pluck(:id)
    can :read, CourseSubject, course_id: user.courses_join.pluck(:id)
    can :read, User
    can :read, Course, id: user.courses_join.pluck(:id)
    can [:update, :read], Course, user_id: user.id
    can %i(update change_avatar), user
  end

  def permission_user user
    can :show, User
    can %i(update change_avatar), user
    can :read, Course, id: user.courses_join.pluck(:id)
    can :read, CourseSubject, course_id: user.courses_join.pluck(:id)
    can :update, CourseUserLesson, id: user.course_user_lessons.pluck(:id)
    can :new, ExamLesson
    can :create, ExamLesson, course_user_lesson_id: user.course_user_lessons.pluck(:id)
    can :manage, ExamLesson, course_user_lesson_id: user.course_user_lessons.pluck(:id)
  end
  # def undefine_user
  #   can :create, Apply
  #   can :read, :all
  # end
end
