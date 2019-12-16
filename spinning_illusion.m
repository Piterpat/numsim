%% Startparameters
    %Detail
    d_t=1000; %Curvestep
    w_d=1000; %Anglestep (time, affects speed)
    
    %Speed ]0,1]
    s=0.01;
    
    %Lissajous curve
    a=3; %Proportions
    b=2;
    
    %Figure
    fig = figure(...
        'Name','Spinning Illusion',...
        'NumberTitle','off',...
        'Color','w');
    set(fig, 'MenuBar', 'none');
    set(fig, 'ToolBar', 'none');
    
%% Precalculation
    t = 0:pi/d_t:2*pi;
    w = 0:pi/w_d:2*pi;
    xt=zeros(size(t,2),size(w,2));
    yt=zeros(size(t,2),size(w,2));
    stay = true;
    
%% Calculation
    for i=1:size(w,2)
        xt(:,i) = 2*sin(b*t);
        yt(:,i) = sin(a*t+w(i));
    end
    
%% Plot
    while stay
        for i=1:ceil(s*w_d):size(w,2)
            %% Draw
            p = plot(xt(:,i),yt(:,i),'k');
            p.LineWidth = 7;
            axis equal
            axis off
            drawnow

            %% Break Condition
            if ~ishghandle(fig)
                stay=false;
                break
            end
        end
    end