require "statsd/instrument"

module Sensu
  module SIK
    module StatsD
      extend ::StatsD
    end
  end
end
