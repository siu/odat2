
desc "Update pot/po files."
task :updatepo do
  gem 'locale_rails'
  gem 'gettext_activerecord'
  gem 'gettext_rails'
  require 'gettext_rails/tools'  #HERE!
  GetText.update_pofiles("odat", Dir.glob("{app,lib,bin}/**/*.{rb,erb,rjs,prawn}"), "odat devel")
end

desc "Create mo-files"
task :makemo do
  gem 'locale_rails'
  gem 'gettext_activerecord'
  gem 'gettext_rails'
  require 'gettext_rails/tools'  #HERE!
  GetText.create_mofiles
end
