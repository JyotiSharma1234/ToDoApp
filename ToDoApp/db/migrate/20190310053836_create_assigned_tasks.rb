class CreateAssignedTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_tasks do |t|
    	t.belongs_to :task, index: :true
      t.belongs_to :user, index: :true
    end
  end
end
