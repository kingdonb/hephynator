class TempClustersController < ApplicationController
  before_action :set_temp_cluster, only: [:show, :edit, :update, :destroy]

  # GET /temp_clusters
  # GET /temp_clusters.json
  def index
    @temp_clusters = TempCluster.all
  end

  # GET /temp_clusters/1
  # GET /temp_clusters/1.json
  def show
  end

  def kubeconfig
    @temp_cluster = TempCluster.find(params[:temp_cluster_id])
    cluster_name = @temp_cluster.cluster_name
    if cluster_name.present?
      send_data @temp_cluster.kubeconfig,
        filename: "#{cluster_name}-kubeconfig.yaml"
    else
      # 
    end
  end

  # GET /temp_clusters/new
  def new
    @temp_cluster = TempCluster.new
  end

  # GET /temp_clusters/1/edit
  def edit
  end

  # POST /temp_clusters
  # POST /temp_clusters.json
  def create
    @temp_cluster = TempCluster.new(temp_cluster_params)

    respond_to do |format|
      if @temp_cluster.save
        format.html { redirect_to @temp_cluster, notice: 'Temp cluster initialized. Create will start provisioning.' }
        format.json { render :show, status: :created, location: @temp_cluster }
      else
        format.html { render :new }
        format.json { render json: @temp_cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_clusters/1
  # PATCH/PUT /temp_clusters/1.json
  def update
    respond_to do |format|
      if @temp_cluster.update(temp_cluster_params)
        format.html { redirect_to @temp_cluster, notice: 'Temp cluster was successfully created.' }
        format.json { render :show, status: :ok, location: @temp_cluster }
      else
        format.html { render :edit }
        format.json { render json: @temp_cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_clusters/1
  # DELETE /temp_clusters/1.json
  def destroy
    @temp_cluster.destroy
    respond_to do |format|
      format.html { redirect_to temp_clusters_url, notice: 'Temp cluster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_cluster
      @temp_cluster = TempCluster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_cluster_params
      params.fetch(:temp_cluster, {}).permit(:node_count)
    end
end
