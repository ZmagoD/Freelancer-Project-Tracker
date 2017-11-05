class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true
      t.datetime :due_date
      t.integer :status
      t.decimal :estimated_amount
      t.timestamps
    end
  end
end
