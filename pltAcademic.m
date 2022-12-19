function pltAcademic(fig__)
%pltAcademic Figure Format for Academic Publications
%   Detailed explanation goes here
% fig__: Figure Handle
% TODO: Documentation, input arguments call as options

    show_title = 0; % Option to show title on top of Figure
    box = 'off'; % Figure Bounding Box toggle
    picturewidth = 8.89; % [cm] Figure Width
    lw = 1.5; % Line Width
    msz = 6; % Marker Size
    hw_ratio = 0.65; % feel free to play with this ratio
    font = 11;  % Axis and Labels Font Size
    font_title = 11; % Title Font Size
    legend_loc = 'best'; % Legend location

    p = inputParser;
    addParameter(p,'show_title',0)


    legend('Location',legend_loc)
    set(findall(fig__,'-property','FontSize'),'FontSize',font) % adjust fontsize to your  document
    if show_title
        title(fig__.Name, 'FontSize', font_title)
    end
    set(findall(fig__,'-property','Box'),'Box', box) % optional
    set(findall(fig__,'-property','Interpreter'),'Interpreter','latex')
    set(findall(fig__,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
    set(findall(fig__,'-property','LineWidth'),'LineWidth',lw)
    set(findall(fig__,'-property','MarkerSize'),'MarkerSize',msz)
    set(fig__,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
    axis tight
    pos = get(fig__,'Position');
    set(fig__,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
    
    [~,~,~] = mkdir('img');
    d = datetime;
    d.Format = 'yyyy-MM-dd HH:mm';
    print(fig__,strcat('img/', string(d), "_", fig__.Name),'-dpdf','-vector','-fillpage')
    print(fig__,strcat('img/', string(d), "_", fig__.Name),'-dpng','-vector')
end