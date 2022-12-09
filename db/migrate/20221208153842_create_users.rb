class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login, null: false

      t.timestamps

      t.index :login, unique: true
    end
  end
end
