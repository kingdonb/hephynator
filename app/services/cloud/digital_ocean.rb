module Cloud
  class DigitalOcean
    attr_reader :client

    def initialize
      # require 'droplet_kit'
      access_token = ENV.fetch('DO_API_ACCESS_TOKEN')
      @client = DropletKit::Client.new(access_token: access_token)
    end

    def find_cluster(id)
      client.kubernetes_clusters.find(id)
    end
    def create_cluster
      DropletKit::KubernetesCluster.new(name: "foo", region: "nyc1", ...)
    end
  end
end
