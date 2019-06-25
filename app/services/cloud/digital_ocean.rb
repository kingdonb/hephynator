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
    def create_cluster(node_count:)
      cluster = DropletKit::KubernetesCluster.new(
        name: cluster_name, region: 'sfo2',
        tags: ['hephynator'],
        node_pools: [ {
            name: cluster_name + '-1', size: 's-2vcpu-4gb', count: node_count
          } ],
        version: '1.14.1-do.4'
      )
      client.kubernetes_clusters.create(cluster)
    end
    def gimme_a_new_cluster(node_count:)
      raise ArgumentError, "create_cluster expects a node_count keyword parameter" unless node_count.present?
      create_cluster(node_count: node_count)
    end
    def cluster_name_generator
      generator = Concode::Generator.new
      generator.generate self.object_id
    end
    def cluster_name
      "hephynator--#{cluster_name_generator}"
    end
    def terminate_cluster(cluster_id)
      client.kubernetes_clusters.delete(id: cluster_id)
    end
    def kubeconfig(cluster_id)
      client.kubernetes_clusters.kubeconfig(id: cluster_id)
    end
  end
end
