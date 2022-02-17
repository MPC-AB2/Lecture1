function [PSNR,SSIM,BRISQUE] = evaluate(original,sum)

Lenna_sum = imread(sum);
Lenna_orig = imread(original);

Lenna_sum_gray = rgb2gray(Lenna_sum);
Lenna_orig_gray = rgb2gray(Lenna_orig);

PSNR = psnr(Lenna_sum_gray,Lenna_orig_gray);

SSIM = ssim(Lenna_sum_gray,Lenna_orig_gray);

BRISQUE = brisque(Lenna_sum_gray);

end