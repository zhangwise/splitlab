% Splitlab Configuration GUI helper function

%% SetSplitting Options

h.panel(11) = uipanel('Units','pixel','Title','Options for splitting procedures',...
    'Position',[133 10 425 395], 'BackgroundColor', [224   223   227]/255, 'Visible','off');

pos = get(h.panel(11),'Position');
hb = uibuttongroup('Units','pixel',...
                   'visible','off',...
                   'Position',[20 120 245 150],...
                   'BackgroundColor',[224 223 227]/255,...
                   'parent',h.panel(11),...
                   'Title','Method',...
                   'SelectionChangedFcn',@configRADIOBUTTON);
hi = uibuttongroup('Units','pixel',...
                   'visible','off',...
                   'Position',[20 55 385 60],...
                   'BackgroundColor',[224 223 227]/255,...
                   'parent',h.panel(11),...
                   'Title','Polarisation for EV- and RC- method',...
                   'SelectionChangedFcn',@configRADIOBUTTON);
hs = uipanel(      'Units','pixel',...
                   'visible','on',...
                   'Position',[275 120  130 150],...
                   'BackgroundColor',[224 223 227]/255,...
                   'parent',h.panel(11),...
                   'Title','Gridsearch parameters');


%% Color Selection
a = .05:.05:0.95;
b=[];
b(:,:,1) = repmat(a,19,1)';
b(:,:,2) = repmat(a,19,1);
b(:,:,3) = repmat(flipdim(a,2),19,1);

hc = uipanel('Units','pixel','visible','on','Position',[275 280  130 100], 'BackgroundColor', [224   223   227]/255, 'parent',h.panel(11),'Title','Colors');

hh(1)=uicontrol('Style','pushbutton', 'String', 'Pwin',...
    'pos',[20 60 40 18],'HandleVisibility','off',...
    'BackgroundColor','w','parent',hc,...
    'CData',repmat(shiftdim(config.Colors.PselectionColor,-1), [18,38,1]),...
    'Callback','config.Colors.PselectionColor = uisetcolor(config.Colors.PselectionColor);set(gcbo,''CData'', repmat(shiftdim(config.Colors.PselectionColor,-1), [18,38,1]))');

hh(2)=uicontrol('Style','pushbutton', 'String', 'Swin',...
    'pos',[20 35 40 18],'HandleVisibility','off',...
    'BackgroundColor','w','parent',hc,...
    'CData',repmat(shiftdim(config.Colors.SselectionColor,-1), [18,38,1]),...
    'Callback','config.Colors.SselectionColor = uisetcolor(config.Colors.SselectionColor);set(gcbo,''CData'', repmat(shiftdim(config.Colors.SselectionColor,-1), [18,38,1]))');
hh(3)=uicontrol('Style','pushbutton', 'String', 'OldWin',...
    'pos',[20 10 40 18],'HandleVisibility','off',...
    'BackgroundColor','w','parent',hc,...
    'CData',repmat(shiftdim(config.Colors.OldselectionColor,-1), [18,38,1]),...
    'Callback','config.Colors.OldselectionColor = uisetcolor(config.Colors.OldselectionColor);set(gcbo,''CData'', repmat(shiftdim(config.Colors.OldselectionColor,-1), [18,38,1]))');

hh(4)=uicontrol('Style','pushbutton', 'String', 'Tmark',...
    'pos',[70 60 40 18],'HandleVisibility','off',...
    'BackgroundColor','w','parent',hc,...
    'CData',repmat(shiftdim(config.Colors.TTMarkerColor ,-1), [18,38,1]),...
    'Callback','config.Colors.TTMarkerColor = uisetcolor(config.Colors.TTMarkerColor);set(gcbo,''CData'', repmat(shiftdim(config.Colors.TTMarkerColor,-1), [18,38,1]))');
hh(5)=uicontrol('Style','pushbutton', 'String', 'SAC',...
    'pos',[70 35 40 18],'HandleVisibility','off',...
    'BackgroundColor','w','parent',hc,...
    'CData',repmat(shiftdim(config.Colors.SACMarkerColor,-1), [18,38,1]),...
    'Callback','config.Colors.SACMarkerColor = uisetcolor(config.Colors.SACMarkerColor);set(gcbo,''CData'', repmat(shiftdim(config.Colors.SACMarkerColor,-1), [18,38,1]))');


uicontrol('Style','pushbutton', 'String', 'Default',...
    'pos',[70 10 40 18],'HandleVisibility','off',...
    'parent',hc,...
    'UserData',hh,...
    'Callback',...
    ['tmp=getpref(''Splitlab'',''Configuration''); tmp = struct2cell(tmp.Colors);'...
    'tmph= get(gcbo,''UserData'');'...
    'for k=1:5; set(tmph(k),''CData'',repmat(shiftdim(tmp{k},-1), [18,38,1])); end; clear tmp*']...
    );


%% STEP SIZE: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str = {num2str([1 2 3 4 5 10 15 20 ]')};
val = find(config.StepsDT == str2num(str{:}));
uicontrol('Style','popupMenu','String',str,...
    'pos',[35 80 60 20],'HandleVisibility','off',...
    'Value',val,'parent',hs,...
    'BackgroundColor','w',...
    'Callback', 'tmp=get(gcbo,''string''); config.StepsDT = str2num(tmp{get(gcbo,''Value'')});clear tmp ');
uicontrol('Style','text','String','dt step [samples]','parent',hs,...
    'pos',[10 105 110 15])


str = {num2str([1 2 3 4 5]')};
val = find(config.StepsPhi == str2num(str{:}));
uicontrol('Style','popupMenu','String',str,...
    'pos',[35 20 60 20],'HandleVisibility','off',...
    'Value',val,'parent',hs,...
    'BackgroundColor','w',...
    'Callback', 'tmp=get(gcbo,''string''); config.StepsPhi = str2num(tmp{get(gcbo,''Value'')});clear tmp ');
uicontrol('Style','text','String','phi step [degrees]','parent',hs,...
    'pos',[10 45 110 15])

%%
uicontrol('Style','edit', 'String', num2str(config.maxSplitTime),...
    'pos',[175 pos(4)-55 60 20],'HandleVisibility','off',...
    'BackgroundColor','w','parent',h.panel(11),...
    'Callback','config.maxSplitTime=str2num(get(gcbo,''string''));');
uicontrol('Style','text','String','Maximum Split time [sec]','parent',h.panel(11),...
    'pos',[14 pos(4)-60 140 20])

%% %%%%
str = {' other..','raw','12000','10000','4000','1000','250','100','50','20','10'};
val = strmatch(config.resamplingfreq, str, 'exact');
if isempty(val)
    str{end+1} = config.resamplingfreq;
    val=length(str);
end
uicontrol('Style','popupMenu','String',str,...
    'pos',[169 pos(4)-85 74 20],'HandleVisibility','off',...
    'Value',val,'parent',h.panel(11),...
    'BackgroundColor','w',...
    'Callback',...
    ['tmp=get(gcbo,''string'');'...
    'if get(gcbo,''Value'')==1;'...
    '   tmp2 = char(inputdlg(''New sampling frequency [Hz]''));'...
    '   if ~isempty(str2num(tmp2));'...
    '       config.resamplingfreq = tmp2;'...
    '       set(gcbo, ''string'',[tmp;{tmp2}], ''Value'',length(tmp)+1); '...
    '   end;'...
    'else;',...
    '   config.resamplingfreq = tmp{get(gcbo,''Value'')};'...
    'end;'...
    'seisax = findobj(''Tag'',''seisaxes'');'...
    'if ~isempty(seisax); xl =xlim(seisax(1)); SL_SeismoViewer(thiseq.index);seisax = findobj(''Tag'',''seisaxes'');xlim(seisax(1),xl); end;'...
    'clear tmp tmp2 seisax xl']);
uicontrol('Style','text','String','Resample Seismogram to [Hz]','parent',h.panel(11),...
    'pos',[19 pos(4)-90 150 20])
%%%%%%

str = {'nearest','linear', 'spline', 'pchip'};
val = strmatch(config.interpolmethod,str );
uicontrol('Style','popupMenu','String',str,...
    'pos',[169 pos(4)-115 74 20],'HandleVisibility','off',...
    'Value',val,'parent',h.panel(11),...
    'BackgroundColor','w',...
    'Callback',[...
    'tmp=get(gcbo,''string''); config.interpolmethod = tmp{get(gcbo,''Value'')};'...
    'seisax = findobj(''Tag'',''seisaxes'');'...
    'if ~isempty(seisax); xl =xlim(seisax(1)); SL_SeismoViewer(thiseq.index);seisax = findobj(''Tag'',''seisaxes'');xlim(seisax(1),xl); end;'...
    'clear tmp  seisax xl']);
uicontrol('Style','text','String','Interpolation method','parent',h.panel(11),...
    'pos',[0 pos(4)-120 150 20])

u2 = uicontrol('Style','Radio','String','Minimum Energy',...
    'pos',[10 110 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MinE');

u4 = uicontrol('Style','Radio','String','Eigenvalue: min(lambda1 * lambda2)',...
    'pos',[10 90 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MinL1L2');

u5 = uicontrol('Style','Radio','String','Eigenvalue: min(lambda2 / lambda1)',...
    'pos',[10 70 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MinL2L1');

u1 = uicontrol('Style','Radio','String','Eigenvalue: max(lambda1 / lambda2)',...
    'pos',[10 50 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MaxL1L2');

u3 = uicontrol('Style','Radio','String','Eigenvalue: max(lambda1)',...
    'pos',[10 30 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MaxL1');

u0 = uicontrol('Style','Radio','String','Eigenvalue: min(lambda2)',...
    'pos',[10 10 200 20],'parent',hb,'HandleVisibility','off',...
    'Tag','MinL2');


i1 = uicontrol('Style','Radio','String','fixed (based on selected phase; [SG,SH]=[Q,T])',...
    'pos',[10 25 300 20],'parent',hi,'HandleVisibility','off','Tag','fixed');
i2 = uicontrol('Style','Radio','String','estimated (from SG/SH-wavelet)',...
    'pos',[10 5 250 20],'parent',hi,'Tag','estimated');

set(hb,'SelectedObject',[]);  % No selection
set([hb,hi],'Visible','on');


switch config.splitoption
    case 'Minimum Energy'
        set(u2,'Value',1)
    case 'Eigenvalue: max(lambda1 / lambda2)'
        set(u1,'Value',1)
    case 'Eigenvalue: min(lambda2 / lambda1)'
        set(u5,'Value',1)
    case 'Eigenvalue: min(lambda2)'
        set(u0,'Value',1)
    case 'Eigenvalue: max(lambda1)'
        set(u3,'Value',1)
    case 'Eigenvalue: min(lambda1 * lambda2)'
        set(u4,'Value',1)
    otherwise
        disp('Warning: Unknown Option! Defaulting to Minimum Energy on Transverse')
        set(u2,'Value',1)
        config.splitoption = 'Minimum Energy';
end

switch config.inipoloption
    case 'fixed'
        set(i1,'Value',1)
    case 'estimated'
        set(i2,'Value',1)
    otherwise
        disp('Unknown Option! Defaulting to fixed initial polarisation')
        set(i1,'Value',1)
        config.inipoloption = 'fixed';
end

%% Advanced Button
uicontrol('Style','pushbutton', 'String', 'Advanced...',...
    'pos',[325 10 80 25],...
    'parent',h.panel(11),...
    'Callback',@configSPLITADVANCED);

