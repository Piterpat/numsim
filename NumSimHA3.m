function NumSimHA3(n,J,k)
    %% Precheck

    if mod(n,2)
        n=n+1;
    end
    %% Startvariablen
    %Anzahl der Kreise
    b=6;

    %Hilfskreis 
    R=0.25.*n;

    %Radius der Stoffgefüllten Kreise
    r=n./(2.*sqrt(b.*pi));

    %Kreismittelpunkte auf Hilfskreis über komplexe Zahlen
    %=> x^2 + y^2 = R^2
    poly=zeros(1,b+1);
    poly(1)=1;
    poly(end)=1;
    bm=roots(poly);
    bm=bm.*R;

    %Erstellen einer Matrix mit b Kreisen
    A=false(n);
    for i=1:b                    
        for x=1:n
            for y=1:n
                if sqrt( ((x -imag(bm(i)) -n/2) ^2)  + ((y -real(bm(i)) - n/2) ^2) )< r
                    A(x,y)= true;
                end
            end
        end
    end

    %diffundier Wahrscheinlichkeit
    p=0.5;
    
    %Hilfsmatrix für k=2 (Sparse für die Summation der Nachbarn)
    S = spdiags(ones(n,9),-4:4,n,n);
    %% Zeitschleife
    for i=1:J
        %% Darstellung k=1
        if k == 1
            image(A)
            axis square
            axis off
            colormap([1,1,1;0,0,0])
            drawnow
        end
        %% Darstellung k=2
        if k == 2
            %Summe der Spalte bestimmen
            s=sum(A);
            
            %Glättung durch Durschnitt der Nachbarschaft r=4
            s=(s*S)./9;
            
            %Plotting ohne Ränder
            plot(linspace(10,n-10,n-20),s(11:n-10))
            axis([0 n 0 n])
            yticks([0 n/2 n])
            yticklabels({'0%','50%','100%'})
            yticks([])
            drawnow
        end
        %% Update
            %% erste Drehungen 
            %Einteilung der Zellen über Erstellung eines 4D Tensor
            B=reshape(A,[2 n/2 2 n/2]);    

            %Drehung links und rechts rum über spiegelung und
            %transponieren
            C_r = B(2:-1:1,:,:,:);
            D_r = permute(C_r,[3 2 1 4]);
            E_r = reshape(D_r,[n n]);

            C_l = B(:,:,2:-1:1,:);
            D_l = permute(C_l,[3 2 1 4]);
            E_l = reshape(D_l,[n n]);

            %Erstellen von A mit Drehung einer Zelle zu
            %Wahrscheinlichkeit p
            P=rand(n/2)<p;
            P=repelem(P,2,2);
            A= (E_l&P) | (E_r&~P);
            %% zweite Drehungen
            %Berücksichtung der Randbedingung durch shiften der Matrix
            A=[A(:,2:end) A(:,1)];
            A=[A(2:end,:)
               A(1,:)];

            %Einteilung der Zellen über erstellung eines 4D Tensor
            B=reshape(A,[2 n/2 2 n/2]);    

            %Drehung links und rechts rum über spiegelung und
            %transponieren
            C_r = B(2:-1:1,:,:,:);
            D_r = permute(C_r,[3 2 1 4]);
            E_r = reshape(D_r,[n n]);

            C_l = B(:,:,2:-1:1,:);
            D_l = permute(C_l,[3 2 1 4]);
            E_l = reshape(D_l,[n n]);

            %Erstellen von A mit Drehung einer Zelle zu
            %Wahrscheinlichkeit p
            P=rand(n/2)<p;
            P=repelem(P,2,2);
            A= (E_l&P) | (E_r&~P);

            %Matrix zurück shiften
            A=[A(end,:) 
               A(1:end-1,:)];
            A=[A(:,end) A(:,1:end-1)];    
    end
end