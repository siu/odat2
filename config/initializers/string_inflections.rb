module ActiveSupport

  module Inflector
    def namecase(word)
      word.split(' ').collect { |p| %w(de los las del).include?(p.downcase) ? p.downcase : p.capitalize}.join(' ')
    end
  end

  module CoreExtensions
    module String
      module Inflections
        def namecase
          Inflector.namecase(self)
        end
      end
    end
  end
end

