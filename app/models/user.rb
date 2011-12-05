require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :mediafiles

  attr_accessor :password

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  # new "sexy" validations
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 3..25 }, :uniqueness => true
  validates :level, :presence => true
  validates_numericality_of :level, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :level, :in => 1..9, :message => "can only be between 1 and 9."
  validates :email, :presence => true, :length => { :maximum => 100 },
    :format => EMAIL_REGEX, :confirmation => true

  # only on create, so other attributes of this user can be changed
  validates_length_of :password, :within => 3..25, :on => :create

  before_save :create_hashed_password
  after_save :clear_password

  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("users.last_name ASC, users.first_name ASC")

  attr_protected :hashed_password, :salt

  def name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(username="", password="")
    user = User.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end

  # The same password string with the same hash method and salt
  # should always generate the same hashed_password.
  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end

  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  private

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(username) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end

end
