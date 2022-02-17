function [PSNR,SSIM,BRISQUE] = evaluate(original,sum)



PSNR = psnr(sum,original);

SSIM = ssim(sum,original);

BRISQUE = brisque(sum);

end