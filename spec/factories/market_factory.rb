# This will guess the User class
FactoryGirl.define do
  factory :market do
    fmid 22004647
    market_name "4th Street Farmers Market"
    website "http//www.4thstreetfarmersmarket.com"
    street "315 East 4th Street, Loveland, CO 80537, USA"
    city "Larimer"
    county nil
    state "Colorado"
    zip nil
    x -105.072649
    y 40.395732
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end