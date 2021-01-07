function psnr=PSNR(img1,img2)
clc;
[h1, w1]=size(img1);
[h2, w2]=size(img2);
   if h1==h2&&w1==w2
      img1=double(img1);
      img2=double(img2);

      B=1;                %����һ�������ö��ٶ�����λ
      MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
      MES=sum(sum((img1-img2).^2))/(h1*w1);     %������
      psnr=20*log10(MAX/sqrt(MES));           %��ֵ�����
   else
       disp('ͼ������Size��һ�£���ʹ��size()�������飡');
   end
end