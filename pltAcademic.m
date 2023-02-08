function pltAcademic(fig__,  preset, varargin)
%pltAcademic Figure Format for Academic Publications
%   Automate the formating of figures for academic publications or
%   presentations.
%
%fig__: Figure Handle
%preset: Default style for paper, display, or presentation
%title: Show title on Figure option
%box: Figure Bounding Box option
%width: [cm] Figure Width
%lw: Line Width
%msz: Marker Size
%hwRatio: Height-Width Ratio
%disableResize: Leave default plot size
%font: Font Size for Text
%fontTitle: Font Size for Title
%save: Save plot

    if nargin == 1
        preset = "display";
    end

    pos = get(fig__,'Position');
    defaultPos = get(0,'defaultfigureposition');

    if preset == "paper"
        fontTitle = 11;
        font = 11;
        lw = 1.5;
        msz = 6;
        units = 'centimeters';
        x = 3;
        y = 3;
        width = 8.89;
        hwRatio = 0.65;
        save = 1;
    elseif preset == "display"
        fontTitle = 16;
        font = 12;
        lw = 1.5;
        msz = 6;
        units = 'pixels';
        x = defaultPos(1);
        y = defaultPos(2);        
        width = defaultPos(3);
        hwRatio = 0.65;
        save = 0;
    elseif preset == "presentation"
        fontTitle = 26;
        font = 20;
        lw = 3;
        msz = 10;
        units = 'centimeters';
        x = 1;
        y = 2;
        width = 24;
        hwRatio = 9/16;
        save = 1;
    end


    p = inputParser;
    addParameter(p,'title',0);    % Option to show title on top of Figure
    addParameter(p,'box','on');  % Figure Bounding Box toggle
    addParameter(p,'width',width); % [cm] Figure Width
    addParameter(p,'lw',lw); % Line Width
    addParameter(p,'msz',msz); % Marker Size
    addParameter(p,'hwRatio',hwRatio); % Height to Width Ratio
    addParameter(p,'disableResize', 0);    % Option to not resize
    addParameter(p,'font',font);  % Axis and Labels Font Size  
    addParameter(p,'fontTitle',fontTitle); % Title Font Size
    addParameter(p,'legendLoc','best'); % Legend location    
    addParameter(p,'save',save); % Save picture,, on by default    
    parse(p,varargin{:});



    set(findall(fig__,'-property','FontSize'),'FontSize',p.Results.font) % adjust fontsize to your  document
    if p.Results.title
        title(fig__.Name, 'FontSize', p.Results.fontTitle)
    end
    

    set(findall(fig__,'-property','Box'),'Box', p.Results.box) % optional
    set(findall(fig__,'-property','Interpreter'),'Interpreter','latex')
    set(findall(fig__,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')


    if string(gca().Tag) == "smithplot"
        % Prepare Smith Charts to change Interpreter
        r=groot;
        r.ShowHiddenHandles = 1;

        smith = gca;
        for i = 1:length(smith.Children)
            if(strcmp(smith.Children(i).Tag, 'CircleTicks1'))
                if(strcmp(smith.Children(i).String, '\infty'))
                    smith.Children(i).String = '$\infty$';
                end
            end
        end

        lw = 1;
    else
        % Not execure on Smith Charts
        axis tight
        lw = p.Results.lw;
    end
    set(findall(fig__,'-property','LineWidth'),'LineWidth',lw)
    set(findall(fig__,'-property','MarkerSize'),'MarkerSize',p.Results.msz)

    set(fig__,'Units',units,'Position',[x y p.Results.width p.Results.hwRatio*p.Results.width])
    if p.Results.disableResize == 0
        set(fig__,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3) + 0.1, pos(4) + 0.1])
    end
    
    if p.Results.save
        [~,~,~] = mkdir('img');
        d = datetime;
        d.Format = 'yyyy-MM-dd HHmm';
        path = strcat('img/', string(d), "_", fig__.Name, "_", preset);
        print(fig__, path,'-dpdf','-vector');
        print(fig__, path,'-dpng','-vector', '-r300')
    end
end