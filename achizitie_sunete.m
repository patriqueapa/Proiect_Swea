%% Program pentru înregistrarea și salvarea sunetelor necesare
clear; clc;

% Configurații
Fs = 8000;          % Frecvența de eșantionare (8 kHz conform cerinței)
durata = 1;         % Durata fiecărei înregistrări (1 secundă)
nBits = 16;
nChannels = 1;

% Listele de cuvinte necesare pentru Tema 3 și Tema 2
cifre_list = {'unu', 'doi', 'trei', 'patru', 'cinci', 'sase', 'sapte', 'opt', 'noua'};
zeci_list = {'zece', 'unsprezece', 'doisprezece', 'treisprezece', 'paisprezece', ...
             'cincisprezece', 'saisprezece', 'saptesprezece', 'optsprezece', 'nouasprezece'};
legaturi = {'suta', 'sute', 'mie', 'mii', 'zeci', 'si', 'temperatura', 'grade'};

toate_cuvintele = [cifre_list, zeci_list, legaturi];

% Inițializare recorder
recorder = audiorecorder(Fs, nBits, nChannels);

disp('--- START ACHIZIȚIE SUNETE ---');
disp('Instrucțiuni: După fiecare mesaj, pronunță clar cuvântul indicat.');

for i = 1:length(toate_cuvintele)
    cuvant = toate_cuvintele{i};
    
    fprintf('\nPregătește-te pentru: "%s"\n', cuvant);
    pause(1); % Pauză scurtă pentru pregătire
    
    disp('ÎNREGISTREAZĂ ACUM...');
    recordblocking(recorder, durata); 
    disp('STOP.');
    
    % Extragere date audio
    audio_data = getaudiodata(recorder);
    
    % Salvare în format .wav
    nume_fisier = [cuvant, '.wav'];
    audiowrite(nume_fisier, audio_data, Fs);
    fprintf('Salvat: %s\n', nume_fisier);
end

disp('--- ACHIZIȚIE FINALIZATĂ ---');