class CStruct

  attr_accessor :name , :explist

  def initialize(name,exp)
    @name = name
    @explist = exp
  end

  def to_s
    bff = ''
    bff +=
    "typedef struct #{@name} {\n"
    bff += writeBlock @explist
    bff += "} #{@name}"
  end
end
