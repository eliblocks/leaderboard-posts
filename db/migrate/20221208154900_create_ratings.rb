class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :value, null: false

      t.timestamps

      t.index [:user_id, :post_id], unique: true
    end
  end
end
