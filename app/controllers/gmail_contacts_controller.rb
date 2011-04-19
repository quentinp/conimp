class GmailContactsController < ApplicationController
require 'uri'
require 'net/http'
require 'net/https'
require 'rexml/document'

def init
callback_url = "http://hollow-frost-252.heroku.com/authsub"
next_param = URI.escape(callback_url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

scope_param = "https%3A%2F%2Fwww.google.com%2Fm8%2Ffeeds%2F"
secure_param = "1"
session_param = "1"
root_url = "https://www.google.com/accounts/AuthSubRequest"
query_string = "?scope=#{scope_param}&session=#{session_param}&secure=#{secure_param}&next=#{next_param}"
redirect_to root_url + query_string
end

def authsub
token = params[:token] # received the single-use authsub token, exchange for authsub session token
url = "https://www.google.com/accounts/AuthSubSessionToken"
headers = set_headers(url, token)

http = Net::HTTP.new('www.google.com', 443)
http.use_ssl = true
path = '/accounts/AuthSubSessionToken'
resp, data = http.get(path, headers)

if resp.code == "200"
token = ''
data.split.each do |str|
if not (str =~ /Token=/).nil?
token = str.gsub(/Token=/, '')
end
end
redirect_to "http://hollow-frost-252.heroku.com/gmail_contacts/import?token#{token}"
else
redirect_to "http://hollow-frost-252.heroku.com/"
end
end

def import
@contacts = Google::Contact.all(params[:token])
end

end

