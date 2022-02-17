import cv2
import numpy as np
import imquality.brisque as brisque
from matplotlib import pyplot as plt
from skimage.metrics import structural_similarity
from skimage.restoration import denoise_tv_chambolle
from scipy.ndimage import gaussian_filter
from scipy import signal, fft

from fastaniso import anisodiff

if __name__ == '__main__':
    img2 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(noisy_image).png',
                      cv2.IMREAD_GRAYSCALE)
    img1 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(original_image).png',
                      cv2.IMREAD_GRAYSCALE)
    psnr = cv2.PSNR(img2, img1)
    print(f"PSNR: {psnr}")
    ssim = structural_similarity(img2, img1, data_range=img2.max() - img2.min())
    print(f"SSIM: {ssim}")

    brisque_score = brisque.score(img2)
    print(f"Brisque: {brisque_score}")

    # 5.
    ## Gaussian
    sigma = 2
    gauss = gaussian_filter(img2, sigma=sigma, order=0)


    ## Wiener
    def gaussian_kernel(kernel_size=3):
        h = signal.gaussian(kernel_size, kernel_size / 3).reshape(kernel_size, 1)
        h = np.dot(h, h.transpose())
        h /= np.sum(h)
        return h


    def wiener_filter(img, kernel, K):
        kernel /= np.sum(kernel)
        dummy = np.copy(img)
        dummy = fft.fft2(dummy)
        kernel = fft.fft2(kernel, s=img.shape)
        kernel = np.conj(kernel) / (np.abs(kernel) ** 2 + K)
        dummy = dummy * kernel
        dummy = np.abs(fft.ifft2(dummy))
        return dummy


    kernel = gaussian_kernel(3)
    wiener_filt = wiener_filter(img2, kernel, K=1)

    ## Adaptive Wiener filter
    img_wiener = signal.wiener(img2, (7, 7), 10)

    ## Bilateral filter
    img_bilateral = cv2.bilateralFilter(img2, 10, 90, 90)

    img_aniso = anisodiff(img2)

    ## Total variation filter
    img_tv = denoise_tv_chambolle(img2, weight=0.1)

    ## Non-local means
    img_nl = cv2.fastNlMeansDenoising(img2, h=27, templateWindowSize=7, searchWindowSize=21)

    plt.figure(figsize=(16, 9), dpi=100)
    ax1 = plt.subplot(2, 4, 1)
    ax1.imshow(img2, cmap="gray")
    ax1.set_title(f"Original noise image, SNR: {cv2.PSNR(img2, img1):.2f}")
    ax1.axis('off')

    ax2 = plt.subplot(2, 4, 2)
    ax2.imshow(gauss, cmap="gray")
    ax2.set_title(f"Gaussian filter, SNR: {cv2.PSNR(gauss, img1):.2f}")
    ax2.axis('off')

    ax3 = plt.subplot(2, 4, 3)
    ax3.imshow(wiener_filt, cmap="gray")
    ax3.set_title(f"Wiener filter, SNR: {cv2.PSNR(wiener_filt.astype('uint8'), img1):.2f}")
    ax3.axis('off')

    ax4 = plt.subplot(2, 4, 4)
    ax4.imshow(img_wiener, cmap='gray')
    ax4.set_title(f"Adaptive Wiener filter, SNR: {cv2.PSNR(img_wiener.astype('uint8'), img1):.2f}")
    ax4.axis('off')

    ax5 = plt.subplot(2, 4, 5)
    ax5.imshow(img_bilateral, cmap='gray')
    ax5.set_title(f"Bilateral filter, SNR: {cv2.PSNR(img_bilateral, img1):.2f}")
    ax5.axis('off')

    ax6 = plt.subplot(2, 4, 6)
    ax6.imshow(img_aniso, cmap='gray')
    ax6.set_title(f"Anisotropic diffusion, SNR: {cv2.PSNR(img_aniso.astype('uint8'), img1):.2f}")
    ax6.axis('off')

    ax7 = plt.subplot(2, 4, 7)
    ax7.imshow(img_tv, cmap='gray')
    ax7.set_title(f"Total variation filter, SNR: {cv2.PSNR(img_tv.astype('uint8'), img1):.2f}")
    ax7.axis('off')

    ax8 = plt.subplot(2, 4, 8)
    ax8.imshow(img_nl, cmap='gray')
    ax8.set_title(f"Non-local means, SNR: {cv2.PSNR(img_nl, img1):.2f}")
    ax8.axis('off')

    plt.savefig("filters.tiff")

    plt.show()
