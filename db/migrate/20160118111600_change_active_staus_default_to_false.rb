class ChangeActiveStausDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :users, :active_status, :boolean, default: false
  end
end
