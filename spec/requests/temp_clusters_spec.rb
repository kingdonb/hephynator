require 'rails_helper'

RSpec.describe "TempClusters", type: :request do
  describe "GET /temp_clusters" do
    it "works! (now write some real specs)" do
      get temp_clusters_path
      expect(response).to have_http_status(200)
    end
  end
end
