class UpdateProfileColumns < ActiveRecord::Migration
  def up
    remove_column(:business_profiles, :customer_types)
    remove_column(:business_profiles, :producer_types)
    add_column(:business_profiles, :address1, :string)
    add_column(:business_profiles, :address2, :string)
    add_column(:business_profiles, :city, :string)
    add_column(:business_profiles, :state, :string)
    add_column(:business_profiles, :zip_code, :string)
  end

  def down
    add_column(:business_profiles, :customer_types, :string)
    add_column(:business_profiles, :producer_types, :string)
    remove_column(:business_profiles, :address1)
    remove_column(:business_profiles, :address2)
    remove_column(:business_profiles, :city)
    remove_column(:business_profiles, :state)
    remove_column(:business_profiles, :zip_code)
  end
end
