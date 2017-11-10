class AddEarnedToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :earned, :decimal
  end
end
