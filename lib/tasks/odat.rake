namespace :odat do
  namespace :db do

    desc "Apply db tasks in custom databases, for example  rake odat:db:alter[db:migrate,test_es] applies db:migrate on the database defined as test_es in databases.yml"
    task :alter, [:task,:database] => [:environment] do |t, args|
      require 'activerecord'

      puts "Applying #{args.task} on #{args.database}"

      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[args.database])
      Rake::Task[args.task].invoke
    end
  end
end

