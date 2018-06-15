require "uri"
require "net/http"
require "json"

module Sensu
  module SIK
    class Client
      attr_reader :user

      def initialize(options={})
        @user = options.fetch(:user, "admin")
        @password = options.fetch(:password, "P@ssw0rd!")
        api_url = options.fetch(:api_url, "http://127.0.0.1:8080")
        @api_uri = URI(api_url)
      end

      def api_auth
        http = Net::HTTP.new(@api_uri.host, @api_uri.port)
        request = Net::HTTP::Get.new("/auth")
        request.basic_auth(@user, @password)
        response = http.request(request)
        if response.code == "200"
          data = JSON.parse(response.body)
          @api_token = data["access_token"]
        else
          raise "failed to authenticate!"
        end
      end

      def api_request(http_method, route, body=nil)
        api_auth unless @api_token
        http = Net::HTTP.new(@api_uri.host, @api_uri.port)
        request = case http_method
        when :get
          Net::HTTP::Get.new(route)
        when :post
          Net::HTTP::Post.new(route)
        when :put
          Net::HTTP::Put.new(route)
        end
        request["Accept"] = "application/json"
        request["Content-Type"] = "application/json"
        request["Authorization"] = @api_token
        request.body = JSON.dump(body) unless body.nil?
        http.request(request)
      end
    end
  end
end
