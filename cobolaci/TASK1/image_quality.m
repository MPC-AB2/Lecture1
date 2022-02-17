function [ssimval,peaksnr,piqe_score] =  image_quality(I_orig,I_noisy)
    peaksnr = psnr(I_noisy,I_orig);
    ssimval = ssim(I_noisy,I_orig);
    piqe_score = piqe(I_noisy);
end