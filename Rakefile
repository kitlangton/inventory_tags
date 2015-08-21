# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "Delete all tags and colors"
task :destroy_all do
  Tag.destroy_all
  Color.destroy_all
end
