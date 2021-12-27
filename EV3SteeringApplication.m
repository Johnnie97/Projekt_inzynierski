%-------------------------------------------------------------------------
%Steering application for ultrasonic sensor Jan GONTAREK---------
%-------------------------------------------------------------------------
function aplikacja_EV3
        %Connect to EV3 
        myev3=legoev3('Wifi','172.20.10.10','00165353ABED');
        %Create GUI elements
        f = figure('Visible','on','Position',[200,100,730,600]);
        handles.wykres = polaraxes('Units','pixels','Position',[50,150,370,370]);
        %handles.wykres.RLim = [0 2.55];
        hold all
        ramka = uicontrol('Style','frame','Position',[500,30,200,550]);
        uruchom360 = uicontrol('Style','pushbutton',...
                 'String','Uruchom','Position',[550,470,100,50],...
                 'Callback',@uruchombutton_Callback);
        uruchom_sektor = uicontrol('Style','pushbutton',...
                 'String','Uruchom','Position',[550,385,100,50],...
                 'Callback',@sektorbutton_Callback);
        czysc_osie = uicontrol('Style','pushbutton',...
                 'String','Reset','Position',[520,200,50,30],...
                 'Callback',@resetbutton_Callback);
        czysc_enkoder = uicontrol('Style','pushbutton',...
                 'String','Reset','Position',[620,200,50,30],...
                 'Callback',@enkoderbutton_Callback);      
        stop = uicontrol('Style','pushbutton',...
                 'String','Stop','Position',[550,290,100,50],...
                 'Callback',@stopbutton_Callback);
        ramka2 = uicontrol('Style','frame','Position',[55,20,360,100]);
        handles.zasieg = uicontrol('Style','edit',...
                 'String','','Position',[70,45,50,30]);
        handles.predkosc = uicontrol('Style','edit',...
                 'String','','Position',[160,45,50,30]);
        handles.sektor = uicontrol('Style','edit',...
                 'String','','Position',[250,45,50,30]);
        handles.rozdzielczosc = uicontrol('Style','edit',...
                 'String','','Position',[340,45,50,30]);     
        handles.thetagora = uicontrol('Style','radiobutton',...
                 'String','Góra','Position',[550,50,100,25],...
                 'Callback',@gorabox_Callback);
        handles.thetadol = uicontrol('Style','radiobutton',...
                 'String','Dó³','Position',[550,76,50,25],...
                 'Callback',@dolbox_Callback);
        handles.thetalewo = uicontrol('Style','radiobutton',...
                 'String','Lewo','Position',[550,100,50,25],...
                 'Callback',@lewobox_Callback);
        handles.thetaprawo = uicontrol('Style','radiobutton',...
                 'String','Prawo','Position',[550,125,60,25],...
                 'Callback',@prawobox_Callback);
        %GUI elements
        tytul = uicontrol('Style','text','FontSize',15,'FontWeight','Bold','String','PROGRAM STERUJ¥CY DALMIERZEM',...
        'Position',[70,550,400,50]);
        tytul_wykres = uicontrol('Style','text','FontWeight','Bold','String','MAPA WYKRYÆ',...
        'Position',[190,540,100,15]);
        parametry = uicontrol('Style','text','FontWeight','Bold','String','PARAMETRY',...
        'Position',[60,100,70,15]);
        zasieg_tekst = uicontrol('Style','text','String','Zasiêg',...
        'Position',[70,80,50,15]);
        predkosc_tekst = uicontrol('Style','text','String','Prêdkoœæ',...
        'Position',[150,80,70,15]);
        sektor_tekst = uicontrol('Style','text','String','Szerokoœæ sektora',...
        'Position',[230,80,100,15]);
        rozdzielczosc_tekst = uicontrol('Style','text','String','Rozdzielczoœæ',...
        'Position',[330,80,80,15]);
        panel_sterujacy = uicontrol('Style','text','FontWeight','Bold','String','PANEL STERUJ¥CY',...
        'Position',[510,550,120,15]);
        praca360 = uicontrol('Style','text','String','Praca dookólna',...
        'Position',[510,525,100,15]);
        pracasektorowa = uicontrol('Style','text','String','Praca sektorowa',...
        'Position',[510,440,100,15]);
        ulozeniewykresu = uicontrol('Style','text','String','Umiejscowienie poczatku wykresu',...
        'Position',[510,155,160,30]);
        czyszczeniewykresu = uicontrol('Style','text','String','Czyszczenie obszaru wykresu',...
        'Position',[505,240,90,30]);
        zatrzymaniesilnika= uicontrol('Style','text','String','Zatrzymanie silnika',...
        'Position',[510,345,100,15]);
        resetenkodera= uicontrol('Style','text','String','Zerowanie enkodera',...
        'Position',[615,240,60,30]);

        %Normalization of GUI elements
        f.Units = 'normalized';
        handles.wykres.Units = 'normalized';
        ramka.Units = 'normalized';
        uruchom360.Units = 'normalized';
        uruchom_sektor.Units = 'normalized';
        czysc_osie.Units = 'normalized';
        czysc_enkoder.Units = 'normalized';
        stop.Units = 'normalized';
        ramka2.Units = 'normalized';
        handles.zasieg.Units = 'normalized';
        handles.predkosc.Units = 'normalized';
        handles.sektor.Units = 'normalized';
        handles.rozdzielczosc.Units = 'normalized';
        tytul.Units = 'normalized';
        tytul_wykres.Units = 'normalized';
        parametry.Units = 'normalized';
        zasieg_tekst.Units = 'normalized';
        predkosc_tekst.Units = 'normalized';
        sektor_tekst.Units = 'normalized';
        rozdzielczosc_tekst.Units = 'normalized';
        panel_sterujacy.Units = 'normalized';
        praca360.Units = 'normalized';
        pracasektorowa.Units = 'normalized';
        ulozeniewykresu.Units = 'normalized';
        czyszczeniewykresu.Units = 'normalized';
        zatrzymaniesilnika.Units = 'normalized';
        handles.thetagora.Units = 'normalized';
        handles.thetadol.Units = 'normalized';
        handles.thetalewo.Units = 'normalized';
        handles.thetaprawo.Units = 'normalized';
        resetenkodera.Units = 'normalized';
        set(handles.thetaprawo, 'Value', 1);
  
        f.Name = 'Projekt dalmierza';

    % Callbacks for GUI elements
    %360 deg scanning mode
    function uruchombutton_Callback(source,eventdata)
        praca_360;
    end
    %Setting starting point of a graph
    function gorabox_Callback(source,eventdata)
        handles.wykres.ThetaZeroLocation = 'top';
        set(handles.thetadol, 'Value', 0);
        set(handles.thetalewo, 'Value', 0);
        set(handles.thetaprawo, 'Value', 0);
    end
    function dolbox_Callback(source,eventdata)
        handles.wykres.ThetaZeroLocation = 'bottom';
        set(handles.thetagora, 'Value', 0);
        set(handles.thetalewo, 'Value', 0);
        set(handles.thetaprawo, 'Value', 0);
    end
    function lewobox_Callback(source,eventdata)
        handles.wykres.ThetaZeroLocation = 'left';
        set(handles.thetagora, 'Value', 0);
        set(handles.thetadol, 'Value', 0);
        set(handles.thetaprawo, 'Value', 0);
    end
    function prawobox_Callback(source,eventdata)
        handles.wykres.ThetaZeroLocation = 'right';
        set(handles.thetagora, 'Value', 0);
        set(handles.thetadol, 'Value', 0);
        set(handles.thetalewo, 'Value', 0);
    end
    %Sectoral working mode
    function sektorbutton_Callback(source,eventdata)
        praca_sektorowa;
    end
    %Encoder reset
    function enkoderbutton_Callback(source,eventdata)
        silnik = motor(myev3, 'A');
        resetRotation(silnik);    
    end
    %Engine stop
    function stopbutton_Callback(source,eventdata)
        silnik = motor(myev3, 'A');
        silnik.Speed = 0; 
        start(silnik);    
    end
    %Clearing graph area
    function resetbutton_Callback(source,eventdata)
        cla(handles.wykres);
    end
    %Function allowing 360 deg working mode
    function praca_360
        %Creating probability OGM
        mapa = occupancyMap(6,6,str2double(get(handles.rozdzielczosc, 'String')));
        pozycja = [3,3,0];
        %Connect to ultrasonic sensor
        dalmierz = sonicSensor(myev3,1);
        %Connect to engine
        silnik = motor(myev3, 'A');
        silnik.Speed = str2double(get(handles.predkosc, 'String'));
        start(silnik);
        while true
            dystans = readDistance(dalmierz);
            obrot = readRotation(silnik);
            obrot_single = single(obrot);
            azymut = obrot_single*0.2142857142857143;
            azymut_radians = deg2rad(azymut);
            %Update OGM
            skany = lidarScan(dystans,azymut_radians);
            insertRay(mapa,pozycja,skany,str2double(get(handles.zasieg, 'String')));
            grid on;
            figure(2)
            show(mapa)
            title('Probabilistyczna mapa OGM');
            hold all
            %Graph drawing
            if dystans < str2double(get(handles.zasieg, 'String')) 
               if dystans <= 0.33*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'r.');
                  hold all
                elseif dystans < 0.66*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'g.'); 
                 hold all
                elseif dystans >= 0.66*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'b.'); 
                 hold all
                end
            end
        end 
    end
    % Function allowing sectoral working mode
    function praca_sektorowa
       %Creating probability OGM
        mapa = occupancyMap(6,6,str2double(get(handles.rozdzielczosc, 'String')));
        pozycja = [3,3,0];
        %Connect to ultrasonic sensor
        dalmierz = sonicSensor(myev3,1);
        %Connect to engine
        silnik = motor(myev3, 'A');
        silnik.Speed = str2double(get(handles.predkosc, 'String'));
        start(silnik);
        while true
            obrot = readRotation(silnik);
            if obrot*0.2142857142857143 > str2double(get(handles.sektor,'String'))
                silnik.Speed = (-1)*str2double(get(handles.predkosc, 'String'));
                start(silnik);
                resetRotation(silnik);
            elseif obrot*0.2142857142857143 < (-1)*str2double(get(handles.sektor,'String'))
                 silnik.Speed = str2double(get(handles.predkosc, 'String'));
                 start(silnik);
                resetRotation(silnik);
            end
            obrot_single = single(obrot);
             if obrot <0
                 azymut = str2double(get(handles.sektor,'String'))+(obrot_single*0.2142857142857143);
             else
                 azymut = obrot_single*0.2142857142857143;
             end
             azymut_radians = deg2rad(azymut);
             dystans = readDistance(dalmierz);
             %Update OGM
             skany = lidarScan(dystans,azymut_radians);
             insertRay(mapa,pozycja,skany,str2double(get(handles.zasieg, 'String')));
             grid on;
             figure(2)
             show(mapa)
             title('Probabilistyczna mapa OGM');
             hold all
             if dystans < str2double(get(handles.zasieg, 'String'))
                 %Real time graph update
                if dystans <= 0.33*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'r.');
                 hold all
                elseif dystans < 0.66*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'g.'); 
                 hold all
                elseif dystans >= 0.66*str2double(get(handles.zasieg, 'String'))
                 polarplot(handles.wykres,azymut_radians,dystans,'b.'); 
                hold all
                end
             end
        end
    end
end
