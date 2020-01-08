%function NumSimHA4(n,m,b,k,q,F,g,c)
    %% function in
    n=20;
    m=5;
    b=1;
    k=1;
    q=3;
    F=1;
    g=6;
    c=1;
    %% 0
    %m x n      %matrix dimensions
    nm = n*m;
    [X,Y] = meshgrid(1:n,1:m);
    %% constant
    %b          %1 = linker und rechter Rand fest
                %2 = rechter Rand fest
    %k          %1 = konstante Kraft
                %2 = F./sqrt(1-((-q:q)/q).^2) um ?=?/2+?
    %q          %kraft bei 2q+1
    %F          %Betrag der Kraft
    
    %points=2.*q+1;
    midpoint=round(n/2+g);
    Fv=zeros(2*nm,1);
    if k == 1
        Fv(nm+midpoint-q:nm+midpoint+q)=F;
    else
        Fv(nm+midpoint-q:nm+midpoint+q)=F./sqrt(1-((-q:q)/q).^2);
    end
    

    A = speye(n);
    B = A(:,2:end);
    B(:,n) = 0;
    K = 2*A-B-B';
    N = kron(speye(m),K);
    
    A = speye(nm);
    B = A(:,n+1:end);
    B(:,nm) = 0;
    C = speye(n);
    C(nm,nm)=0;
    M = 2*A-B-B'-C-rot90(C,2);
    
    %Diagonalfedern D=D(Fx,v)=D(Fy,u)
    D = sparse(nm, nm);
    A = speye(nm)./(2.*sqrt(2));
    B = A(:,n+2:end);
    B(:,nm) = 0;
    C = A(:,n:end);
    C(:,nm) = 0;
    D = -B-B'+C+C';
    
    N = N+4.*A-B-B'-C-C';
    M = M+4.*A-B-B'-C-C';
    
    H=[N,D;D,M];
%     H=round(full(H),3);
%     
%     fid = fopen('Hmatrix.txt','wt');
%     for ii = 1:size(H,1)
%         fprintf(fid,'%g\t',H(ii,:));
%         fprintf(fid,'\n');
%     end
%     fclose(fid);

    %% processing
        %% pre simulation
        fig = figure();
        tic                                 
        %% calculation
        opts.SYM = true; %sagt, dass H eine symmetrische Matrix ist
        uv=linsolve(full(c.*H),Fv,opts);
        toc
        %% simulation
        plot(zeros(m),1:m, '.','MarkerSize',25,'Color','black')
        hold on
        plot(ones(m)*n+1,1:m, '.','MarkerSize',25,'Color','black')
        a = gca;
        a.YAxis.Direction = 'reverse';
%         plot(X,Y,'.','MarkerSize',15,'Color','blue')
        U = reshape(uv(1:nm),n,m)';
        V = reshape(uv(nm+1:end),n,m)';
        plot(X+U,Y+V,'.','MarkerSize',15,'Color','black')
        %from Force affected red (slow)
        XU=reshape((X+U)',1,nm);
        YV=reshape((Y+V)',1,nm);
        plot(XU(midpoint-q:midpoint+q),YV(midpoint-q:midpoint+q),'.','MarkerSize',15,'Color','red')
        hold off
        axis equal
        %xlim([-0.5,n+20])
        %ylim([-round(m/10),m+round(m/3)])
        axis off
        drawnow 

%end