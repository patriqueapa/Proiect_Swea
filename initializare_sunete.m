function [Sunete] = initializare_sunete()
    % Functie pentru incarcarea/initializarea vectorilor de sunete.
    % In Faza I a proiectului (testare logica), se folosesc string-uri.
    
    % --- PARAMETRI AUDIO ---
    % Frecventa de esantionare (exemplu)
    Fs = 8000; %
    % Durata standard a unui segment (0.5s)
    durata_segment = 0.5;
    % Numarul de esantioane pe segment
    num_esantioane = round(Fs * durata_segment);
    
    % --- DEFINITII SUNETE (LOGICA CU STRING-URI) ---
    % Simulam ca fiecare linie este un vector de sunet
    % In faza finala, fiecare element va fi un vector audio (coloana)

    % Cifre (1-9)
    Sunete.Cifre = {
        'unu', 'doi', 'trei', 'patru', 'cinci', 'sase', 'sapte', 'opt', 'noua'
    };
    
    % Numarul 10
    Sunete.Zece = 'zece';

    % Numerele 11-19 (necesita inregistrare separata 'unsprezece', 'doisprezece', etc. sau concatenare 'spre' + cifra)
    Sunete.Unu_Nouasprezece = {
        'unu', 'doi', 'trei', 'patru', 'cinci', 'sase', 'sapte', 'opt', 'noua', ... % 1-9
        'zece', 'unsprezece', 'doisprezece', 'treisprezece', 'paisprezece', ... % 10-14
        'cincisprezece', 'saisprezece', 'saptesprezece', 'optsprezece', 'nouasprezece' % 15-19
    };
    
    % Zeci (20, 30, ..., 90)
    Sunete.Zeci = {
        'douazeci', 'treizeci', 'patruzeci', 'cincizeci', ...
        'saizeci', 'saptezeci', 'optzeci', 'nouazeci'
    };
    
    % Cuvinte de legatura
    Sunete.Legatura.Mie = 'mii';
    Sunete.Legatura.Sute = 'sute';
    Sunete.Legatura.Si = 'si';
    
    % --- INCARCARE SUNETE AUDIO REALE (COMENTAT) ---
    % % In faza finala, inlocuiti cele de mai sus cu:
    % % Sunete.Cifre_Audio = incarcare_din_fisier('cifre.mat'); % O matrice unde fiecare linie e un sunet
    % % [Sunete.Zeci_Audio, Fs] = audioread('zeci.wav');
end