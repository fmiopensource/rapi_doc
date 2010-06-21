require File.dirname(__FILE__) + '/../lib/rapi_doc.rb'

desc "Generate the API Documentation"
task :rapi_doc do
  # define your resources here
  resources = [   ResourceDoc.new("connection", "/api/connections", "api/connections_controller.rb" ),
                ResourceDoc.new("message", "/api/messages", "api/messages_controller.rb" ),
                ResourceDoc.new("subscription", "/api/subscriptions", "api/subscriptions_controller.rb" ),
                ResourceDoc.new("qrrent", "/api/qrrents", "api/qrrents_controller.rb" ),
                ResourceDoc.new("event", "/api/events", "api/events_controller.rb" )                ]

  # generate the apidoc
  RAPIDoc.new(resources)
end
