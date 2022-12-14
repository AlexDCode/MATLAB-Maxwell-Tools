function pltAcademic(fig__, varargin)
%pltAcademic Figure Format for Academic Publications
%   Automate the formating of figures for academic publications or
%   presentations.
%
%fig__: Figure Handle
%title: Show title on Figure option
%box: Figure Bounding Box option
%width: [cm] Figure Width
%lw: Line Width
%msz: Marker Size
%hwRatio: Height-Width Ratio
%font: Font Size for Text
%fontTitle: Font Size for Title
%showLegend: Show Legend Option
%legendLoc: Legend Location
    
    p = inputParser;
    addParameter(p,'title',0);    % Option to show title on top of Figure
    addParameter(p,'box','off');  % Figure Bounding Box toggle
    addParameter(p,'width',8.89); % [cm] Figure Width
    addParameter(p,'lw',1.5); % Line Width
    addParameter(p,'msz',6); % Marker Size
    addParameter(p,'hwRatio',0.65); % Height to Width Ratio
    addParameter(p,'font',11);  % Axis and Labels Font Size  
    addParameter(p,'fontTitle',11); % Title Font Size
    addParameter(p,'showLegend',0); % Legend    
    addParameter(p,'legendLoc','best'); % Legend location    
    parse(p,varargin{:});

    if p.Results.showLegend
        legend('Location',p.Results.legendLoc)
    end
    set(findall(fig__,'-property','FontSize'),'FontSize',p.Results.font) % adjust fontsize to your  document
    if p.Results.title
        title(fig__.Name, 'FontSize', p.Results.fontTitle)
    end
    set(findall(fig__,'-property','Box'),'Box', p.Results.box) % optional
    set(findall(fig__,'-property','Interpreter'),'Interpreter','latex')
    set(findall(fig__,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
    set(findall(fig__,'-property','LineWidth'),'LineWidth',p.Results.lw)
    set(findall(fig__,'-property','MarkerSize'),'MarkerSize',p.Results.msz)
    set(fig__,'Units','centimeters','Position',[3 3 p.Results.width p.Results.hwRatio*p.Results.width])
    axis tight
    pos = get(fig__,'Position');
    set(fig__,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3) + 0.1, pos(4) + 0.1])
    
    [~,~,~] = mkdir('img');
    d = datetime;
    d.Format = 'yyyy-MM-dd HHmm';
    print(fig__, strcat('img/', string(d), "_", fig__.Name),'-dpdf','-vector');
    print(fig__, strcat('img/', string(d), "_", fig__.Name),'-dpng','-vector', '-r300')
end