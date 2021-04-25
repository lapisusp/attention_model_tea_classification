function [sensNN, sensNb, sensSVM, precNN, precNb, precSVM] = classificationParameter(dados)

X = dados(:,2:end);
Y = dados(:,1);

cross = cvpartition(Y,'k',10);

for t = 1:10;
TPnn = 0;
TPnb = 0;
TPs = 0;
Fpnn = 0;
Fpnb = 0;
Fps = 0;
Fnn = 0;
Fnb = 0;
Fns = 0;
TNnn = 0;
TNnb = 0;
TNs = 0;
for i = 1:10
    %% SVM
    svm_params = '-s 2 -c 1 -B -1';
    model = train(Y(cross.training(i)), sparse(X(cross.training(i),:)), svm_params);
    p = model.w*X(cross.test(i),:)';
    p(p>0.2)=1;
    p(p<=0.2)=0;
    predictors{i,1} = p;
    models{i,1} = model;
    teste{i} = Y(cross.test(i));
    %% Matriz de confusão [VP FP; FN VN]
    ConfMat = confusionmat(teste{i}, predictors{i,1});
    TNs = TNs + ConfMat(1,1);
    TPs = TPs + ConfMat(2,2);
    Fns = Fns + ConfMat(2,1);
    Fps = Fps + ConfMat(1,2);
    
    %% NaiveBayes
    naiveCV = fitcnb(X(cross.training(i),:),Y(cross.training(i)));
    models{i,2} = naiveCV;
    predictors{i,2} = predict(naiveCV, X(cross.test(i),:));

    %% Matriz de confusão [VP FP; FN VN]
    ConfMatNaive = confusionmat(teste{i},predictors{i,2});
    TNnb = TNnb + ConfMatNaive(1,1);
    TPnb = TPnb + ConfMatNaive(2,2);
    Fnb = Fnb + ConfMatNaive(2,1);
    Fpnb = Fpnb + ConfMatNaive(1,2);
    
    %% NN 
     net = fitnet(10,'trainbr');
     modelnn = train(net,X(cross.training(i),:)',Y(cross.training(i))');
     p = modelnn(X(cross.test(i),:)');
     p(p>(t*0.1))=1;
     p(p<=(t*0.1))=0;
     predictors{i,3} = p;
     ConfMatNN = confusionmat(teste{i},predictors{i,3});
     TNnn = TNnn + ConfMatNN(1,1);
     TPnn = TPnn + ConfMatNN(2,2);
     Fnn = Fnn + ConfMatNN(2,1);
     Fpnn = Fpnn + ConfMatNN(1,2);
     
end

sensNN(t) = TPnn/(TPnn+Fnn);
precNN(t) = TNnn/(TNnn+Fpnn);


sensNb(t) = TPnb/(TPnb+Fnb);
precNb(t) = TNnb/(TNnb+Fpnb);


sensSVM(t) = TPs/(TPs+Fns);
precSVM(t) = TNs/(TNs+Fps);
end