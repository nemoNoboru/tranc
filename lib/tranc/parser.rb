require 'rly'

# TODO parsear loops
# TODO Manejar expressions ya

class TransParser < Rly::Yacc
  rule 'statements: statements statement
                   | statement
                   ' do |a,b,c|
                    chain(a,b,c)
                    puts "ARRAY SAYS #{a.value}"
                 end

  rule 'statement : expression
                   | function
                   | creation
                   | object
                   | method
                   | COMMENT' do |s,e| s.value = e.value end

  rule 'expression : invok
                   | opun
                   | opbin
                   | NAME
                   | blockf
                   | NUMBER
                   | STRING
                   | "(" expression ")"
                   ' do end
  rule 'expressions : expressions expression
                    | expression' do end

  rule 'creation : NAME IS type' do |c,n,_,t| c.value = "#{t.value} #{n.value};" ; puts c.value end

  rule 'type: NAME
            | POINTER NAME' do |t,pt,n| t.value = "#{n if n}#{pt.value}" end

  rule 'opun : expression OPERATOR
             | OPERATOR expression' do end

  rule 'opbin : expression OPERATOR expression' do end

  rule 'blockf : invok OBLOCK expressions CBLOCK' do end

  rule 'invok : NAME "(" iargs ")"' do end

  rule 'iargs : iargs "," expression
              | expression
              | empty' do end

  rule 'method : FN NAME "." NAME "(" args ")"   ARROW   type   OBLOCK fblock CBLOCK' do end

  rule 'function : FN NAME "(" args ")"   ARROW   type   OBLOCK fblock CBLOCK' do end

  rule 'args : args "," creation
             | creation
             | empty' do end

  rule 'fblock : fblock statement
              | statement
              | empty' do end

  rule 'object: NAME IS OBLOCK block CBLOCK' do |o,n,_,_,b,_|
              o.value = CStruct.new(n.value,b.value)
            end

  rule 'block: block creation
             | creation' do |a, b, c|
             chain(a,b,c)
           end

  rule 'empty: ' do end
end
