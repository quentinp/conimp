class Google
class Contact
attr_accessor :name
attr_accessor :email
def initialize(name, email)
@name = name
@email = email
end

def self.all(token)
# GET http://www.google.com/m8/feeds/contacts/default/base
require 'uri'
require 'net/http'
require 'net/https'
require 'rexml/document'

http = Net::HTTP.new('www.google.com', 443)
http.use_ssl = true
# by default Google returns 50? contacts at a time. Set max-results to very high number
# in order to retrieve more contacts
path = "/m8/feeds/contacts/default/base?max-results=10000"
url = "https://www.google.com/" + path
headers = set_headers(url, token)
resp, data = http.get(path, headers)

# extract the name and email address from the response data
xml = REXML::Document.new(data)
contacts = []
xml.elements.each('//entry') do |entry|
name = entry.elements['title'].text

gd_email = entry.elements['gd:email']
email = gd_email.attributes['address'] if gd_email
person = self.new(name, email)
contacts << person
end
return contacts
end

private

require 'base64'
require 'openssl'
include OpenSSL
include PKey

def self.sign_data(data)
private_key = OpenSSL::PKey::RSA.new(File.read("config/rsakey.pem"))
sig = private_key.sign(OpenSSL::Digest::SHA1.new, data)
return Base64.b64encode(sig).gsub(/\n/, '')
end

def self.set_headers(url, token)
time = Time.now.to_i.to_s
nonce = OpenSSL::BN.rand_range(2**64)
data = "GET #{url} #{time} #{nonce}"
sig = sign_data(data)
return {'Authorization' => "AuthSub token=\"#{token}\" sigalg=\"rsa-sha1\" data=\"#{data}\" sig=\"#{sig}\""}
end

end
end