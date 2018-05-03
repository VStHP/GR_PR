class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.string :email
      t.text :description
      t.string :image_1
      t.string :image_2
      t.string :image_3
      t.string :image_4

      t.timestamps
    end
  end
end
