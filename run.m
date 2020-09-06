%Retinal vessel segmentation using anisotropic diffusion and laplacian
%pyramid
%Implementation adapted from Dachsel et al. 

clc, close all, clear all
addpath('./dataset')

%% load fundus image
%If loading the data directly from the dataset, set the file path
%accordingly
I=imread('03_h.jpg');
GT=imread('03_h.tif');
mask=imread('03_h_mask.tif');
imtool(I);

%%load DRIVE image
%I=imread('25_training.tif');
%I = imresize(I,[2048 2048]);
%GT=imread('25_manual1.gif');
%GT = imresize(GT,[2048 2048]);
%mask=imread('25_training_mask.gif');
%mask = imresize(mask,[2048 2048]);
%imtool(I);
%imtool(GT);
%imtool(mask)

%Gamma Correction
I = lin2rgb(I,'ColorSpace','srgb');
imtool(I);

mask=mask(:,:,1);
mask=(mask/255);
GT=double(GT/255);

%Extracting the green channel for best contrast
I=I(:,:,2); 
imtool(I);
%histogram(I);

I = adapthisteq(I);
imtool(I);

edgeThreshold = 0.60;
amount = 0.40; %0.46 gives lower sensitivity and higher specificity
I = localcontrast(I, edgeThreshold, amount);
%histogram(I);
imtool(I);

I=double(I);

diff_coeff = 60;

%% Anisotropic diffusion
aniso_I = anisotropic_diffusion(I, 10, diff_coeff);
imtool(aniso_I);

 
 %% Parameters
 a=0.2;   % reduction paramter for generating gaussian pyramid
 m=512;   % contrast colors
 T=0.105;  % binarization threshold 0.10 gives higher sensitivity and lower specificity
 k=0.056; % connected components
 
 
 %% Laplace Pyramid framework
 [L2,L3,L4]=L_pyramid(aniso_I,a,m);
 imtool(L2);
 imtool(L3);
 imtool(L4);
 
 [S2,S3,S4]=Conn_comp(L2,L3,L4,T,k);
 imtool(S2);
 imtool(S3);
 imtool(S4);
 S=fusion(S2,S3,S4,mask,a);
 
 %% Evaluation and Plot
 %bf_score = bfscore(S,GT) 
 [sens,spec,acc]=evaluation(S,GT);
 imtool(S);







