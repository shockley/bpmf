%function [pred_out] = impute(w1_M1, w1_P1, X);
load pmf_weight
load moviedata_all
%[I,J,V]=find(X);
%train_vec = [I,J,V];
mean_rating = mean(train_vec(:,3));
X = full(sparse(train_vec(:,1), train_vec(:,2), train_vec(:,3)));
n_users = size(X,1);
n_items = size(X,2);
nnz(X)
empties = n_users*n_items - nnz(X);
imputed_vec = zeros(empties, 3);
imputed = 0;
for i = 1:n_users
	for j = 1:n_items
		if X(i,j) ~= 0
			imputed = imputed + 1;
			imputed_vec(imputed,1:2) = [i,j];
		end
	end
end

%%% Make predicitions on the validation data

aa_p   = double(imputed_vec(:,1));
aa_m   = double(imputed_vec(:,2));
%rating = double(imputed_vec(:,3));

pred_out = sum(w1_M1(aa_m,:).*w1_P1(aa_p,:),2) + mean_rating;
ff = find(pred_out>5); pred_out(ff)=5;
ff = find(pred_out<1); pred_out(ff)=1;
imputed_vec(:,3) = pred_out;
all_vec = cat(train_vec, imputed_vec, 1);
Im_X = sparse(all_vec(:,1), all_vec(:,2), all_vec(:,3))
save Imx.mat Im_x



 
