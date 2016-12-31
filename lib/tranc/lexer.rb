require 'rly'

class TransLexer < Rly::Lex
  token :COMMENT, /\/\/.*$/
  literals ';().=[]"\','
  token :OBLOCK , /do|{/
  token :CBLOCK , /end|}/
  token :IS , /:|is/
  ignore " \t\n"
  token :ARROW , /->|returns/
  token :POINTER, /\*+/
  token :OPERATOR, /[\[\]+\-*&%\/\=]{1,2}/
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
