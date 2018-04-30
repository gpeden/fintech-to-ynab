# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Import from bank accounts to YNAB'
task :import_to_ynab do
  sh "rails r './import.rb'"
end
