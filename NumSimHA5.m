%function NumSimHA4(n,m,K)
    %% function
    n = 120;
    m = 80;
    K = 500;
    %% Constants
        c = 1;
        c_in = 10;
        tau = 2/3;

        e = zeros(1,2,9);
        e(:,:,1) = [1 0];
        e(:,:,2) = [0 1];
        e(:,:,3) = [-1 0];
        e(:,:,4) = [0 -1];
        e(:,:,5) = [1 1];
        e(:,:,6) = [-1 1];
        e(:,:,7) = [-1 -1];
        e(:,:,8) = [1 -1];
        e(:,:,9) = [0 0];

        w = ones(1,1,9);
        w(:,:,1:4) = 1/9;
        w(:,:,5:8) = 1/36;
        w(:,:,5:9) = 4/9;
        
        [X,Y] = meshgrid(1:n,1:m);        
    %% t=0
        f = zeros(m,n,9);
        f(:,:,[1,2,3,4]) = 1/9;
        f(:,:,[5,6,7,8]) = 1/36;

        rho = sum(f,3);
        u = (1./rho) .* ...
            (f(:,:,1)-f(:,:,3)...
                +(1/sqrt(2)).*(sum(f(:,:,[5,8]),3)-sum(f(:,:,[6,7]),3)));
        v = (1./rho) .* ...
            (f(:,:,2)-f(:,:,4)...
                +(1/sqrt(2)).*(sum(f(:,:,[5,6]),3)-sum(f(:,:,[7,8]),3)));
        u(:,:,2) = v;
        
        u_abs = sum(u,3);
        U = max(max(u_abs));
        fig = figure();
            %% Calculation
            for t = 1:K
                %% Plotting
                if ~ishghandle(fig)
                    break
                end
                u_abs = sum(urohy,3);
                contourf(X,Y,u_abs,'LineStyle','none','LevelList',linspace(0,U,50));
                caxis([0 U]);
                colormap jet;
                drawnow
%                 %% Calculate Density und Velocity
%                 rho = sum(f,3);
%                 u = (1./rho).*...
%                 (f(:,:,1)-f(:,:,3)...
%                     +(1/sqrt(2)).*(sum(f(:,:,[5,8]),3)-sum(f(:,:,[6,7]),3)));
%                 v = (1./rho).*...
%                 (f(:,:,2)-f(:,:,4)...
%                     +(1/sqrt(2)).*(sum(f(:,:,[5,6]),3)-sum(f(:,:,[7,8]),3)));
%                 u(:,:,2) = v;
%                 %% Calculate Equilibrium            
%                 for i=1:9
%                     ue = (u(:,:,1).*e(:,1,i)) + (u(:,:,2).*e(:,2,i));
%                     uu = (u(:,:,1).*u(:,:,1)) + (u(:,:,2).*u(:,:,2));
%                     wi = w(:,:,i);
%                     si = 2.*((3.*(ue./c))...
%                         +(9/2).*((ue.^2)./(c^2))...
%                         +(3/2).*(((uu).^2)./(c^2)));
%                     f_eq(:,:,i) = rho.*(wi+si);
%                 end
%                 %% Calculate new Vectors
% %                 f = f - (1/tau).*(f-f_eq);
%                 f = f*(1-(1/tau)) + f_eq/tau;
%                 %% Streaming Step
% %                 %Do Nothing Everywhere
% %                 f(:,:,1) = [f(:,1,1), f(:,1:end-1,1)];
% %                 f(:,:,2) = [f(1,:,2); f(1:end-1,:,2)];
% %                 f(:,:,3) = [f(:,2:end,3), f(:,end-1,3)];
% %                 f(:,:,4) = [f(2:end,:,4); f(end,:,4)];
% %                 f(:,:,5) = [f(1,1,5), f(1,2:end,5);
% %                             f(2:end,1,5), f(1:end-1,1:end-1,5)];
% %                 f(:,:,6) = [f(1,1:end-1,6), f(1,end,6);
% %                             f(1:end-1,2:end,6), f(2:end,end,6)];
% %                 f(:,:,7) = [f(2:end,2:end,7), f(1:end-1,end,7);
% %                             f(end,1:end-1,7), f(end,end,7)];
% %                 f(:,:,8) = [f(1:end-1,1,8), f(2:end,1:end-1,8);
% %                             f(end,1,8), f(end,2:end,8)];
%                 f(:,:,1) = f(:,[1 1:end-1],1);
%                 f(:,:,2) = f([1 1:end-1],:,2);
%                 f(:,:,3) = f(:,[2:end end],3);
%                 f(:,:,4) = f([2:end end],:,4);
% 
%                 f(:,:,5) = f([1 1:end-1],[1 1:end-1],5);
%                 f(:,:,6) = f([1 1:end-1],[2:end end],6);
%                 f(:,:,7) = f([2:end end],[2:end end],7);
%                 f(:,:,8) = f([2:end end],[1 1:end-1],8);
% 
%                 uff = ones(m,1)*c/6;
%                 f(:,1,1) = f(:,1,3) + 2/3 * rho(:,1) .* uff;
%                 f(:,1,5) = 1/6 * rho(:,1) .* uff + f(:,1,7) - f(:,1,2)/2 + f(:,1,4)/2;
%                 f(:,1,8) = 1/6 * rho(:,1) .* uff + f(:,1,6) + f(:,1,2)/2 - f(:,1,4)/2;
%       
% 
% %                 %Inflow at Left Side
% %                 rho(:,1) = (1/(1-c_in)).*...
% %                             (sum(f(:,1,[2,4,9]),3)+(2.*sum(f(:,1,[3,6,7]),3)));
% %                 f(:,1,1) = f(:,1,3)+((2/3).*rho(:,1).*c_in);
% %                 f(:,1,5) = ((1/6).*rho(:,1).*c_in)+f(:,1,7)+((1/2).*(f(:,1,2)-f(:,1,4)));
% %                 f(:,1,8) = ((1/6).*rho(:,1).*c_in)+f(:,1,6)+((1/2).*(f(:,1,2)-f(:,1,4)));

                %Kollision
                roh = sum(f,3);

                urohx = sum(f.*ex,3);
                urohy = sum(f.*ey,3);

                Urohx = urohx.*ones(m,n,9);
                Urohy = urohy.*ones(m,n,9);

                %Equilibrium
                Meq = w.*(roh + 3* (Urohx.*ex + Urohy.*ey)/c ...
                    + 9/2* (Urohx.*ex + Urohy.*ey).^2/(c^2)./roh ...
                    - 3/2* (Urohx.^2 + Urohy.^2)/(c^2)./roh);


                %neuer Schritt
                f = f*tau2 + Meq/tau;


                %Bewegen und RB Bounce Back und do nothing
                f(:,:,1) = f(:,[1 1:end-1],1);
                f(:,:,2) = f([1 1:end-1],:,2);
                f(:,:,3) = f(:,[2:end end],3);
                f(:,:,4) = f([2:end end],:,4);

                f(:,:,5) = f([1 1:end-1],[1 1:end-1],5);
                f(:,:,6) = f([1 1:end-1],[2:end end],6);
                f(:,:,7) = f([2:end end],[2:end end],7);
                f(:,:,8) = f([2:end end],[1 1:end-1],8);

                %RB links
                u = (1/6).*c;
                f(:,1,1) = f(:,1,3) + 2/3 * roh(:,1) .* u;
                f(:,1,5) = 1/6 * roh(:,1) .* u + f(:,1,7) - f(:,1,2)/2 + f(:,1,4)/2;
                f(:,1,8) = 1/6 * roh(:,1) .* u + f(:,1,6) + f(:,1,2)/2 - f(:,1,4)/2;

            end
            
%end