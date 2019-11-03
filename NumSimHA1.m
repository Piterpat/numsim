function NumSimHA1(n,e)

    for i=1:32
        code_d=(2*i)-e;
        A=zeros(n,n);
        A(1,:)=randi([0 1],1,n);
    
        code_b=dec2bin(code_d,6);
        
        for ii=2:n
            tot=A(ii-1,1:end-4)+A(ii-1,2:end-3)+A(ii-1,3:end-2)+A(ii-1,4:end-1)+A(ii-1,5:end)
            A(ii,3:end-2)=code_b(tot)
        end
        
        a = subplot(4,8,i);
        image(logical(A))
        colormap([0 0 0;1 1 1])
        
        a.Title.String = num2str(code_d);
        axis square
        set(gca,'visible','off')
    end
end