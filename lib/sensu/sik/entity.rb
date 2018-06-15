require "socket"
require "sensu/sik/client"

module Sensu
  module SIK
    class Entity
      def initialize(client, options={})
        @client = client
        @entity = create_entity_hash(options)
      end

      def [](key)
        @entity[key]
      end

      def []=(key, value)
        @entity[key] = value
      end

      def to_hash
        @entity
      end

      def save!
        @client.api_request(:put, "/entities/#{@entity[:id]}", @entity)
      end
      alias save save!

      private

      def create_entity_hash(options)
        id = options.fetch(:id, get_hostname)
        klass = options.fetch(:class, "application")
        organization = options.fetch(:organization, "default")
        environment = options.fetch(:environment, "default")
        {
          :id => id,
          :class => klass,
          :organization => organization,
          :environment => environment
        }
      end

      def get_hostname
        Socket.gethostname
      end
    end
  end
end
