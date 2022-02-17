import os
import cv2
import glob
import numpy as np
import imquality.brisque as brisque
from matplotlib import pyplot as plt
from skimage.metrics import structural_similarity
from skimage.restoration import denoise_tv_chambolle, denoise_wavelet
from scipy.ndimage import gaussian_filter
from scipy import signal, fft



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


if __name__ == '__main__':
    kernel = gaussian_kernel(3)
    paths = glob.glob("/Users/ondra/dev/school/Lecture1/prvni/task2/Lecture1_second_data/images_noise/*.jpg")
    for path in paths:
        img = cv2.imread(path)
        img_bilateral = cv2.bilateralFilter(img, 10, 90, 90)
        # wiener_filt_1 = wiener_filter(img[:, :, 0], kernel, K=1)
        # wiener_filt_2 = wiener_filter(img[:, :, 1], kernel, K=1)
        # wiener_filt_3 = wiener_filter(img[:, :, 2], kernel, K=1)
        #
        # img_wiener = img.copy()
        # img_wiener[:, :, 0] = wiener_filt_1
        # img_wiener[:, :, 1] = wiener_filt_2
        # img_wiener[:, :, 2] = wiener_filt_3
        # img_nl = cv2.fastNlMeansDenoisingColored(img)
        # img_dn = denoise_tv_chambolle(img, weight=0.1)
        # img_dn = denoise_wavelet(img, convert2ycbcr=True, rescale_sigma=True, multichannel=True)
        # plt.imshow(img_dn)
        # plt.show()
        cv2.imwrite(os.path.join("/Users/ondra/dev/school/Lecture1/prvni/task2/Lecture1_second_data/image_denoise4", os.path.basename(path)), img_bilateral.astype('uint8'))
        break
