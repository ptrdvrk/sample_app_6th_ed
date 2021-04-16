namespace :appmap do
  BASE_BRANCH = 'remotes/origin/eager-loading'

  def debug
    ENV['DEBUG'] == 'true' || ENV['RAKE_DEBUG'] == 'true'
  end

  def depends_tasks
    require 'appmap_depends'

    desc 'Run minitest tests that are modified relative to the base branch'
    task :'test:diff' do
      raise "Task appmap:test:diff requires RAILS_ENV=test, got #{Rails.env}" unless Rails.env.test?
      
      modified_files = AppMap::Depends::GitDiff.new(base: BASE_BRANCH).modified_files
      files = AppMap::Depends::AppMapJSDepends.new.depends(modified_files)
      if files.blank?
        warn "Tests are up to date relative to #{BASE_BRANCH}"
      else
        warn "Some tests are out of date relative to #{BASE_BRANCH}:"
        warn files.join(' ')
        Rake::Task[:'test:prepare'].invoke
        $LOAD_PATH << "test"
        Rails::TestUnit::Runner.rake_run(files)
      end
    end
  end

  if %w[test development].member?(Rails.env)
    depends_tasks  
  end
end
