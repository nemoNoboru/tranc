require 'rly'

# TODO arreglar statements para ir haciendo una lista de strings
# TODO crear structs ya

class TransParser < Rly::Yacc
  rule 'statements: statements statement
                   | statement
                   ' do |sts,s,s2|
                    if s2
                      s.value << "#{s2.value}\n"
                      sts.value = s.value
                    else
                      sts.value = []
                      sts.value << "#{s.value}\n"
                    end
                    puts "ARRAY SAYS #{sts.value}"
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

  rule 'creation : NAME ":" type' do |c,n,_,t| c.value = "#{t.value} #{n.value};" ; puts c.value end

  rule 'type: NAME
            | POINTER NAME' do |t,pt,n| t.value = "#{n if n}#{pt.value}" end

  rule 'opun : expression OPERATOR
             | OPERATOR expression' do end

  rule 'opbin : expression OPERATOR expression' do end

  rule 'blockf : invok "{" expressions "}"' do end

  rule 'invok : NAME "(" iargs ")"' do end

  rule 'iargs : iargs "," expression
              | expression
              | empty' do end

  rule 'method : FN NAME "." NAME "(" args ")"   ARROW   type   "{" fblock "}"' do end

  rule 'function : FN NAME "(" args ")"   ARROW   type   "{" fblock "}"' do end

  rule 'args : args "," creation
             | creation
             | empty' do end

  rule 'fblock : fblock statement
              | statement
              | empty' do end

  rule 'object: NAME ":" "{" block "}"' do |o,n,_,_,b,_|
              o.value = CStruct.new(n.value,b.value)
            end

  rule 'block: block creation
             | creation' do |b, b2, c|
             if c
               b2.value << c.value
               b.value = b2.value
             else
               b.value = []
               b.value << b2.value
             end
           end

  rule 'empty: ' do end
end
