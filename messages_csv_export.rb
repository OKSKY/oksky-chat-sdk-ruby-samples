# coding: utf-8
# Exports Messages from all Rooms to a CSV file
# Uses AccessKey authentication to retrieve Messages
# from OK CHAT RAPI v1.

require 'oksky/chat'
require 'json'
require "csv"

OKSKY_ACCESSKEY = ""
OKSKY_FQDN = "" # solairo-co.ok-sky.com
EXPORT_FILEPATH = "" # /Users/solasola/Downloads/oksky-messages_#{Time.now.to_i}.csv

def get_messages(opt: {}, keys:[])
  return [] unless keys.count > 0
  result = []
  client = Oksky::Chat::Client.new(
    access_token: OKSKY_ACCESSKEY,
    endpoint: "https://#{OKSKY_FQDN}/rapi/v1"
  )

  client.where("messages").each do |m|
    result.push(m.message.values_at(*keys))
  end
  return result
end


result = get_messages(keys:["roomname", "username", "user_is_guest", "content", "kind", "created_at_unix", "deleted_at_unix"])

CSV.open(EXPORT_FILEPATH,'w') do |csv|
 result.map{|r| csv << r}
end
