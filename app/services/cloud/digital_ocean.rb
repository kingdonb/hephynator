module Cloud
  class DigitalOcean
    attr_reader :client

    def initialize
      # require 'droplet_kit'
      access_token = ENV.fetch('DO_API_ACCESS_TOKEN')
      @client = DropletKit::Client.new(access_token: access_token)
    end

    class NotCluster < StandardError; end
    def find_cluster(id)
      client.kubernetes_clusters.find(id)
    rescue DropletKit::Error => e
      t = e.message.split(': ')
      code = t[0].to_i
      data = JSON.parse(t[1])

      if code == 404
        return NotCluster.new('there is not a cluster here')
      else
        raise e
      end
    end
    def create_cluster(node_count:, kube_version:)
      cluster = DropletKit::KubernetesCluster.new(
        name: cluster_name, region: 'ams3',
        tags: ['hephynator'],
        node_pools: [ {
            name: cluster_name + '-1', size: 's-2vcpu-4gb', count: node_count
          } ],
        version: kube_version
      )
      client.kubernetes_clusters.create(cluster)
    end
    def gimme_a_new_cluster(node_count:, kube_version:)
      raise ArgumentError, "create_cluster expects a node_count keyword parameter" unless node_count.present?
      raise ArgumentError, "create_cluster expects a kube_version keyword parameter" unless kube_version.present?
      create_cluster(node_count: node_count, kube_version: kube_version)
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
    def kube_versions
      versions = client.kubernetes_options.all.versions
      versions.map do |v|
        {v.kubernetes_version => v.slug}
      end.reduce({}, :merge)
    end
  end
end
