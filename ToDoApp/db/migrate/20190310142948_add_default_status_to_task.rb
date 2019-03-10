class AddDefaultStatusToTask < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :tasks, :status, 'new'
		add_reference :tasks, :developer, index: true
  end
end
