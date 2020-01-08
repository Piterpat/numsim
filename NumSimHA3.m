function NumSimHA3(n,m,b,k,q,F,g,c)
if n < m
    error("n must be bigger or equal to m")
end

M=zeros(m,n);

if b==1 || b==2
    M=[ones(m,1) M];
    if b==2
       M=[M ones(m,1)];
    end
end
    
end