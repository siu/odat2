# encoding: UTF-8
require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic

  # Center
  belongs_to :center
  validates_presence_of :center_id
  
  # Medical Records
  delegate :medical_records, :to => :center

  def name_or_login
    self.name unless self.name.nil?
    self.login
  end

  def activate!
    self.active = true
    self.save!
  end

  def deactivate!
    self.active = false
    self.save!
  end

  def approve!
    self.approved = true
    self.save!
  end

  def unapprove!
    self.approved = false
    self.save!
  end

  def confirm!
    self.confirmed = true
    self.save!
  end

  def unconfirm!
    self.confirmed = false
    self.save!
  end

  def role?(role)
    self.role.to_sym == role
  end

end
