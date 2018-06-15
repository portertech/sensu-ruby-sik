module Sensu
  module SIK
    class Metrics
      def initialize(options={})
        @metrics = create_metrics_hash(options)
      end

      def [](key)
        @metrics[key]
      end

      def []=(key, value)
        @metrics[key] = value
      end

      def to_hash
        @metrics
      end

      def add_point(point={})
        @metrics[:points] ||= []
        @metrics[:points] << point
      end

      private

      def create_metrics_hash(options)
        handlers = options.fetch(:handlers, [])
        points = options.fetch(:points, [])
        metrics = {
          :handlers => handlers,
          :points => points
        }
      end
    end
  end
end
