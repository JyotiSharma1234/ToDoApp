class AddAdminToProject < ActiveRecord::Migration[5.2]
  def change
  	add_reference :projects, :admin, foreign_key: true
  end
end
