class CreateContactDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_details do |t|
      t.string :name
      t.string :email
      t.integer :mobile_number
      t.text :description

      t.timestamps
    end
  end
end
