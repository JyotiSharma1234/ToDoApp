class Task < ApplicationRecord
  belongs_to :project
  belongs_to :developer
  validates :name, presence: :true, uniqueness: {scope: :project_id,  case_sensitive: false}
  validates :status, inclusion: { in: %w(new InProgress Done),
    message: "%{value} is not a valid status" }
  validates :developer, :project, presence: :true
end
