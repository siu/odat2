gem 'locale_rails'
gem 'gettext_activerecord'
gem 'gettext_rails'

desc "Update pot/po files."
task :updatepo do
  require 'gettext_rails/tools'  #HERE!
  GetText.update_pofiles("odat", Dir.glob("{app,lib,bin}/**/*.{rb,erb,rjs,prawn}"), "odat devel")
end

desc "Create mo-files"
task :makemo do
  require 'gettext_rails/tools'  #HERE!
  GetText.create_mofiles
end
