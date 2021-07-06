video_path = 'road_traffic.mp4';
v = VideoReader(video_path);
h = v.Height
w = v.Width

%%
vidObj = VideoReader('road_traffic.mp4');  % video file 
%% Read the video frame by frame 
numFrames = 0;
iwant = cell([],1) ; 
total = int16(fix(vidObj.FrameRate*vidObj.Duration));
A= zeros(total,w*h);    
for i=1:total
    F = readFrame(vidObj); 
    numFrames = numFrames + 1; 
    grey = rgb2gray(F);
    %imagesc(grey)
    %drawnow
    imshow(grey)
    imgVector = reshape(grey,1,[]);
    A(numFrames,:)= imgVector;
    iwant{numFrames} = F ;
end
%%
figure('name','Original Matrix')
imagesc(A)
colormap(gray(256))
rec250 = reshape(A(250,:),h,w);
figure('name','Original Frame')
imagesc(rec250)
colormap(gray(256))
%% rsvd part
K=2
[M,N] = size(A);
P = min(2*K,N);
X = randn(N,P);
Y = A*X;
W1 = orth(Y);
B = W1'*A;
[W2,S,V] = svd(B,'econ');
U = W1*W2;
K=min(K,size(U,2));
U = U(:,1:K);
S = S(1:K,1:K);
V = V(:,1:K);
whole_back = U* S * V';
%%
figure('name','Static 2D Matrix')
imagesc(whole_back)
colormap(gray(256))
back250 = reshape(whole_back(250,:),h,w);
figure('name','Background')
imagesc(back250)
colormap(gray(256))
fore250= rec250-back250;
figure('name','Foreground')
imagesc(fore250)
colormap(gray(256))