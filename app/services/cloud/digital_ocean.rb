module Cloud
  class DigitalOcean
    attr_reader :client

    def initialize
      # require 'droplet_kit'
      access_token = ENV.fetch('DO_API_ACCESS_TOKEN')
      @client = DropletKit::Client.new(access_token: access_token)
    end
  end
end
