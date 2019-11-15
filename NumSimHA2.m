function NumSimHA2(n,J,k)
    %% Ausgangsvariabeln    
    
    % Game matrix in groesse nxn
    % kann durch sparse ersetzt werden
    A=zeros(n,n);
    
    % Conway Game of Life Upadate Regel
    % 1. zeile für a_ij = 0, 2. Zeile für a_ij=1
    R = [0 0 0 1 0 0 0 0 0 0 ...
         0 0 0 1 1 0 0 0 0 0];
     
    %% Startkonfiguration 
    if k == 1
        A=randi([0 1], n, n);
        
    elseif k == 2
        A=repmat([0 1], n, ceil(n/2));
        A=A(1:n,1:n);
        A(floor(n/2),floor(n/2):floor(n/2)+1)=[0 0];
        
    elseif k == 3
        % Die hard Konfiguration
        F=[ 0 0 0 0 0 0 1 0;
            1 1 0 0 0 0 0 0;
            0 1 0 0 0 1 1 1];

        % Konfiguration mittig einsetzen
        [l,m]=size(F);
        A(floor(n/2)-floor(l/2)+1:floor(n/2)+ceil(l/2),...
            floor(n/2)-floor(m/2)+1:floor(n/2)+ceil(m/2))...
            =F;
        
    elseif k == 4
        % Gosper glider gun
        F=[ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1
            0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1
            1 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            1 1 0 0 0 0 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

        % Konfiguration oben links einsetzen
        [l,m]=size(F);
        A(1:l,1:m)=F;
        
    elseif k == 5
        
        % Asymmetric 1192-tick diehard
        F=[ 1 0 1 0 1 0 0 1 1 1 1 1 0 1 1 1 
            0 0 1 1 1 0 0 1 1 0 1 0 1 1 0 1 
            1 0 1 0 1 0 0 1 1 0 0 1 0 1 1 0 
            1 0 0 0 0 0 0 0 0 0 1 0 1 1 0 1 
            1 1 1 1 0 0 0 0 1 1 0 0 0 1 0 1 
            0 0 1 0 1 1 1 1 1 0 0 0 0 0 1 0 
            0 0 1 1 0 0 0 1 0 0 0 1 0 0 0 1 
            0 0 1 0 1 1 0 1 0 1 0 0 0 1 1 0 
            1 0 1 1 1 1 0 1 0 0 1 1 0 0 1 0 
            1 1 1 0 0 0 0 0 0 1 0 1 0 0 0 0 
            0 0 0 0 0 1 1 0 1 1 0 0 1 1 0 0 
            1 0 1 0 1 0 1 1 0 1 1 0 0 0 1 1 
            0 0 0 0 0 0 1 0 0 1 1 1 0 1 1 0 
            0 0 0 1 0 0 1 1 1 0 1 1 1 0 1 1 
            1 0 1 0 1 1 1 1 0 1 0 0 1 1 0 1 
            0 1 1 1 1 0 0 1 0 1 1 1 1 0 1 1  ];
        
        % Konfiguration mittig einsetzen
        [l,m]=size(F);
        A(floor(n/2)-floor(l/2)+1:floor(n/2)+ceil(l/2),...
        floor(n/2)-floor(m/2)+1:floor(n/2)+ceil(m/2))...
        =F;
        
    end
    
    %% Zeitschleife
    for t=1:J
        %% Darstellung
        image(logical(A))
        axis square
        axis off
        colormap([1,1,1;0,0,0])
        drawnow
        
        %% Update
        
        % Summationsmatrix
        S=zeros(n,n);
        for i=-1:1
            for j=-1:1
                S=S+circshift(A,[i j]);
            end
        end
        
        %Matrix um 10 erweitert an wo a_ij=1
        S=S+A.*10;
        
        %Auswertung
        A=R(S+1);
       
    end
    
end