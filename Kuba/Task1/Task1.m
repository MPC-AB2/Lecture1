clear all; clc; close all

im = imread('Lenna_(noisy_image).png');
im = imgaussfilt(im, 5);
imshow(im,[])