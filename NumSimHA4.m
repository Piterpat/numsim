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
    
    cd = 1./(2.*sqrt(2));       %für Diagonalfedern mit alpha=45 Grad
    HD = speye(n);              %Hauptdiagonale nxn
    ND = HD(:,2:end);           
    ND(n,n) = 0;                %Nebendiagonale nxn
    
    KHD = speye(m);             %Kronekerhauptdiagonale mxm
    KND = KHD(:,2:end);           
    KND(m,m) = 0;               %Kronekernebendiagonale mxm
           
    LOHD = 2.*HD+(4.*HD.*cd)-ND-ND';
    LOHDE= 2.*HD.*cd;
    LOHDE(nm,nm)=0;
    LOND = -ND-ND';
    LO = kron(KHD,LOHD)-LOHDE-rot90(LOHDE,2)+kron(KND+KND',LOND);
    
    RUHD = 2.*HD+(4.*HD.*cd);
    RUHDE= 2.*HD.*cd;
    RUHDE(nm,nm)=0;
    RUND = -ND-ND'-HD';
    RU = kron(KHD,RUHD)-RUHDE-rot90(RUHDE,2)+kron(KND+KND',RUND);
    
    DND = ND' - ND;
    D = kron(KND,DND)+kron(KND',DND');
    
    LO=sparse(nm,nm);
    RU=sparse(nm,nm);
    
    H=[LO,D;D,RU];
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
%         opts.SYM = true; %sagt, dass H eine symmetrische Matrix ist
        uv=linsolve(full(c.*H),Fv);
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