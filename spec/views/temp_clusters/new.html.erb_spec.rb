require 'rails_helper'

RSpec.describe "temp_clusters/new", type: :view do
  before(:each) do
    assign(:temp_cluster, TempCluster.new())
  end

  it "renders new temp_cluster form" do
    render

    assert_select "form[action=?][method=?]", temp_clusters_path, "post" do
    end
  end
end
