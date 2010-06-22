require File.dirname(__FILE__) + '/../lib/rapi_doc.rb'

desc "Generate the API Documentation"
task :rapi_doc do

  begin
    yml = YAML::load(File.open("#{RAILS_ROOT}/config/documentation.yml"))
  rescue
    puts "Please ensure that you have created a documentation.yml file in your config directory"
  end
  if yml
    resources = []
    yml.keys.each do |key|
      resources << ResourceDoc.new(key, yml[key]["location"], yml[key]["controller_name"])
    end

    # generate the apidoc
    RAPIDoc.new(resources)
  end
end

