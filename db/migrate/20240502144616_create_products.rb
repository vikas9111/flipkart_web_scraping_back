class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.json :details, default: {}
      t.decimal :price
      t.string :size
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
