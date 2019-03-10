class Project < ApplicationRecord

  # has_and_belongs_to_many :developers, class_name: 'Developer', association_foreign_key: 'user_id', join_table: 'assigned_projects_developers'
  has_many :tasks, dependent: :destroy

	belongs_to :admin

  validates :name, presence: :true, uniqueness: true
	def self.search(search)
    where("name LIKE ?", "%#{search}%").order("created_at DESC")
  end

  def developer_count
    tasks.pluck(:developer_id).uniq.count
  end
end
