# This class holds methods about a doc.
class MethodDoc
  attr_accessor :scope, :content
  
  def initialize(type)
    @scope = type
    @variables = []
    @content = ""
  end
  
  
  def add_variable(name, value)
    if name == "param"
      @variables << value
      return
    end
    
    eval("@#{name}= \"#{value}\"")
  end
  
  def get_binding
    binding
  end
end
