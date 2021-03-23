namespace :diagram do
  task :erd do
    system('erd')
    system('code', 'tmp/erd.pdf')
  end
end
