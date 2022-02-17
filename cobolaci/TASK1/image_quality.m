function [ssimval,peaksnr,piqe_score] =  image_quality(I_orig,I_noisy)
    I_noisy = imread( "Lenna_(noisy_image).png");
    I_orig = imread("Lenna_(original_image).png");
    peaksnr = psnr(I_noisy,I_orig);
    ssimval = ssim(I_noisy,I_orig);
    piqe_score = piqe(A);
end