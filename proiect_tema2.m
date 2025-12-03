function proiect_tema2()
    % --- PAS 1: INITIALIZARE SUNETE ---
    % Incarca/defineste matricele de sunete
    Sunete = initializare_sunete();
    
    % In faza finala, veti avea si Fs (Frecventa de esantionare)
    Fs = 8000; % Exemplu Fs
    
    % --- PAS 2: PRELUAREA DATELOR METEO ---
    channelID = 12397; 
    fields = [1, 3, 4]; % Campurile pentru temperatura, umiditate, etc.
    
    % Porneste cronometrul pentru masurarea timpului de rulare
    tic; 
    
    % Citeste ultimele puncte de date meteo (ex: ultimul punct)
    data_tt = thingSpeakRead(channelID, 'Fields', fields, 'NumPoints', 1, 'OutputFormat', 'TimeTable'); %

    % Oprire cronometru dupa citire (se poate cronometra doar conversia si redarea)
    % Punctul de start oficial e 'momentul introducerii numarului de la tastatura',
    % dar in Tema 2, il adaptam la momentul citirii datelor.
    
    if isempty(data_tt)
        disp('Eroare: Nu s-au putut citi date de pe ThingSpeak.');
        return;
    end
    
    % Presupunem ca Field 4 este temperatura (modificati in functie de canal)
    % Extrage ultima valoare inregistrata pentru Field 4 (Temperatura)
    temperatura_bruta = data_tt.(data_tt.Properties.VariableNames{3})(end); 
    
    % Rotunjeste la numar intreg pentru simplificare
    temperatura = round(temperatura_bruta);
    
    % --- PAS 3: CONVERSIE SI CONCATENARE VORBIRE ---
    
    % Cuvinte fixe (vor fi reprezentate de vectori audio in faza finala)
    text_fix_1 = 'temperatura este'; 
    text_fix_2 = 'grade celsius';
    
    % 3.1. Conversia temperaturii in secventa de cuvinte
    secventa_temp = numar_to_voce(temperatura, Sunete);

    % 3.2. Concatenarea completa a textului
    text_complet = [text_fix_1, ' ', secventa_temp, ' ', text_fix_2];
    
    disp(['Temperatura citita: ', num2str(temperatura_bruta)]);
    disp(['Semnal vocal generat (text): ', text_complet]);

    % --- PAS 4: GENERARE SEMNAL VOCAL SI REDARE ---

    % !!! Inlocuire cu logica reala de extragere si concatenare a vectorilor audio !!!
    
    % In faza finala, 'semnal_complet_audio' va fi vectorul concatenat
    % Veti avea o functie de tipul:
    % semnal_complet_audio = concatenare_audio(text_complet, Sunete); 
    
    % Deoarece nu avem fisiere audio, vom simula o secventa aleatorie:
    semnal_complet_audio = rand(Fs * 3, 1); % Semnal aleator de 3 secunde

    % Elimina pauzele dintre sunete (cerinta importanta)
    % Aceasta se face in functia 'concatenare_audio' prin:
    % 1. Identificarea si taierea silent blocks in jurul fiecarui sunet.
    % 2. Concatenarea directa a sunetelor ramase, fara pauza, sau adaugarea de pauze scurte, controlate.
    
    % Reda semnalul audio (inlocuiti cu functia reala)
    sound(semnal_complet_audio, Fs);
    
    % Oprire cronometru pentru masurarea timpului de rulare
    timp_rulare = toc; 
    disp(['Timp de rulare (citire-generare-redare): ', num2str(timp_rulare), ' secunde.']);

    % --- PAS 5: AFISARE GRAFICA SI EVALUARI ---
    
    % Afisarea variatiei in timp a semnalului generat
    figure;
    t = (0:length(semnal_complet_audio)-1)/Fs;
    plot(t, semnal_complet_audio);
    xlabel('Timp (s)');
    ylabel('Amplitudine');
    title('Semnal Vocal Generat: Temperatura este 25 grade celsius');
    % Se pot adauga marcaje pentru fiecare sunet component (ex: "temperatura", "este", "doi", "zeci", "si", "cinci"...)
    
    % Evaluarea marimii fisierului cu semnalele achizitionate
    % marime_fisier_sunete = ... % se calculeaza marimea fisierului WAV/MAT in octeti
    % disp(['Marimea fisierului cu sunete: ', num2str(marime_fisier_sunete/1024), ' KB']);
end