class Creation
  attr_accessor :var, :type

  def initialize(var,type)
    @var = var
    @type = type
  end

  def to_s
    "#{type} #{var};"
  end
end

class Invoker
  def initialize
    @creations = []
  end

  def resolve(object,function,iargs)
    t = ''
    @creations.each do |c|
      if c.var = object
        puts c.var
        t = c.type
        puts t
      end
    end
    return "#{t}#{function.value.capitalize}( &#{object.value.capitalize}#{' , ' unless iargs.value}#{iargs.value.join(" , ")} );\n"
  end

  def add(var,type)
    @creations << Creation.new(var,type)
    puts @creations
  end
end
