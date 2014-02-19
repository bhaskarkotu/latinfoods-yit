class Contact < ActiveRecord::Base
  attr_accessible :email, :message, :name
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :message
  validates_format_of :email , :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
