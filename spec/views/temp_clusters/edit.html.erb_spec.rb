require 'rails_helper'

RSpec.describe "temp_clusters/edit", type: :view do
  before(:each) do
    @temp_cluster = assign(:temp_cluster, TempCluster.create!())
  end

  it "renders the edit temp_cluster form" do
    render

    assert_select "form[action=?][method=?]", temp_cluster_path(@temp_cluster), "post" do
    end
  end
end
