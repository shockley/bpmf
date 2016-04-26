%function [pred_out] = impute(w1_M1, w1_P1, X);
load moviedata_sub
%[I,J,V]=find(X);
%train_vec = [I,J,V];
mean_rating = mean(train_vec(:,3));
empties = max(I)*max(J) - train_vec(size,1);
imputed_vec = zeros(empties, 3);
imputed = 0;
for i = 1:max(I)
	for j = 1:max(J)
		B = ismember((i,j),train_vec(:,1:2), 'row')
		if B(1) > 0
			imputed = imputed + 1;
			imputed_vec(imputed,1:2) = (i,j);
		end
	end
end
assert imputed == empties;
%%% Make predicitions on the validation data

aa_p   = double(imputed_vec(:,1));
aa_m   = double(imputed_vec(:,2));
%rating = double(imputed_vec(:,3));

pred_out = sum(w1_M1_sample(aa_m,:).*w1_P1_sample(aa_p,:),2) + mean_rating;
ff = find(pred_out>5); pred_out(ff)=5;
ff = find(pred_out<1); pred_out(ff)=1;
imputed_vec(:,3) = pred_out;
all_vec = cat(train_vec, imputed_vec, 1);
ImX = sparse(all_vec(:,1), all_vec(:,2), all_vec(:,3))
save Imx.mat Imx



 
