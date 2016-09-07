class UpdateInitialUsers < ActiveRecord::Migration
  def change
    User.all.customers.each do |customer|
      customer.professions << Profession.find_by_slug("serrurerie")
      customer.save
    end
  end
end
