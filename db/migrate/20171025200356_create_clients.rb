class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
