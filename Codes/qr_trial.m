video_path = 'bgm_crop.mp4';
v = VideoReader(video_path);
h = v.Height;
w = v.Width;
img = readFrame(v);
imshow(img)
%%
vidObj = VideoReader('bgm_crop.mp4');  % video file 
%% Read the video frame by frame 
numFrames = 0;
total = int16(fix(vidObj.FrameRate*vidObj.Duration));
A= zeros(6080,total);    
for i=1:total
    F = readFrame(vidObj); 
    numFrames = numFrames + 1; 
    grey = rgb2gray(F);
    %%imshow(grey)
    J = imresize(grey,[80 76]);
    imshow(J)
    imgVector = reshape(J,[],1);
    A(:,numFrames)= imgVector;
end
%%
figure('name','Original Matrix')
imagesc(A)
colormap(gray(256))
%%
[Q,R,P] = qr(A);
trial = Q * R;
figure('name','QR Matrix')
imagesc(trial)
colormap(gray(256))
%%
rec250 = reshape(A(:,250),80,76);
figure('name','Original Frame')
imagesc(rec250)
colormap(gray(256))
back350 = reshape(trial(:,350),80,76);
figure('name','Background')
imagesc(back350)
colormap(gray(256))
fore250= rec250-back350;
figure('name','Foreground')
imagesc(fore250)
colormap(gray(256))
