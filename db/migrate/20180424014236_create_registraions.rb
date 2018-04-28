class CreateRegistraions < ActiveRecord::Migration[5.1]
  def change
    create_table :registraions do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :position
      t.text :message
      t.string :cv_url
      t.integer :status

      t.timestamps
    end
  end
end
