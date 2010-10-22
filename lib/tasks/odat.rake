namespace :odat do
  namespace :db do

    desc "Apply db tasks in custom databases, for example  rake odat:db:alter[db:migrate,test_es] applies db:migrate on the database defined as test_es in databases.yml"
    task :alter, [:task,:database] => [:environment] do |t, args|
      require 'activerecord'

      puts "Applying #{args.task} on #{args.database}"

      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[args.database])
      Rake::Task[args.task].invoke
    end

    desc "Sanitize comparative_report <-> report_field_template associations"
    task :sanitize_habtm => :environment do
      ComparativeReport.find(:all).each do |cr|
        ActiveRecord::Base.transaction do
          old_count = cr.report_field_template_ids.count

          saved_ids = cr.report_field_template_ids.uniq
          cr.comparative_report_field_template_assignments.destroy_all
          cr.report_field_template_ids = saved_ids

          new_count = cr.report_field_template_ids.count

          if cr.save
            puts "Updated #{cr.class.name}(#{cr.id}), from #{old_count} to #{new_count} relations" 
          end

        end
      end
    end

  end
end

