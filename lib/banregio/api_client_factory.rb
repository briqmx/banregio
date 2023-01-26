require "base64"

module Banregio
  class ApiClientFactory
    def build(url:, account:, customer:, basic_auth:, p12:)
      user = basic_auth.fetch(:user)
      password = basic_auth.fetch(:password)
      requester = Requester.new(user, password, url, build_p12(**p12))
      payloads = Payloads.new(account, customer)
      responder = Responder.new
      ApiClient.new(requester, payloads, responder)
    end

    def build_p12(cert_base64:, password:)
      OpenSSL::PKCS12.new(Base64.decode64(cert_base64), password)
    end

    private
    attr_reader :options
  end
end
