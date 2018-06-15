require "sensu/sik/client"
require "sensu/sik/entity"
require "sensu/sik/check"
require "sensu/sik/metrics"

module Sensu
  module SIK
    class Event
      def initialize(client, options={})
        @client = client
        @event = create_event_hash(options)
      end

      def [](key)
        @event[key]
      end

      def []=(key, value)
        @event[key] = value
      end

      def to_hash
        @event
      end

      def save!
        if @event[:check]
          @client.api_request(:put, "/events/#{@event[:entity][:id]}/#{@event[:check][:name]}", @event)
        else
          @client.api_request(:post, "/events", @event)
        end
      end
      alias save save!

      private

      def create_event_hash(options)
        {
          :timestamp => options.fetch(:timestamp, Time.now.to_i),
          :entity => options[:entity],
          :check => options[:check],
          :metrics => options[:metrics]
        }.reject { |key, value| value.nil? }
      end
    end
  end
end
