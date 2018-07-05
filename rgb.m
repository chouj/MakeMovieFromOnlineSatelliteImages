%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Making Movie/Animation From Online Satellite Images of 
% Space Science and Engineering Center at University of Wisconsin-Madison

% Description:
%    Use "regexp" to find urls of images and use curl command to download them.


% 从威斯康星大学麦迪逊分校的空间科学与工程中心提供的向日葵8号卫星RGB色彩图生成动画
% 通过正则表达式获取图片链接，再用curl命令下载至本地

% Note:
%     Windows code.
%     Curl command line tool is required. (https://curl.haxx.se/)
%     Noncommercial use only.

% Author: github.com/chouj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get url of target images
test=urlread('http://www.ssec.wisc.edu/data/geo/images/himawari08/animation_images/');
t = regexp(test,'himawari08_(.*?)_rgb_fd.gif','tokens');
for i=1:length(t)/2;
    tt{i}=t{i*2};
end

vidObj = VideoWriter('.\rgb.mp4','MPEG-4');
vidObj.FrameRate=10;
vidObj.Quality=80;
open(vidObj);
    
i=1;
while(i<=length(tt))
    disp(i/length(tt));
    try
        name=['http://www.ssec.wisc.edu/data/geo/images/himawari08/animation_images/himawari08_',tt{i}{1},'_rgb_fd.gif'];
        [str,stats]= urlread(name);
        if stats==1
            curlcommand=['c:\curl\bin\curl -o .\temp.jpg ',name]; % modify your curl command path accordingly
            system(curlcommand);
            [I,map]=imread('c:\CloudGif\temp.jpg');
            [Y, NEWMAP] = imresize(I, 0.78);
            f = figure('Visible', 'off');
            a = axes('Visible','off');
            imshow(Y,NEWMAP);
            M(i)=getframe;
            close all
            writeVideo(vidObj,M(i));
        end
        i=i+1;
    catch
        name=['http://www.ssec.wisc.edu/data/geo/images/himawari08/animation_images/himawari08_',tt{i}{1},'_rgb_fd.gif'];
        [str,stats]= urlread(name);
        if stats==1
            curlcommand=['c:\curl\bin\curl -o.\temp.jpg ',name1]; % modify your curl command path accordingly
            system(curlcommand);
            [I,map]=imread('c:\CloudGif\temp.jpg');
            [Y, NEWMAP] = imresize(I, 0.78);
            f = figure('Visible', 'off');
            a = axes('Visible','off');
            imshow(Y,NEWMAP);
            M(i)=getframe;
            close all
            writeVideo(vidObj,M(i));
        end
        i=i+1;
    end
end

close(vidObj);
