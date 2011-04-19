class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :sign_data, :set_headers

  private

  require 'base64'
  require 'openssl'
  include OpenSSL
  include PKey

  def sign_data(data)
  private_key = OpenSSL::PKey::RSA.new(File.read("config/rsakey.pem"))
  sig = private_key.sign(OpenSSL::Digest::SHA1.new, data)
  return Base64.b64encode(sig).gsub(/\n/, '')
  end

  def set_headers(url, token)
  time = Time.now.to_i.to_s
  nonce = OpenSSL::BN.rand_range(2**64)
  data = "GET #{url} #{time} #{nonce}"
  sig = sign_data(data)
  return {'Authorization' => "AuthSub token=\"#{token}\" sigalg=\"rsa-sha1\" data=\"#{data}\" sig=\"#{sig}\""}
  end

  
end
