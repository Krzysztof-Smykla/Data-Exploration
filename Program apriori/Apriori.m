function [occurances_with_min_support, lista_par] = Apriori(matryca, minimal_support)

%Apriori umożliwia wykrywanie zależności w zbiorze danych
%Najpierw zliczamy wszystkie typy jednostek (unique values in data)
%Najcześciej usuwa się najrzadsze poniżej pewnego progu (min. zaufanie)
%Potem z pozostałych jednostek tworzymy pary, też usuwamy najrzadsze

%funkcja rozpoczyna działanie tylko w przypadku poprawnego min. zaufania
%tzn. wpisana została wartość mniejsza lub równa 1 i większa lub równa 0

if (0 <= minimal_support) && (minimal_support <= 1) 

    %_________________________________________________________________
    %krok 1.1 - tworzenie tabeli, która zlicza występowanie przypadków

    amount_of_values = unique(matryca);
    occurances = [amount_of_values,amount_of_values];
    a = size(amount_of_values,1);

    
    for c = 1:(a-1)
        occurances(c+1,2) = sum(sum(matryca==c)); 
        %podwójna suma, ponieważ pierwsza sumuje w ramach kolumn,
        %tworząc wiersz z 12 liczbami, zamienianymi w jedną liczbę przez drugą sumę
    end 

    disp(" ")
    Raport = [num2str(a), ' unique elements in the matrix'];
    disp(Raport)
    

    %____________________________________________________________________________
    %krok 1.2 - usunięcie przypadków o częstotliwości mniejszej niż min. zaufania
    X = ['Removing numbers below min. support threshold: ',num2str(minimal_support*100),'%'];
    disp(X)

    element_sum = sum(occurances(:,2));
    occurances_with_min_support = [];

    for c = 1:(a-1)
    
    procent = occurances(c+1,2) ./ element_sum;
    %każdemu elementowi przypisujemy procent występowania (PW)

        if procent >= minimal_support

            occurances_with_min_support(c+1,:) = occurances(c+1,:);
            %elementy z PW powyżej min. przechodzą do następnego etapu

        end
     
    end

    %tutaj (najprawdopodobniej) usuwamy komórki z zerami
    OWMS = occurances_with_min_support;
    OWMS = OWMS(any(OWMS,2),any(OWMS,1)); 
    occurances_with_min_support = OWMS;


    %________________________
    %Krok 2.1 - tworzenie par 
    %(za pomocą byćmoże nie najbardziej efektywnego, ale własnego kodu)
    
    a = size(occurances_with_min_support,1);
    
    if a > 1

        Raport = [num2str(a), ' elements remaining'];
        disp(Raport)
        
        lista_par = [];
        for c = 1:a

            numbers_for_pairing = occurances_with_min_support(c:a,1);
            b = size(numbers_for_pairing,1);

            for d = 1:b 
                
                if occurances_with_min_support(c,1) == numbers_for_pairing(d,1)
                    continue 
                    %żeby funkcja nie tworzyła par tych samych elementów,
                    %np. 100 - 100, 1 - 1, itd.

                else 
                    nowa_para = [occurances_with_min_support(c,1),numbers_for_pairing(d,1)];
                    lista_par = [lista_par; nowa_para];

                end

            end 

        end

    elseif  a == 1
        disp("There is only one number left, can't create any pairs")

    else
        disp("There are no valid numbers left, no pairs will be created")
        lista_par = [];

    end


    %_____________________________
    %2.2 - szukanie par w macierzy

    a = size(lista_par,1);
    if a >= 0
        
        Raport_Par = [num2str(a) ,' pairs were created.'];
        disp(Raport_Par)
        
        for c = 1:a

            want = [lista_par(c,1), lista_par(c,2)];
    
            size_matryca = size(matryca,1);
            idx = false(size_matryca,1);
            
            for ii = 1:size_matryca
                idx(ii) = all(ismember(want, matryca(ii,:)));
            end
            
            lista_par(c,3) = sum(idx);

        end
    
    end


    %_____________________________________________
    %3 - usuwanie par poniżej minimalnego zaufania


else
    %funkja nie rozpoczyna działania bez poprawnych danych
    disp("Wrong value for minimal support, it must be 0 <= x <= 1")

end

%{
H = height(occurances_with_min_support);
    pair_count = sum(lista_par(:,3));
    Percent = (H./pair_count) .* 100;
    
    Text = ["Ratio of pairs within minimal support is", Percent ,"%"];


    disp(Text);  
%}

%3 - usuwanie par poniżej minimalnego zaufania
    
    %zliczamy sumę wystąpień par stworzonych z zweryfikowanych par
    pairs_total = sum(lista_par(:,3));

    %a - liczba różnych par
    %b - zmienna do nadawania numerów parom powyżej min. support
    a = size(lista_par,1);
    b = 1;

    %matryca zweryfikowanych par - 4 zera wyznaczają 4 wymiary
    %matlab przyczepia się, jeżeli na wejściu nie ustalimy wymiarowości
    lista_zweryfikowanych_par = [0 0 0 0;];

    for c = 1:a 
        
        %do "listy par" dodaje kolumne nr.4 = współczynnik wystąpień
        support_test = lista_par(c,3) ./ pairs_total;
        lista_par(c,4) = support_test;

        %do "zweryfikowanych par: dajemy zweryfikowane pary
        %zweryfikowana para oznacza występującą powyżej min. support
        if support_test >= minimal_support

            lista_zweryfikowanych_par(b,:) = lista_par(c,:);
            b = b + 1;

        end

    end
end


    

