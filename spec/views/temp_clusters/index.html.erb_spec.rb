require 'rails_helper'

RSpec.describe "temp_clusters/index", type: :view do
  before(:each) do
    assign(:temp_clusters, [
      TempCluster.create!(),
      TempCluster.create!()
    ])
  end

  it "renders a list of temp_clusters" do
    render
  end
end
