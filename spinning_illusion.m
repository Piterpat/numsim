%% Startparameters
    %Detail (Affects Speed)
    s=250;

    %Lissajous curve
    a=3; %Proportions
    b=2;
    d=0; %Starting Angle
    
    %Figure
    fig = figure(...
        'Name','Spinning Illusion',...
        'NumberTitle','off',...
        'Color','w');
    set(fig, 'MenuBar', 'none');
    set(fig, 'ToolBar', 'none');

%% Timeloop
    while true
        %% Curve
        t = 0:pi/s:2*pi;
        xt = 2*sin(b*t);
        yt = sin(a*t+d);
        zt = t;
        
        %% Plot
        p = plot3(xt,yt,zt,'k');
        p.LineWidth = 3;
        axis equal
        axis off
        view(0,90)
        drawnow
        
        %% Break Condition
        if ~ishghandle(fig)
            break
        end
        
        %% Increment
        d = d + pi/s;
    end