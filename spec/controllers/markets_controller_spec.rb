require 'spec_helper'

describe MarketsController do

  def valid_session
    user = User.new(:email => 'testy@testerson.com')
    {:current_user => user,
      :user_session => {}
    }
  end

  describe "GET#index" do
    it "creates @markets" do
      get :index, {}, valid_session
      assigns(:markets).should be_present
    end
    it "populates @markets with Market objects" do
      get :index, {}, valid_session
      assigns(:markets).first.should be_an_instance_of Market
    end
    it "populates @total_count with an integer" do
      get :index, {}, valid_session
      assigns(:total_count).should > 0
    end
    it "populates @markets with Market objects" do
      get :index, {}, valid_session
      assigns(:markets).first.should be_an_instance_of Market
    end
  end
end
