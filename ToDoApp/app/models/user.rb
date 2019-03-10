class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: {with: Devise.email_regexp}
  validates :email, presence: :true, uniqueness: true
  validates :name, presence: :true

	def is_admin?
    type == 'Admin'
  end

  def is_developer?
    type == 'Developer'
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%").order("created_at DESC")
  end
end
