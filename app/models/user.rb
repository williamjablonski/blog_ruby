class User < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :validatable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :registerable

  include Gravtastic
  gravtastic :default => "mm"

  before_save :create_image_url

  belongs_to :role

  validates_presence_of :name, :email
  validates_presence_of :password, :password_confirmation, :on => :create
  validates :email, email_format: true

  default_scope order(:name)

  def admin?
    role_id == 1
  end

  def create_image_url
    self.image_url = gravatar_url
  end

end
