addpath('../libsvm-3.20/matlab');


[Y, X] = libsvmread('ml1m_d.sparse');
X = sparse(X);
n_users = size(X,1)
n_items = size(X,2)
[I,J,V] = find(X);
all_vec = [I,J,V];
train_vec = all_vec;
probe_vec = train_vec;
save moviedata_all.mat train_vec probe_vec;

perm = randperm(n_users);
test_size = int32(n_users * 0.20); %train_size = 4832
test_idx = perm(1:test_size);
train_idx = perm(test_size + 1: length(perm));
X_test = X(test_idx, :);
Y_test = Y(test_idx);
X_train = X(train_idx, :);
Y_train = Y(train_idx);
%libsvm_model = svmtrain(Y_train, X_train);
%[pl, accuracy, dc]= svmpredict(Y_test, X_test, libsvm_model);
save moviedata_split.mat X_train X_test Y_train Y_test;

