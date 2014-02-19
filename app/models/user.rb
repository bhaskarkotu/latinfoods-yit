class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :institution, :email, :password, 
  :password_confirmation, :remember_me
  
  validates :password,:password_confirmation, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
  validates :first_name, :last_name, :institution, length: { in: 3..128 }
  validates_format_of :first_name, :last_name, :institution, :with => /^[\S]+$/ , message: 'No white space allowed'

  attr_accessor :role
end
