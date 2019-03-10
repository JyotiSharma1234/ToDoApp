class Developer < User
  has_many :tasks

  def projects
    Project.where(id: tasks.pluck(:project_id).uniq)
  end
end