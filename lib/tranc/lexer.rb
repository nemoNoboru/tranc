require 'rly'

class TransLexer < Rly::Lex
  literals ';:{}().=[]"\','
  ignore " \t\n"
  token :ARROW , /->/
  token :POINTER, /\*+/
  token :OPERATOR, /[+\-*&%\/\=.]{1,2}/
  token :COMMENT, /#.+$/
  token :FN , /fn/
  token :NUMBER, /\d+/ do |t|
      t.value = t.value.to_i
      t
  end
  token :NAME , /\w+/
  token :NEWLINE, /\n/
  token :STRING , /".+"/
  # todo ignore comments
  # todo ignore spacios y newlines

end
