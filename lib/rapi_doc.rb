require 'erb'
require 'fileutils'
require File.dirname(__FILE__) + '/doc_util.rb'
require File.dirname(__FILE__) + '/resource_doc.rb'
#
class RAPIDoc

  # Initalize the ApiDocGenerator
  def initialize(resources)
    puts "Apidoc started..."
    @resources = resources
    generate_templates!
    move_structure!
    puts "Finished."
  end

  # Iterates over the resources creates views for them.
  # Creates an index file
  def generate_templates!

    @resources.each do |r|
      r.parse_apidoc!
      r.generate_view!(@resources)
    end
    generate_index!
  end

  # generate the index file for the api views
  def generate_index!
    template = ""
    File.open(File.join(File.dirname(__FILE__), '..', 'templates', 'index.html.erb.erb')).each { |line| template << line }
    parsed = ERB.new(template).result(binding)
    File.open(File.join(File.dirname(__FILE__), '..', 'structure', 'views', 'apidoc',"index.html"), 'w') { |file| file.write parsed }
  end

  # TODO
  def make_backups!
    puts "TODO"
  end

  def move_structure!
    target_folder = "#{RAILS_ROOT}/public/apidoc/"

    if (!File.directory?(target_folder))
      Dir.mkdir(target_folder)
    end

    Dir.new(File.join(File.dirname(__FILE__), '..', '/structure/views/apidoc/')).each do |d|
      if d =~ /^[a-zA-Z]+\.html$/ # Only want to copy over the .html files, not the .erb templates
        FileUtils.cp  File.join(File.dirname(__FILE__), '..', '/structure/views/apidoc/' + d), target_folder + d
      end

      #Clean up the no longer needed files
      filepath = "#{File.dirname(__FILE__)}/../structure/views/apidoc/#{d}"
      File.delete(filepath) unless File.directory?(filepath)
    end


  end

end

