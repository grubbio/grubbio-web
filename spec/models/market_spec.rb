require 'spec_helper'

describe Market, "#full_name" do
  subject { Market.first }

  its(:market_name) { should eq "4th Street Farmers Market" }
end