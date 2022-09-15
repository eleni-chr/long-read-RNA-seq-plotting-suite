function plotReadLengthVsQualDensityLogData
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a density plot of the read length vs the basecall 
%quality before filtering out low basecall quality reads. The x-axis scale 
%is logarithmic.

%The function requires a TXT file for each sample, containing basecall
%quality scores in column 1 and read lengths in column 2. The data must be
%tab-delimited. No headers are allowed.

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
colours=zeros(6,2); %initialise variable.

%Subplot 1.
data1=readmatrix('NanoPlot-data_barcode07.txt'); %load data.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
h1=hexscatter(log(data1(:,2)),data1(:,1)); %log-transform the data.
clear data1;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Wildtype 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
mycolours=[.7 1 .9; .6 .9 .8; .5 .8 .7; .4 .7 .6; .3 .6 .5; .2 .5 .4; .1 .4 .3; 0 .3 .2];
colormap(ax(1),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(1,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
barpos=pos(1); %save x-coordinate of current axis for later.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
newUnits='normalized';
set(gca,'Position',newPosition,'Units',newUnits);

%Subplot 2.
data2=readmatrix('NanoPlot-data_barcode08.txt'); %load data.
ax(2)=subplot(2,3,2);
h2=hexscatter(log(data2(:,2)),data2(:,1)); %log-transform the data.
clear data2;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Wildtype 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
colormap(ax(2),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(2,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
set(gca,'Position',newPosition,'Units',newUnits);

%Subplot 3.
data3=readmatrix('NanoPlot-data_barcode09.txt'); %load data.
ax(3)=subplot(2,3,3);
h3=hexscatter(log(data3(:,2)),data3(:,1)); %log-transform the data.
clear data3;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Wildtype 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
colormap(ax(3),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(3,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
set(gca,'Position',newPosition,'Units',newUnits);

%Add colourbar for wildtypes.
bottom=min(colours(1:3,1));
top=max(colours(1:3,2));
caxis([bottom top]);
c=colorbar('location','Manual','position',[barpos-0.05 .1 .01 .81],'Units',newUnits);
set(c,'YTickLabel',cellstr(num2str(reshape(get(c,'YTick'),[],1),'%g'))); %change colorbar values from scientific notation to standard notation.

%Subplot 4.
data4=readmatrix('NanoPlot-data_barcode10.txt'); %load data.
ax(4)=subplot(2,3,4);
h4=hexscatter(log(data4(:,2)),data4(:,1)); %log-transform the data.
clear data4;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Mutant 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
mycolours=[1 .7 .9; .9 .6 .8; .8 .5 .7; .7 .4 .6; .6 .3 .5; .5 .2 .4; .4 .1 .3; .3 0 .2];
colormap(ax(4),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(4,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
set(gca,'Position',newPosition,'Units',newUnits);

%Subplot 5.
data5=readmatrix('NanoPlot-data_barcode11.txt'); %load data.
ax(5)=subplot(2,3,5);
h5=hexscatter(log(data5(:,2)),data5(:,1)); %log-transform the data.
clear data5;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Mutant 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
colormap(ax(5),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(5,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
set(gca,'Position',newPosition,'Units',newUnits);

%Subplot 6.
data6=readmatrix('NanoPlot-data_barcode12.txt'); %load data.
ax(6)=subplot(2,3,6);
h6=hexscatter(log(data6(:,2)),data6(:,1)); %log-transform the data.
clear data6;
ylabel('Read basecall quality','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Read length)','FontSize',12); %add x-axis label.
title('Mutant 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
colormap(ax(6),mycolours); %change colours of plot.
caxis manual %set the limits of the colourbar to manual.
colours(6,:)=caxis; %get limits of current colour axis.
pos=get(gca,'position'); %get position of current axes.
newPosition=[pos(1)+0.01 pos(2) pos(3) pos(4)]; %define new position of current axes.
set(gca,'Position',newPosition,'Units',newUnits);

%Add colourbar for mutants.
bottom=min(colours(4:6,1));
top=max(colours(4:6,2));
caxis([bottom top]);
colorbar('location','Manual','position',[.93 .1 .01 .81]);

%Modify axes.
ax(1).XAxis.FontSize=12; %set x-axis fontsize.
ax(2).XAxis.FontSize=12;
ax(3).XAxis.FontSize=12;
ax(4).XAxis.FontSize=12;
ax(5).XAxis.FontSize=12;
ax(6).XAxis.FontSize=12;
ax(1).YAxis.FontSize=12; %set y-axis fontsize.
ax(2).YAxis.FontSize=12;
ax(3).YAxis.FontSize=12;
ax(4).YAxis.FontSize=12;
ax(5).YAxis.FontSize=12;
ax(6).YAxis.FontSize=12;
linkaxes(ax,'xy'); %link x-axis and y-axis limits of all subplots.

%Save plot.
savefig(fig,'ReadLength_v_Qual_Density_LogData'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'ReadLength_v_Qual_Density_LogData.svg'); %save figure as an SVG file.
close
clear
end

%% Functions from MATLAB File Exchange that are used within this function.
%% h = HEXSCATTER( x, y, ... )
% Gordon Bean, February 2014
% A scatter-plot substitute - generate a density plot using hexagonal
% patches.
%
% Syntax
% hexscatter(xdata, ydata)
% hexscatter(xdata, ydata, 'Name', Value, ...)
% h = hexscatter(...)
%
% Description
% hexscatter(xdata, ydata) creates a density plot of the ydata versus the
% xdata using hexagonal tiles. xdata and ydata should be vectors. NaN
% values (and their corresponding values in the other vector) are ignored.
%
% hexscatter(xdata, ydata, 'Name', Value, ...) accepts name-value pairs of
% arguments from the following list (defaults in {}):
%  'xlim' { [min(xdadta(:) max(xdata(:))] } - a 2-element vector containing
%  the lower and upper bounds of the 2nd dimension of the grid.
%  'ylim' { [min(ydadta(:) max(ydata(:))] } - a 2-element vector containing
%  the lower and upper bounds of the 1st dimension of the grid.
%  'res' { 50 } - the resolution, or number of bins in each dimension. The
%  total number of bins will be the resolution squared.
%  'drawEdges' { false } - if true, edges are drawn around each hexagonal
%  patch.
%  'showZeros' { false } - if true, bins with 0 counts are shaded; if
%  false, only bins with non-zero counts are colored. 
% 
% h = hexscatter( ... ) returns the object handle to the patch object
% created.
% 
% Examples
% hexscatter(rand(2000,1), rand(2000,1))
%
% hexscatter(rand(2000,1), rand(2000,1), 'res', 90)
%
% Also available in the Bean Matlab Toolkit:
% https://github.com/brazilbean/bean-matlab-toolkit

function h = hexscatter( xdata, ydata, varargin )
    params = default_param( varargin, ...
        'xlim', [min(xdata(:)) max(xdata(:))], ...
        'ylim', [min(ydata(:)) max(ydata(:))], ...
        'res', 50, ...
        'drawEdges', false, ...
        'showZeros', false);
    
    if params.drawedges
        ec = 'flat';
    else
        ec = 'none';
    end
    
    %% Determine grid
    xl = params.xlim;
    yl = params.ylim;
    
    xbins = linspace(xl(1), xl(2), params.res);
    ybins = linspace(yl(1), yl(2), params.res);
    dy = diff(ybins([1 2]))*0.5;
    
    [X, Y] = meshgrid(xbins, ybins);
    n = size(X,1);
    Y(:,1:fix(end/2)*2) = ...
        Y(:,1:fix(end/2)*2) + repmat([0 dy],[n,fix(n/2)]);

    %% Map points to boxes
    nix = isnan(xdata) | isnan(ydata);
    xdata = xdata(~nix);
    ydata = ydata(~nix);
    
    % Which pair of columns?
    dx = diff(xbins([1 2]));
    foox = floor((xdata - xbins(1)) ./ dx)+1;
    foox(foox > length(xbins)) = length(xbins);
    
    % Which pair of rows?
    % Use the first row, which starts without an offset, as the standard
    fooy = floor((ydata - ybins(1)) ./ diff(ybins([1 2])))+1;
    fooy(fooy > length(ybins)) = length(ybins);
    
    % Which orientation
    orientation = mod(foox,2) == 1;

    % Map points to boxes
    foo = [xdata - xbins(foox)', ydata - ybins(fooy)'];

    % Which layer
    layer = foo(:,2) > dy;

    % Convert to block B format
    toflip = layer == orientation;
    foo(toflip,1) = dx - foo(toflip,1);

    foo(layer==1,2) = foo(layer==1,2) - dy;

    % Find closest corner
    dist = sqrt(sum(foo.^2,2));
    dist2 = sqrt(sum(bsxfun(@minus, [dx dy], foo).^2, 2));

    topright = dist > dist2;

    %% Map corners back to bins
    % Which x bin?
    x = foox + ~(orientation == (layer == topright));
    x(x > length(xbins)) = length(xbins);
    
    % Which y bin?
    y = fooy + (layer & topright);
    y(y > length(ybins)) = length(ybins);
    
    ii = sub2ind(size(X), y, x);

    %% Determine counts
    counts = sum(bsxfun(@eq, ii, 1:numel(X)),1);

    newplot;
    xscale = diff(xbins([1 2]))*2/3;
    yscale = diff(ybins([1 2]))*2/3;
    theta = 0 : 60 : 360;
    x = bsxfun(@plus, X(:), cosd(theta)*xscale)';
    y = bsxfun(@plus, Y(:), sind(theta)*yscale)';
    
    if params.showzeros
        h = patch(x, y, counts, 'edgeColor', ec);
    else
        jj = counts > 0;
        h = patch(x(:,jj), y(:,jj), counts(jj), 'edgeColor', ec);
    end
    
    if nargout == 0
        clear h;
    end
    
    %% Function: default_param
    % Gordon Bean, March 2012
    % Copied from https://github.com/brazilbean/bean-matlab-toolkit
    function params = default_param( params, varargin )
        if (iscell(params))
            params = get_params(params{:});
        end
        defaults = get_params(varargin{:});

        for f = fieldnames(defaults)'
            field = f{:};
            if (~isfield( params, lower(field) ))
                params.(lower(field)) = defaults.(field);
            end
        end
    end

    %% Function: get_params - return a struct of key-value pairs
    % Gordon Bean, January 2012
    %
    % Usage
    % params = get_params( ... )
    %
    % Used to parse key-value pairs in varargin - returns a struct.
    % Converts all keys to lower case.
    %
    % Copied from https://github.com/brazilbean/bean-matlab-toolkit
    function params = get_params( varargin )
        params = struct;

        nn = length(varargin);
        if (mod(nn,2) ~= 0)
            error('Uneven number of parameters and values in list.');
        end

        tmp = reshape(varargin, [2 nn/2]);
        for kk = 1 : size(tmp,2)
            params.(lower(tmp{1,kk})) = tmp{2,kk};
        end
    end
end