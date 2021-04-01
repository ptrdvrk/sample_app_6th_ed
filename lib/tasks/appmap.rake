namespace :appmap do
  if defined?(AppMap)
    require 'appmap/swagger/rake_task'
    AppMap::Swagger::RakeTask.new.tap do |task|
      task.project_name = 'Rails Sample App 6th Edition API'
      task.project_version = `git branch --show-current`.strip
    end
  end
end