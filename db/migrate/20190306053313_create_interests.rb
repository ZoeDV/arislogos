class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.string :type

      t.timestamps
      
      t.index [:user_id, :post_id, :type], unique: true
    end
  end
end
