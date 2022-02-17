function [I_filt] = filter_image(I_orig);
sigma = 3.5;
 I_filt = uint8(zeros(size(I_orig,1),size(I_orig,2),3));
for i = 1:3
    I_filt(:,:,i) = imgaussfilt(I_orig(:,:,i),sigma);
end

end