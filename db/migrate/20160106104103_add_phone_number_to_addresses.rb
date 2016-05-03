class AddPhoneNumberToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :phone_number, :string
  end
end
