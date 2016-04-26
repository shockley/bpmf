addpath('../libsvm-3.20/matlab');
load moviedata_sub
load pmf_weight
train_size = length(Y_train);
X_train = cat(2,w1_P1(1:train_size, :),X_train);
X_test = cat(2, w1_P1(train_size+1:size(w1_P1,1), :), X_test);
libsvm_model = svmtrain(Y_train, X_train);
[pl, accuracy, dc]= svmpredict(Y_test, X_test, libsvm_model);
accuracy