function NumSimHA1(n,e)

    %S Matrix um s zu ermitteln. 
    if n > 5
        S = sparse([1:n 2:n 3:n 1:(n-1) 1:(n-2) 1 1 2 n n-1 n], [1:n 1:(n-1) 1:(n-2) 2:n 3:n n-1 n n 1 1 2], 1, n, n);
        
    else
        S = ones(n);
    end
    
    for R=e:2:(62+e)
        %Regelliste definieren (in Binaercode)
        Regel = bitget(R,1:6);
        
        %anfaengliche Zufallszeile
        zeile = randi([0,1],1,n);
        %Matrix fuer spaetere Darstellung
        M = zeros(n);
        M(1,:) = zeile;
        
        %Matrix um indexverschiebung anzuwenden (0 -> 1)
        ONES = ones(1,n);
        
        %Iteration durch alle 'Zeitschritte'
        for x = 1:(n-1)
            %Summen der Nachbarschaften ermitteln
            s = zeile*S;
            
            %Regel anwenden
            zeile = Regel(s+ONES);
            
            %Ergebnis Speichern
            M(x,:) = zeile;
        end
        
        %Subplot erstellen
        subplot(4,8,(R+e)/2+1-e)
        image(logical(M))
        axis off
        title(int2str(R))
    end
    
    map = [1,1,1;0,0,0];
    colormap(map)
    
end