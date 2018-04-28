class AddDefaultStatusRegistration < ActiveRecord::Migration[5.1]
  def change
  	change_column :registrations, :status, :integer, default: 0
  end
end
