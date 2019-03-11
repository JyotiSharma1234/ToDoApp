class Developer < User
  has_many :tasks

  def projects
    Project.where(id: tasks.pluck(:project_id).uniq)
  end

  def new_tasks
    tasks.where(status: 'new')
  end

  def in_progress_tasks
    tasks.where(status: 'InProgress')
  end

  def done_tasks
    tasks.where(status: 'Done')
  end
end