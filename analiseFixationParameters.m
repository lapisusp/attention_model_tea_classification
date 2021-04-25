%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\J�ssica\Documents\MEGAsync\Projeto final\Data\dadosBiologico.xlsx
%    Worksheet: tabelaPAnalise
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/11/11 17:21:15

addpath(genpath('.'));

load('./Data/tobiiData.mat');

%initialize liblinear
addpath('Train_Test/lib/liblinear');
cd Train_Test/lib/liblinear
make
cd ../../..


%% Import the data

X = cell2mat(tobiiData(:,4:end));
Y = cell2mat(tobiiData(:,3));

[r,w] = relieff(X,Y,100);
bar(w(r));

features = GA_feature_selector(5,X,Y);

v = 6;
Xnew = X(:,features);

%% Classifica��o
[sensNN, sensNb, sensSVM, precNN, precNb, precSVM] = classificationParameter([Y Xnew]);