methods = {'nn'; 'svm'; 'svmG'};
selects = {'all'; 'ga'; 'relief'};
for m = 1:3
    for s = 1:3
     execClass(methods(m),selects(s))
    end
end