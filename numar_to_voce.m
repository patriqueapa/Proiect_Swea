function [secventa_text] = numar_to_voce(numar_introdus, Sunete)
    % Converteste un numar de max. 4 cifre in secventa de text (sau vectori audio, in final)
    
    numar_str = num2str(numar_introdus); %
    lungime = length(numar_str);
    secventa_text = {};

    % Extrage cifrele in ordine inversa
    cifre = arrayfun(@str2double, numar_str);
    
    % Implementarea logicii de conversie (bazata pe documentul de proiect)
    % Ex. 4527: patru mii cinci sute doua zeci si sapte.
    
    % 1. Mii (cifra 4)
    if lungime == 4
        cifra_mii = cifre(1);
        if cifra_mii > 0
            % Sunetul cifrei (ex: 'patru')
            secventa_text{end+1} = Sunete.Cifre{cifra_mii};
            % Cuvantul 'mii' (ex: 'mii')
            secventa_text{end+1} = Sunete.Legatura.Mie; 
        end
        % Continua cu sutele
        cifre = cifre(2:4);
        lungime = 3;
    end
    
    % 2. Sute (cifra 5)
    if lungime >= 3
        cifra_sute = cifre(1);
        if cifra_sute > 0
            % Sunetul cifrei (ex: 'cinci')
            secventa_text{end+1} = Sunete.Cifre{cifra_sute};
            % Cuvantul 'sute' (ex: 'sute')
            secventa_text{end+1} = Sunete.Legatura.Sute;
        end
        % Continua cu zecile/unitatile
        cifre = cifre(2:3);
        lungime = 2;
    end
    
    % 3. Zeci si unitati (cifrele 27)
    if lungime >= 1
        ultimele_doua = str2double(strcat(num2str(cifre)));
        
        if ultimele_doua >= 10 && ultimele_doua <= 19 % 10-19: 'zece', 'unsprezece', etc.
             % Folosim matricea speciala 1-19
             index_11_19 = ultimele_doua;
             secventa_text{end+1} = Sunete.Unu_Nouasprezece{index_11_19};
        elseif ultimele_doua >= 20 % 20-99
            cifra_zeci = cifre(1);
            cifra_unitati = cifre(2);
            
            % Zeci (20, 30, ...)
            index_zeci = cifra_zeci - 1; % Zecile incep de la index 1 ('douazeci')
            secventa_text{end+1} = Sunete.Zeci{index_zeci};
            
            % Daca sunt si unitati (ex: 27)
            if cifra_unitati > 0
                secventa_text{end+1} = Sunete.Legatura.Si; % 'si'
                secventa_text{end+1} = Sunete.Cifre{cifra_unitati};
            end
        elseif ultimele_doua > 0 % 1-9
            cifra_unitati = cifre(end);
            secventa_text{end+1} = Sunete.Cifre{cifra_unitati};
        end
    end
    
    % In faza finala: Concatenati vectorii audio in loc de siruri
    % Deocamdata, concatenam sirurile intr-un singur string pentru afisare
    secventa_text = strjoin(secventa_text, ' '); 
end