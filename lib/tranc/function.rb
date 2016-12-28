class CFunction
  def initialize(name,args,type,expressions)
    @name = name.value
    @type = type.value
    @args = args.value
    @expressions = expressions.value
  end

  def writeArgs
    @args.join(' , ') if @args
  end

  def to_s
    buff = "#{@type} #{@name}( #{writeArgs} ) {\n"
    buff += writeBlock @expressions
    buff += "}"
  end
end
