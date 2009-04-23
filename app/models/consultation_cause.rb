class ConsultationCause < ActiveRecord::Base
  default_scope :order => 'position ASC, name ASC'
end
