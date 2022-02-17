function [PSNR,SSIM,NIQE,PIQE] = quality(orig,noisy);
    SSIM = ssim(orig,noisy);
    PSNR = psnr(orig,noisy);
    NIQE = niqe(noisy);
    PIQE = piqe(noisy);
end