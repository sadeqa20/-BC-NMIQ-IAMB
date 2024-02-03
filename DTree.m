function ppred=DTree (xtest,xtrain,ytrain)
DTreeModel=ClassificationTree.fit(xtrain,ytrain);
ppred=DTreeModel.predict(xtest);
end