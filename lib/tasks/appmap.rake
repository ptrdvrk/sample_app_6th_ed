namespace :appmap do
  if defined?(AppMap)
    require 'appmap/rake/swagger_task'
    AppMap::Rake::SwaggerTask.new.tap do |task|
      task.project_name = 'Rails Sample App 6th Edition API'
      task.project_version = `git branch --show-current`.strip
    end
  end
end