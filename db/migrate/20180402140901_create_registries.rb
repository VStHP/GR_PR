class CreateRegistries < ActiveRecord::Migration[5.1]
  def change
    create_table :registries do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :position
      t.string :message
      t.text :cv_url
      t.string :status

      t.timestamps
    end
  end
end
