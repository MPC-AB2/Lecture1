import cv2
import numpy as np
import imquality.brisque as brisque
from matplotlib import pyplot as plt
from skimage.metrics import structural_similarity
from scipy.ndimage import gaussian_filter
from scipy import signal, fft


if __name__ == '__main__':
    img2 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(noisy_image).png',
                      cv2.IMREAD_GRAYSCALE)
    img1 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(original_image).png',
                      cv2.IMREAD_GRAYSCALE)
    # psnr = cv2.PSNR(img2, img1)
    # print(f"PSNR: {psnr}")
    # ssim = structural_similarity(img2, img1, data_range=img2.max() - img2.min())
    # print(f"SSIM: {ssim}")
    #
    # brisque_score = brisque.score(img2)
    # print(f"Brisque: {brisque_score}")

    # 5.
    ## Gaussian
    sigma = 5
    gauss = gaussian_filter(img2, sigma=sigma, order=0)

    ## Wiener

    def gaussian_kernel(kernel_size=3):
        h = signal.gaussian(kernel_size, kernel_size/3).reshape(kernel_size, 1)
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

    kernel = gaussian_kernel(5)
    weiner = wiener_filter(img2, kernel, K=5)

    plt.figure()
    plt.subplot(2, 4, 1)
    plt.imshow(img1, cmap="gray")
    plt.axis('off')

    plt.subplot(2, 4, 2)
    plt.imshow(gauss, cmap="gray")
    plt.axis('off')

    plt.subplot(2, 4, 3)
    plt.imshow(weiner, cmap="gray")
    plt.axis('off')

    plt.show()




