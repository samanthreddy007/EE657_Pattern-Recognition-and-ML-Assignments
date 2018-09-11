clear all;
clc;
cd:'D:\6thsem\EE657\Assignment_list';
s=imread('ski_image.jpg');
imshow(s);
impixelinfo
r=s(:,:,1);
g=s(:,:,2);
b=s(:,:,3);

r=double(r);
r=r(:);
r=r/255;

g=double(g);
g=g(:);
g=g/255;

b=double(b);
b=b(:);
b=b/255;

mu1=[0.4 0.4 0.4]';
mu2=[0.05 0.05 0.05]';
mu3=[0.6 0.6 0.6]';
covar1=eye(3);
covar2=eye(3);
covar3=eye(3);
pi1=1/3;
pi2=1/3;
pi3=1/3;
it=0;
loglike=[];


while(1)
    mu=[mu1 mu2 mu3];
    covarold1=covar1 
    covarold2=covar2
    covarold3=covar3
    it=it+1
    t=0;
    res=zeros(3,size(r,1));
    x=zeros(3,size(r,1));
    den=zeros(3,size(r,1));
for i=1:size(r,1)
    x(:,i)=[r(i) g(i) b(i)]';
    den(:,i)=[pi1*mvnpdf(x(:,i),mu1,covar1), pi2*mvnpdf(x(:,i),mu2,covar2), pi3*mvnpdf(x(:,i),mu3,covar3)]';
end
densum=sum(den);
loglik=0;
for i=1:size(r,1)
   res(:,i)=den(:,i)/densum(i); 
   loglik=loglik+log(densum(i));
end
loglike=[loglike,loglik];
N=sum(res,2);
covar1=zeros(3,3);
 covar2=zeros(3,3);
 covar3=zeros(3,3);
 for i=1:size(r,1)
   
   covar1=res(1,i)*(x(:,i)-mu1)*(x(:,i)-mu1)'+covar1;
   covar2=res(2,i)*(x(:,i)-mu2)*(x(:,i)-mu2)'+covar2;
   covar3=res(3,i)*(x(:,i)-mu3)*(x(:,i)-mu3)'+covar3;
 end  
 covar1=covar1/N(1)
 covar2=covar2/N(2)
 covar3=covar3/N(3)
pi1=N(1)/size(r,1);
 pi2=N(2)/size(r,1);
 pi3=N(3)/size(r,1);

mu1=zeros(3,1);
mu2=zeros(3,1);
mu3=zeros(3,1);
    for i=1:size(r,1)
        mu1=mu1+(res(1,i)*x(:,i));
        mu2=mu2+(res(2,i)*x(:,i));
        mu3=mu3+(res(3,i)*x(:,i));
    end
    
 

 mu1=mu1/N(1);
 mu2=mu2/N(2);
 mu3=mu3/N(3);
 
 mun=[mu1 mu2 mu3];
%r(1)
meanerror=max(max(abs(mun-mu)));
covar1error=max(max(abs(covar1-covarold1)));
covar2error=max(max(abs(covar2-covarold2)));
covar3error=max(max(abs(covar3-covarold3)));

    if(meanerror<0.01 && covar1error<0.01 && covar2error<0.01 && covar3error<0.01)
    display(it);
    y=zeros(1,size(r,1));
    for i=1:size(r,1)
       if(res(1,i)>res(2,i))
           ma=1;
       else
           ma=2;
       end
       if(res(ma,i)>res(3,i))
           ma=ma;
       else
           ma=3;
       end
     y(i)=ma;
    end
    
    
    %imshow('sky_image.jpg');
    break;
      
    end
end
m=zeros(3,size(r,1));
for i=1:size(r,1)
    if(y(i)==1) 
        m(:,i)=[0 0 255]';
        
    elseif(y(i)==2)
        m(:,i)=[255 0 0]';
        
    elseif(y(i)==3)
        m(:,i)=[0 255 0]';
    end
end
m=m*255;
m=reshape(m',[321,481,3]);
%k=zeros(size(m),'unit8');
%k=m;
%imshow(k);
m=uint8(m);
figure();
imshow(m);
figure();
a=1:1:it;
plot(a,loglike)
%imshow(mat2gray(m));