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
    @explist.each do |e|
      bff += "#{e}\n"
    end
    bff += "} #{@name};"
  end
end
