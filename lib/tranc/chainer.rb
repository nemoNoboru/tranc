def chain(a,b,c)
  if c
    b.value << c.value
    a.value = b.value
  else
    a.value = []
    a.value << b.value
  end
end
