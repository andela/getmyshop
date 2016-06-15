class AddArchiveAtToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :archived_at, :datetime
  end
end
