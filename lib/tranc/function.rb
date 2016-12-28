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

class CMethod < CFunction
  def initialize(prefix,name,args,type,expressions)
    super(name,args,type,expressions)
    @prefix = prefix.value
  end

  def to_s
    buff = "#{@type} #{@prefix}#{@name.capitalize}( #{@prefix} *self#{' , ' unless @args}#{writeArgs} ) {\n"
    buff += writeBlock @expressions
    buff += "}"
  end
end
