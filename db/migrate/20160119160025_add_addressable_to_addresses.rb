class AddAddressableToAddresses < ActiveRecord::Migration
  def up
    add_column :addresses, :addressable_id,   :integer
    add_column :addresses, :addressable_type, :string
    add_index :addresses, :addressable_id

    Address.all.each do |address|
      address.addressable_id = address.intervention_id
      address.addressable_type = 'Intervention'
      address.save
    end

    remove_column :addresses, :intervention_id
  end

  def down
    add_column :addresses, :intervention_id, :integer
    add_index :addresses, :intervention_id

    Address.all.each do |address|
      address.intervention_id = address.addressable_id
      address.save
    end

    remove_column :addresses, :addressable_id
    remove_column :addresses, :addressable_type
  end
end
