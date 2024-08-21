class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.integer :location_id
      t.integer :company_id
      t.string :delivery_method
      t.text :notes
      t.string :dispatched_consignment_note
      t.boolean :dispatched
      t.string :delivery_address1
      t.string :delivery_address2
      t.string :delivery_suburb
      t.string :delivery_state
      t.string :delivery_postcode
      t.string :delivery_country
      t.text :delivery_notes

      t.timestamps
    end
  end
end
