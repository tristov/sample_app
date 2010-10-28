# == Schema Information
# Schema version: 20100923080738
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy

  has_many :relationships,
    :foreign_key => 'follower_id',
    :dependent => :destroy
  has_many :following, 
    :through => :relationships,
    :source => :followed

  has_many :reverse_relationships,
    :foreign_key => "followed_id",
    :class_name => "Relationship",
    :dependent => :destroy
  has_many :followers,
    :through => :reverse_relationships,
    :source => :follower

  validates_presence_of :name, :email
  validates_length_of   :name, :maximum => 50
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  #Automatically create the virtual attribute 'password_confirmation'.
  validates_confirmation_of :password
  validates_presence_of :password
  validates_length_of :password, :within => 6..40

  before_save :encrypt_password

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end
  
  #Authenticate
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

  def feed
    Micropost.all(:conditions => ["user_id = ?", id])
  end
  
private
  def encrypt_password
    unless password.nil?
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end
  end
  def encrypt(string)
    secure_hash("#{salt}#{string}")
  end
  def make_salt
    secure_hash("#{Time.now.utc}#{self.password}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
end
