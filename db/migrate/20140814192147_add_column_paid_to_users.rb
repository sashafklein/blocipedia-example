class AddColumnPaidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid, :boolean, default: false
  end
end
