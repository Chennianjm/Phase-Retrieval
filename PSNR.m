function psnr=PSNR(img1,img2)
clc;
[h1, w1]=size(img1);
[h2, w2]=size(img2);
   if h1==h2&&w1==w2
      img1=double(img1);
      img2=double(img2);

      B=1;                %编码一个像素用多少二进制位
      MAX=2^B-1;          %图像有多少灰度级
      MES=sum(sum((img1-img2).^2))/(h1*w1);     %均方差
      psnr=20*log10(MAX/sqrt(MES));           %峰值信噪比
   else
       disp('图像输入Size不一致，请使用size()函数查验！');
   end
end