clear;
close all;
%% Read Image
I = imread('name8.jpg');
imshow(I)

%% Convert to grayscale image
Igray = rgb2gray(I);

for i = 1:8
I2 = Igray(:,(i*640)-639 : (i*640));
[M,I] = max(I2(:));
[I_row, I_col] = ind2sub(size(I2),I)

BW = I2 > 0.9 * M;
s = regionprops(BW,'centroid');
centroids = cat(1, s.Centroid);

s1 = regionprops(BW,'BoundingBox');
max_area = 0;
for k = 1 : length(s1)
temp = s1(k).BoundingBox;
if(temp(3)*temp(4) > max_area  )
bbox = s1(k).BoundingBox;
max_area = bbox(3)*bbox(4);
end
end
rectangle('Position', [bbox(1)+(640*(i-1)),bbox(2),bbox(3),bbox(4)],...
  'EdgeColor','r','LineWidth',2 )
hold on
plot(centroids(:,1)+(640*(i-1)),centroids(:,2), 'b*')
plot(1,1,'r');
num_k = 0;
tmp = I2;
tmp(tmp < 0.5*M) = Inf;
[M,I] = min(tmp(:));
[I_row, I_col] = ind2sub(size(tmp),I)
BW1 =  tmp < 1.1*M;
s3 = regionprops(BW1,'centroid');
centroids1 = cat(1, s3.Centroid);
s4 = regionprops(BW1,'BoundingBox');
min_area = Inf;
for k = 1 : length(s4)
temp = s4(k).BoundingBox;
if(temp(3)*temp(4) < min_area)
bbox = s4(k).BoundingBox;
min_area = bbox(3)*bbox(4);
num_k  =  k;
end
end

hold on

plot(centroids1(num_k,1)+(640*(i-1)),centroids1(num_k,2), 'g*')
leg = legend('0% velocity(hand stopped)','Possible finish point','100% velocity(fastest point)');
pos = get(leg,'position');
set(leg, 'position',[pos(1) pos(2)*1.25 pos(3:4)]);
end