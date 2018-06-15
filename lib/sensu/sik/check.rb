require "sensu/sik/client"

module Sensu
  module SIK
    class Check
      def initialize(client, options={})
        @client = client
        @check = create_check_hash(options)
      end

      def [](key)
        @check[key]
      end

      def []=(key, value)
        @check[key] = value
      end

      def to_hash
        @check
      end

      def save!
        @client.api_request(:put, "/checks/#{@check[:name]}", @check)
      end
      alias save save!

      private

      def create_check_hash(options)
        name = options.fetch(:name, "application")
        interval = options.fetch(:interval, 60)
        organization = options.fetch(:organization, "default")
        environment = options.fetch(:environment, "default")
        check = {
          :name => name,
          :interval => interval,
          :organization => organization,
          :environment => environment
        }
      end
    end
  end
end
