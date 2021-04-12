namespace :appmap do
  BASE_BRANCH = 'remotes/origin/eager-loading'

  def debug
    ENV['DEBUG'] == 'true' || ENV['RAKE_DEBUG'] == 'true'
  end

  def swagger_tasks
    require 'appmap_swagger'
    AppMap::Swagger::RakeTask.new.tap do |task|
      task.project_name = 'Rails Sample App 6th Edition API'
      task.project_version = `git branch --show-current`.strip
    end

    AppMap::Swagger::RakeDiffTask.new(:'swagger:diff', %i[base swagger_file]).tap do |task|
      task.base = BASE_BRANCH
    end
  end

  def depends_tasks
    AppMap::Depends::DiffTask.new.define
    AppMap::Depends::ModifiedTask.new.define

    desc 'Run minitest tests that are modified relative to the base branch'
    task :'test:diff' => :'test:prepare' do
      task = AppMap::Depends::DiffTask.new
      task.base = BASE_BRANCH
      files = task.files
      if Rake.verbose == true
        warn 'Out of date tests:'
        warn files.join(' ')
      end
      $: << "test"
      Rails::TestUnit::Runner.rake_run(files)
    end
  end

  if %w[test development].member?(Rails.env)
    swagger_tasks
    depends_tasks  
  end
end
