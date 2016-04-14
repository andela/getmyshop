class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :orders, :status, "Pending"
  end
end
