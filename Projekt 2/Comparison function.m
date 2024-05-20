%Tests 
A1 = Comparison(GlassClasses, GlassData, TestData, 1);
A2 = Comparison(GlassClasses, GlassData, TestData, 2);
A3 = Comparison(GlassClasses, GlassData, TestData, 3);
A4 = Comparison(GlassClasses, GlassData, TestData, 4);
A5 = Comparison(GlassClasses, GlassData, TestData, 5);
A6 = Comparison(GlassClasses, GlassData, TestData, 6);
A7 = Comparison(GlassClasses, GlassData, TestData, 7);
A8 = Comparison(GlassClasses, GlassData, TestData, 8);
A9 = Comparison(GlassClasses, GlassData, TestData, 9);
A10 = Comparison(GlassClasses, GlassData, TestData, 10);

function Class = Comparison(GlassClasses, GlassData, TestData, k)
    min_distance = inf;
    closest_class = '';
    
    for i = 1:length(GlassClasses)
        dist = Manhattan(GlassData, TestData, k, i);
        if dist < min_distance
            min_distance = dist;
            closest_class = GlassClasses{i};
        end
    end

    Class = closest_class;
end

function dist = Manhattan(tabela, test, numer_test, numer)
    ncol = size(tabela, 2);
    dist = 0;

    % Use the MANHATTAN DISTANCE metric
    % sum ( |Ai - Bi| ) where i belongs to N
    for a = 1:ncol
        element = abs(tabela(numer, a) - test(numer_test, a));
        dist = dist + element;
    end
end
