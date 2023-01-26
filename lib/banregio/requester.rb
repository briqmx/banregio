require "rest-client"

module Banregio
  class Requester
    attr_reader :user, :password, :url, :p12

    def initialize(user, password, url, p12)
      @user = user
      @password = password
      @url = url
      @p12 = p12
    end

    def execute(payload)
      RestClient::Request.execute(
        headers: {
          content_type: "application/json; charset=UTF-8",
        },
        method: :post,
        user: user,
        password: password,
        url: url,
        ssl_client_cert: p12.certificate,
        ssl_client_key: p12.key,
        verify_ssl: OpenSSL::SSL::VERIFY_NONE,
        payload: payload.to_json
      )
    end
  end
end
