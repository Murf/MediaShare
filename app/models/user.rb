class User < ActiveRecord::Base
  belongs_to :group
  belongs_to :craft
  has_many :items, :through => :inventories
  rolify
  before_save :check_role
  default_scope :order => "firstname ASC"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :group_id, :craft_id,:level, :as => :admin
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :group, :group_id, :craft, :craft_id, :level
  # attr_accessible :title, :body

  def fullname
    "#{firstname} #{lastname}"
  end

  private
  def check_role
    if !roles.any?
      add_role :user
    end
  end

end
