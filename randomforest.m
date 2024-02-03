function [ pred ] = randomforest( xtest,xtrain,ytrain )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

t = TreeBagger(100,xtrain,ytrain,'Method', 'classification' ); %# RF100 or RF500 
 Predtree = t.predict(xtest);
 pred= str2double (Predtree);
end

