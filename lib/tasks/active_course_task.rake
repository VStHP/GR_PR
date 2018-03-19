desc 'cron active course'
task cron_active_course: :environment do
  Course.cron_active_course
end
