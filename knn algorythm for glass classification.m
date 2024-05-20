%% Matlab Project 2

% Use the MANHATAN DISTANCE metric
% | x 1 − x 2 | + | y 1 − y 2 |
% sum ( |Ai - Bi| ) where i belongs to  N

A = Manhattan(GlassData, TestData, 1, 1)
Comparison(GlassClasses, GlassData, A, 1)



function Class = Comparison(GlassClasses, GlassData, lista, numer_test)

    for i = 1:length(GlassClasses)
        Manhattan(GlassData, TestData, numer_test = TestData(numer_test), numer = 1); % initalizing Manhattan() at row 1 in data table 
        numer = numer+1;
    end
   Class; 
end



function [lista] = Manhattan(tabela,test,numer_test, numer)
%Funkcja określa różnicę miedzy elementami odpowiednich wierszy w TestData
%i GlasData

% tabela -> GlassData
% test -> TestData
% numer_test -> Test index
% numer -> Data index


ncol = size(tabela,2); %sprawdzamy liczbę kolumn;
a = 1;
lista = [];

while ncol > a

element = abs(tabela(numer,a) - test(numer_test,a));
lista = [lista,element];
a = a + 1;

end

lista;
end

