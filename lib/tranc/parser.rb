require 'rly'

# TODO parsear loops
# TODO diferenciar mejor operadores unarios y binarios
# TODO crear una lookup table para metodos para poder generar codigo bien en las invocaciones

class TransParser < Rly::Yacc
  rule 'statements: statements statement
                   | statement
                   ' do |a,b,c|
                    chain(a,b,c)
                    puts "ARRAY SAYS #{a.value}"
                 end

  rule 'statement : expression
                   | function
                   | object
                   | method
                   | COMMENT' do |s,e| s.value = "#{e.value}; \n\n"end

  rule 'expression : invok
                   | opun
                   | opbin
                   | creation
                   | NAME
                   | blockf
                   | NUMBER
                   | STRING
                   | "(" expression ")"
                   ' do |a,b| a.value = b.value end
  rule 'expressions : expressions expression
                    | expression' do |a,b,c| chain(a,b,c) end

  rule 'method : FN NAME OPERATOR NAME "(" args ")" ARROW type OBLOCK expressions CBLOCK' do |f,_,prefix,_,name,_,args,_,_,type,_,exp,_|
    f.value = CMethod.new(prefix,name,args,type,exp) end

  rule 'creation : NAME IS type' do |c,n,_,t| c.value = "#{t.value} #{n.value}" ; puts c.value end

  rule 'type: NAME
            | POINTER NAME' do |t,pt,n| t.value = "#{n if n}#{pt.value}" end

  rule 'opun : expression OPERATOR
             | OPERATOR expression' do |a,b,c| a.value = "#{b.value}#{c.value}" end

  rule 'opbin : expression OPERATOR expression' do |a,b,c,d| a.value = "#{b.value}#{c.value}#{d.value}" end

  rule 'blockf : invok OBLOCK expressions CBLOCK' do end

  rule 'invok : NAME "(" iargs ")"' do |a,b,_,c,_| a.value = "#{b.value}(#{c.value.join(",")})" end

  rule 'iargs : iargs "," expression
              | expression
              | empty' do |a,b,_,c| chain(a,b,c) end


  rule 'function : FN NAME "(" args ")" ARROW type OBLOCK expressions CBLOCK' do |f,_,name,_,args,_,_,type,_,exp,_|
  f.value = CFunction.new(name,args,type,exp) end

  rule 'args : args "," creation
             | creation
             | empty' do |a,b,_,d| chain(a,b,d) end

  rule 'object: NAME IS OBLOCK block CBLOCK' do |o,n,_,_,b,_|
              o.value = CStruct.new(n.value,b.value)
            end

  rule 'block: block creation
             | creation' do |a, b, c|
             chain(a,b,c)
           end

  rule 'empty: ' do end
end
