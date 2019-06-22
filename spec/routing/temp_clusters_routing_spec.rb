require "rails_helper"

RSpec.describe TempClustersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/temp_clusters").to route_to("temp_clusters#index")
    end

    it "routes to #new" do
      expect(:get => "/temp_clusters/new").to route_to("temp_clusters#new")
    end

    it "routes to #show" do
      expect(:get => "/temp_clusters/1").to route_to("temp_clusters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/temp_clusters/1/edit").to route_to("temp_clusters#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/temp_clusters").to route_to("temp_clusters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/temp_clusters/1").to route_to("temp_clusters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/temp_clusters/1").to route_to("temp_clusters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/temp_clusters/1").to route_to("temp_clusters#destroy", :id => "1")
    end
  end
end
