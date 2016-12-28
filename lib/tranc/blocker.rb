def writeBlock(block)
  buff = ''
  block.each do |e|
    buff += "\t#{e};\n"
  end
  return buff
end
