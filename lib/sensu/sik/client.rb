require "socket"

module Sensu
  module SIK
    class Client
      attr_reader :user

      def initialize(options={})
        @user = options.fetch(:user, "admin")
        @password = options.fetch(:password, "P@ssw0rd!")
      end

      def create_entity(options={})
        id = options.fetch(:id, get_hostname)
        klass = options.fetch(:class, "application")
        organization = options.fetch(:organization, "default")
        environment = options.fetch(:environment, "default")
        entity = {
          :id => id,
          :class => klass,
          :organization => organization,
          :environment => environment
        }
      end

      private

      def get_hostname
        Socket.gethostname
      end
    end
  end
end
