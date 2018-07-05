%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Making Movie/Animation From Online Satellite Images of Taiwan Central Weather Bureau

% Description:
%    If online images can not be fetched by using "imread", try use curl command to
%    download them.


% 从台湾交通部中央气象局提供的向日葵8号卫星红外线卫星云图生成48小时云图动画
% 如果不能通过```Imread```读取网上图片，则用curl命令下载至本地

% Note:
%     Windows code.
%     Curl command line tool is required. (https://curl.haxx.se/)
%     Noncommercial use only.

% Author: github.com/chouj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time1=datestr(floor(now)-1,'yyyymmdd');% the day before yesterday
time2=datestr(floor(now)-2,'yyyymmdd');% yesterday

% for image url
m=['00-00';'00-10';'00-20';'00-30';'00-40';'00-50';'01-00';'01-20';'01-30';'01-40';'01-50';'02-00';...
    '02-10';'02-20';'02-30';'02-40';'02-50';'03-00';'03-10';'03-20';'03-30';'03-40';'03-50';'04-00';...
    '04-10';'04-20';'04-30';'04-40';'04-50';'05-00';'05-10';'05-20';'05-30';'05-40';'05-50';'06-00';...
    '06-10';'06-20';'06-30';'06-40';'06-50';'07-00';'07-10';'07-20';'07-30';'07-40';'07-50';'08-00';...
    '08-10';'08-20';'08-30';'08-40';'08-50';'09-00';'09-10';'09-20';'09-30';'09-40';'09-50';'10-00';...
    '10-10';'10-20';'10-30';'10-40';'10-50';'11-00';'11-10';'11-20';'11-30';'11-40';'11-50';'12-00';...
    '12-10';'12-20';'12-30';'12-40';'12-50';'13-00';'13-10';'13-20';'13-30';'13-40';'13-50';'14-00';...
    '14-10';'14-20';'14-30';'14-40';'14-50';'15-00';'15-10';'15-20';'15-30';'15-40';'15-50';'16-00';...
    '16-10';'16-20';'16-30';'16-40';'16-50';'17-00';'17-10';'17-20';'17-30';'17-40';'17-50';'18-00';...
    '18-10';'18-20';'18-30';'18-40';'18-50';'19-00';'19-10';'19-20';'19-30';'19-40';'19-50';'20-00';...
    '20-10';'20-20';'20-30';'20-40';'20-50';'21-00';'21-10';'21-20';'21-30';'21-30';'21-40';'21-50';...
    '22-00';'22-10';'22-20';'22-30';'22-40';'22-50';'23-00';'23-10';'23-20';'23-30';'23-40';'23-50'];

% Prepare the new file.
vidObj = VideoWriter('.\cloudgif.mp4','MPEG-4');
vidObj.FrameRate=10;
vidObj.Quality=75;
open(vidObj);

i=1;
while(i<=144) % yesterday
    try
        name=['https://www.cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-',time2(1:4),'-',time2(5:6),'-',time2(7:8),'-',m(i,:),'.jpg'];
        curlcommand=['c:\curl\bin\curl -o .\temp.jpg ',name]; % modify the path of curl command accordingly.
        system(curlcommand);
        [I,map]=imread('.\temp.jpg');
        f = figure('Visible', 'off'); % figure unshown
        a = axes('Visible','off');
        imshow(I,map);
        M(i)=getframe;
        close all
        writeVideo(vidObj,M(i));
        i=i+1;
    catch
        i=i+1;
    end
end

while(i<=288) % the day before yesterday
    try
        name=['https://www.cwb.gov.tw/V7/observe/satellite/Data/s1p/s1p-',time1(1:4),'-',time1(5:6),'-',time1(7:8),'-',m(i-144,:),'.jpg'];
        curlcommand=['c:\curl\bin\curl -o .\temp.jpg ',name]; % modify the path of curl command accordingly.
        system(curlcommand);
        [I,map]=imread('.\temp.jpg');
        f = figure('Visible', 'off');
        a = axes('Visible','off');
        imshow(I,map);
        M(i)=getframe;
        close all
        writeVideo(vidObj,M(i));
        i=i+1;
    catch
        i=i+1;
    end
end

close(vidObj);
