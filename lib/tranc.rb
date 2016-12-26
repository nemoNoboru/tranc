require_relative "tranc/lexer.rb"
require_relative "tranc/parser.rb"

class Tranc
  def load(filename)
    parser = TransParser.new(TransLexer.new)
    parser.parse(File.read(filename),true)
  end
end

Tranc.new.load('../to_parse/Statements.tc')
