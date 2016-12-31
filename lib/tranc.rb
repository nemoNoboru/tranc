require_relative "tranc/lexer.rb"
require_relative "tranc/parser.rb"
require_relative "tranc/struct.rb"
require_relative "tranc/chainer.rb"
require_relative "tranc/function.rb"
require_relative "tranc/blocker.rb"
require_relative "tranc/invoker.rb"

class Tranc
  def load(filename)
    parser = TransParser.new(TransLexer.new)
    ret = parser.parse(File.read(filename),true)
    File.open("#{filename}.c","w") do |f|
      ret.each do |r|
        f.write(r)
      end
    end
  end
end

Tranc.new.load('../to_parse/Statements.tc')
