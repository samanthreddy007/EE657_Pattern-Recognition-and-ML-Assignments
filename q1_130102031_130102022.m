clc 
clear all

cd D:\6thsem\EE657\Assignment_list\TrainCharacters\1
sum1=zeros(1024,1);
for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p1=imresize(s,0.25);
    p1=p1(:);
    p1=im2double(p1);
    sum1=sum1+p1;
end
mu1=sum1/200;
var1=zeros(1024,1024);
for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p1=imresize(s,0.25);
    p1=p1(:);
    p1=im2double(p1);
    var1=var1+(p1-mu1)*(p1-mu1)';
end
var1=var1/200+(0.5*eye(1024));
cd D:\6thsem\EE657\Assignment_list\TrainCharacters\2
sum2=zeros(1024,1);
for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    p2=im2double(p2);
    sum2=sum2+p2;
end
mu2=sum2/200;
var2=zeros(1024,1024);

for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    p2=im2double(p2);
    var2=var2+(p2-mu2)*(p2-mu2)';
end
var2=var2/200+(0.5*eye(1024));
cd D:\6thsem\EE657\Assignment_list\TrainCharacters\3
sum3=zeros(1024,1);
for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p3=imresize(s,0.25);
    p3=p3(:);
    p3=im2double(p3);
    sum3=sum3+p3;
end
mu3=sum3/200;
var3=zeros(1024,1024);
for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p3=imresize(s,0.25);
    p3=p3(:);
    p3=im2double(p3);
    var3=var3/200+(p3-mu3)*(p3-mu3)';
end
var3=var3+(0.5*eye(1024));



sum=sum1+sum2+sum3;
totalmean=sum/600;
cd D:\6thsem\EE657\Assignment_list\TrainCharacters\1

for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p1=imresize(s,0.25);
    p1=p1(:);
    a(:,i)=im2double(p1); 
end

cd D:\6thsem\EE657\Assignment_list\TrainCharacters\2

for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    a(:,200+i)=im2double(p2);
    
end
cd D:\6thsem\EE657\Assignment_list\TrainCharacters\3

for i=1:1:200
    s=imread(sprintf('%d.jpg',i));
    p3=imresize(s,0.25);
    p3=p3(:);
    a(:,400+i)=im2double(p3);
end
totalvar=zeros(1024,1024);
for i=1:600
    totalvar=totalvar+(a(:,i)-totalmean)*(a(:,i)-totalmean)';
end
totalvar=totalvar/600+ (0.5*eye(1024));
totalvardiag=diag(diag(totalvar));
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
misclass=ones(5,100);
a=zeros(1024,100);
for i=201:1:300
   s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    i=i-200;
    a(:,i)=im2double(p2);
    
    
g1=-0.5*(a(:,i)-mu1)'*inv(var1)*(a(:,i)-mu1)-0.5*log(det(var1));
g2=-0.5*(a(:,i)-mu2)'*inv(var2)*(a(:,i)-mu2)-0.5*log(det(var2));
g3=-0.5*(a(:,i)-mu3)'*inv(var3)*(a(:,i)-mu3)-0.5*log(det(var3));

g=[g1 g2 g3];
g_max=max(g);
if(g_max==g2)
    misclass(1,i)=2;
end
if(g_max==g3)
    misclass(1,i)=3;
end 

g_11=-0.5*(a(:,i)-mu1)'*inv(diag(diag(totalvar)))*(a(:,i)-mu1);
g_12=-0.5*(a(:,i)-mu2)'*inv(diag(diag(totalvar)))*(a(:,i)-mu2);
g_13=-0.5*(a(:,i)-mu3)'*inv(diag(diag(totalvar)))*(a(:,i)-mu3);
    g_1=[g_11 g_12 g_13];
g_1max=max(g_1);
if(g_1max==g_12)
    misclass(2,i)=2;
end
if(g_1max==g_13)
    misclass(2,i)=3;
end 


g_21=-0.5*(a(:,i)-mu1)'*inv(totalvar)*(a(:,i)-mu1);
g_22=-0.5*(a(:,i)-mu2)'*inv(totalvar)*(a(:,i)-mu2);
g_23=-0.5*(a(:,i)-mu3)'*inv(totalvar)*(a(:,i)-mu3);
    g_2=[g_21 g_22 g_23];
g_2max=max(g_2);
if(g_2max==g_22)
    misclass(3,i)=2;
end
if(g_2max==g_23)
    misclass(3,i)=3;
end 


    
g_31=-0.5*(a(:,i)-mu1)'*(a(:,i)-mu1);
g_32=-0.5*(a(:,i)-mu2)'*(a(:,i)-mu2);
g_33=-0.5*(a(:,i)-mu3)'*(a(:,i)-mu3);
g_3=[g_31 g_32 g_33];
g_3max=max(g_1);
if(g_3max==g_32)
    misclass(4,i)=2;
end
if(g_3max==g_33)
    misclass(4,i)=3;
end    

g_41=-0.5*(a(:,i)-mu1)'*inv(diag(diag(var1)))*(a(:,i)-mu1)-0.5*log(det(diag(diag(var1))));
g_42=-0.5*(a(:,i)-mu2)'*inv(diag(diag(var2)))*(a(:,i)-mu2)-0.5*log(det(diag(diag(var2))));
g_43=-0.5*(a(:,i)-mu3)'*inv(diag(diag(var3)))*(a(:,i)-mu3)-0.5*log(det(diag(diag(var3))));

g_4=[g_41 g_42 g_43];
g_4max=max(g_4);
if(g_4max==g_42)
    misclass(5,i)=2;
end
if(g_4max==g_43)
    misclass(5,i)=3;
end

mis_11=[];mis_12=[];mis_13=[];mis_14=[];mis_15=[];
misfrom_11=[];misfrom_12=[];misfrom_13=[];misfrom_14=[];misfrom_15=[];
for j=1:100
    
    if(misclass(1,j)~=1)
        misfrom_11=[misfrom_11 j];
        mis_11=[mis_11 misclass(1,j)];
    end 
    if(misclass(2,j)~=1)
        misfrom_12=[misfrom_12 j];
        mis_12=[mis_12 misclass(2,j)];
    end 
    if(misclass(3,j)~=1)
        misfrom_13=[misfrom_13 j];
        mis_13=[mis_13 misclass(3,j)];
    end 
    if(misclass(4,j)~=1)
        misfrom_14=[misfrom_14 j];
        mis_14=[mis_14 misclass(4,j)];
    end 
    if(misclass(5,j)~=1)
        misfrom_15=[misfrom_15 j];
        mis_15=[mis_15 misclass(5,j)];
    end 
end
end
fprintf('characters misclassified by using seperate covariance matrix are:\n');
display(misfrom_11);
fprintf('\n');
display(mis_11);
fprintf('characters misclassified by using pooling and common covar matrix are:\n');
display(misfrom_12);
fprintf('\n');
display(mis_12);
fprintf('characters misclassified by using pooling and independent features are:\n');
display(misfrom_13);
fprintf('\n');
display(mis_13);
fprintf('characters misclassified by using identity covariance matrix are:\n');
display(misfrom_14);
fprintf('\n');
display(mis_14);
fprintf('characters misclassified by using seperate covariance and independent features are:\n');
display(misfrom_15);
fprintf('\n');
display(mis_15);

% 2nd testing
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\2
misclass=ones(5,100);
a=ones(1024,100);
misclass=2*misclass;
for i=201:1:300
   s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    i=i-200;
    a(:,i)=im2double(p2);
    
    
g1=-0.5*(a(:,i)-mu1)'*inv(var1)*(a(:,i)-mu1)-0.5*log(det(var1));
g2=-0.5*(a(:,i)-mu2)'*inv(var2)*(a(:,i)-mu2)-0.5*log(det(var2));
g3=-0.5*(a(:,i)-mu3)'*inv(var3)*(a(:,i)-mu3)-0.5*log(det(var3));

g=[g1 g2 g3];
g_max=max(g);
if(g_max==g1)
    misclass(1,i)=1;
end
if(g_max==g3)
    misclass(1,i)=3;
end 

g_11=-0.5*(a(:,i)-mu1)'*inv(diag(diag(totalvar)))*(a(:,i)-mu1);
g_12=-0.5*(a(:,i)-mu2)'*inv(diag(diag(totalvar)))*(a(:,i)-mu2);
g_13=-0.5*(a(:,i)-mu3)'*inv(diag(diag(totalvar)))*(a(:,i)-mu3);
    g_1=[g_11 g_12 g_13];
g_1max=max(g_1);
if(g_1max==g_11)
    misclass(2,i)=1;
end
if(g_1max==g_13)
    misclass(2,i)=3;
end 


g_21=-0.5*(a(:,i)-mu1)'*inv(totalvar)*(a(:,i)-mu1);
g_22=-0.5*(a(:,i)-mu2)'*inv(totalvar)*(a(:,i)-mu2);
g_23=-0.5*(a(:,i)-mu3)'*inv(totalvar)*(a(:,i)-mu3);
    g_2=[g_21 g_22 g_23];
g_2max=max(g_2);
if(g_2max==g_21)
    misclass(3,i)=1;
end
if(g_2max==g_23)
    misclass(3,i)=3;
end 


    
g_31=-0.5*(a(:,i)-mu1)'*(a(:,i)-mu1);
g_32=-0.5*(a(:,i)-mu2)'*(a(:,i)-mu2);
g_33=-0.5*(a(:,i)-mu3)'*(a(:,i)-mu3);
g_3=[g_31 g_32 g_33];
g_3max=max(g_1);
if(g_3max==g_31)
    misclass(4,i)=1;
end
if(g_3max==g_33)
    misclass(4,i)=3;
end    

g_41=-0.5*(a(:,i)-mu1)'*inv(diag(diag(var1)))*(a(:,i)-mu1)-0.5*log(det(diag(diag(var1))));
g_42=-0.5*(a(:,i)-mu2)'*inv(diag(diag(var2)))*(a(:,i)-mu2)-0.5*log(det(diag(diag(var2))));
g_43=-0.5*(a(:,i)-mu3)'*inv(diag(diag(var3)))*(a(:,i)-mu3)-0.5*log(det(diag(diag(var3))));

g_4=[g_41 g_42 g_43];
g_4max=max(g_4);
if(g_4max==g_41)
    misclass(5,i)=1;
end
if(g_4max==g_43)
    misclass(5,i)=3;
end

mis_21=[];mis_22=[];mis_23=[];mis_24=[];mis_25=[];
misfrom_21=[];misfrom_22=[];misfrom_23=[];misfrom_24=[];misfrom_25=[];
for j=1:100
    
    if(misclass(1,j)~=2)
        misfrom_21=[misfrom_21 j];
        mis_21=[mis_21 misclass(1,j)];
    end 
    if(misclass(2,j)~=2)
        misfrom_22=[misfrom_22 j];
        mis_22=[mis_22 misclass(2,j)];
    end 
    if(misclass(3,j)~=2)
        misfrom_23=[misfrom_23 j];
        mis_23=[mis_23 misclass(3,j)];
    end 
    if(misclass(4,j)~=2)
        misfrom_24=[misfrom_24 j];
        mis_24=[mis_24 misclass(4,j)];
    end 
    if(misclass(5,j)~=2)
        misfrom_25=[misfrom_25 j];
        mis_25=[mis_25 misclass(5,j)];
    end 
end
end
fprintf('characters misclassified by using seperate covariance matrix are:\n');
display(misfrom_21);
fprintf('\n');
display(mis_21);
fprintf('characters misclassified by using pooling and common covar matrix are:\n');
display(misfrom_22);
fprintf('\n');
display(mis_22);
fprintf('characters misclassified by using pooling and independent features are:\n');
display(misfrom_23);
fprintf('\n');
display(mis_23);
fprintf('characters misclassified by using identity covariance matrix are:\n');
display(misfrom_24);
fprintf('\n');
display(mis_24);
fprintf('characters misclassified by using seperate covariance and independent features are:\n');
display(misfrom_25);
fprintf('\n');
display(mis_25);
%3rd testing
    
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\3
misclass=ones(5,100);
misclass=3*misclass;
a=zeros(1024,100);
for i=201:1:300
   s=imread(sprintf('%d.jpg',i));
    p2=imresize(s,0.25);
    p2=p2(:);
    i=i-200;
    a(:,i)=im2double(p2);
    
    
g1=-0.5*(a(:,i)-mu1)'*inv(var1)*(a(:,i)-mu1)-0.5*log(det(var1));
g2=-0.5*(a(:,i)-mu2)'*inv(var2)*(a(:,i)-mu2)-0.5*log(det(var2));
g3=-0.5*(a(:,i)-mu3)'*inv(var3)*(a(:,i)-mu3)-0.5*log(det(var3));

g=[g1 g2 g3];
g_max=max(g);
if(g_max==g2)
    misclass(1,i)=2;
end
if(g_max==g1)
    misclass(1,i)=1;
end 

g_11=-0.5*(a(:,i)-mu1)'*inv(diag(diag(totalvar)))*(a(:,i)-mu1);
g_12=-0.5*(a(:,i)-mu2)'*inv(diag(diag(totalvar)))*(a(:,i)-mu2);
g_13=-0.5*(a(:,i)-mu3)'*inv(diag(diag(totalvar)))*(a(:,i)-mu3);
    g_1=[g_11 g_12 g_13];
g_1max=max(g_1);
if(g_1max==g_12)
    misclass(2,i)=2;
end
if(g_1max==g_11)
    misclass(2,i)=1;
end 


g_21=-0.5*(a(:,i)-mu1)'*inv(totalvar)*(a(:,i)-mu1);
g_22=-0.5*(a(:,i)-mu2)'*inv(totalvar)*(a(:,i)-mu2);
g_23=-0.5*(a(:,i)-mu3)'*inv(totalvar)*(a(:,i)-mu3);
    g_2=[g_21 g_22 g_23];
g_2max=max(g_2);
if(g_2max==g_22)
    misclass(3,i)=2;
end
if(g_2max==g_21)
    misclass(3,i)=1;
end 


    
g_31=-0.5*(a(:,i)-mu1)'*(a(:,i)-mu1);
g_32=-0.5*(a(:,i)-mu2)'*(a(:,i)-mu2);
g_33=-0.5*(a(:,i)-mu3)'*(a(:,i)-mu3);
g_3=[g_31 g_32 g_33];
g_3max=max(g_1);
if(g_3max==g_32)
    misclass(4,i)=2;
end
if(g_3max==g_31)
    misclass(4,i)=1;
end    

g_41=-0.5*(a(:,i)-mu1)'*inv(diag(diag(var1)))*(a(:,i)-mu1)-0.5*log(det(diag(diag(var1))));
g_42=-0.5*(a(:,i)-mu2)'*inv(diag(diag(var2)))*(a(:,i)-mu2)-0.5*log(det(diag(diag(var2))));
g_43=-0.5*(a(:,i)-mu3)'*inv(diag(diag(var3)))*(a(:,i)-mu3)-0.5*log(det(diag(diag(var3))));

g_4=[g_41 g_42 g_43];
g_4max=max(g_4);
if(g_4max==g_42)
    misclass(5,i)=2;
end
if(g_4max==g_41)
    misclass(5,i)=1;
end

mis_31=[];mis_32=[];mis_33=[];mis_34=[];mis_35=[];
misfrom_31=[];misfrom_32=[];misfrom_33=[];misfrom_34=[];misfrom_35=[];
for j=1:100
    
    if(misclass(1,j)~=3)
        misfrom_31=[misfrom_31 j];
        mis_31=[mis_31 misclass(1,j)];
    end 
    if(misclass(2,j)~=3)
        misfrom_32=[misfrom_32 j];
        mis_32=[mis_32 misclass(2,j)];
    end 
    if(misclass(3,j)~=3)
        misfrom_33=[misfrom_33 j];
        mis_33=[mis_33 misclass(3,j)];
    end 
    if(misclass(4,j)~=3)
        misfrom_34=[misfrom_34 j];
        mis_34=[mis_34 misclass(4,j)];
    end 
    if(misclass(5,j)~=3)
        misfrom_35=[misfrom_35 j];
        mis_35=[mis_35 misclass(5,j)];
    end 
end
end
fprintf('characters misclassified by using seperate covariance matrix are:\n');
display(misfrom_31);
fprintf('\n');
display(mis_31);
fprintf('characters misclassified by using pooling and common covar matrix are:\n');
display(misfrom_32);
fprintf('\n');
display(mis_32);
fprintf('characters misclassified by using pooling and independent features are:\n');
display(misfrom_33);
fprintf('\n');
display(mis_33);
fprintf('characters misclassified by using identity covariance matrix are:\n');
display(misfrom_34);
fprintf('\n');
display(mis_34);
fprintf('characters misclassified by using seperate covariance and independent features are:\n');
display(misfrom_35);
fprintf('\n');
display(mis_35);


acc=zeros(5,3);
acc(1,1)=100-size((misfrom_11),2);acc(1,2)=100-size((misfrom_21),2);acc(1,3)=100-size((misfrom_31),2);
acc(2,1)=100-size((misfrom_12),2);acc(2,2)=100-size((misfrom_22),2);acc(2,3)=100-size((misfrom_32),2);
acc(3,1)=100-size((misfrom_13),2);acc(3,2)=100-size((misfrom_23),2);acc(3,3)=100-size((misfrom_33),2);
acc(4,1)=100-size((misfrom_14),2);acc(4,2)=100-size((misfrom_24),2);acc(4,3)=100-size((misfrom_34),2);
acc(5,1)=100-size((misfrom_15),2);acc(5,2)=100-size((misfrom_25),2);acc(5,3)=100-size((misfrom_35),2);
fprintf('Accuracy of individual character of each class are: ');
display(acc);
acc_model=zeros(5,1);
fprintf('Accuracy for each model is : ');
acc_model(1,1)=(1/3)*(300-numel(misfrom_11)-numel(misfrom_21)-numel(misfrom_31));
acc_model(2,1)=(1/3)*(300-numel(misfrom_12)-numel(misfrom_22)-numel(misfrom_32));
acc_model(3,1)=(1/3)*(300-numel(misfrom_13)-numel(misfrom_23)-numel(misfrom_33));
acc_model(4,1)=(1/3)*(300-numel(misfrom_14)-numel(misfrom_24)-numel(misfrom_34));
acc_model(5,1)=(1/3)*(300-numel(misfrom_15)-numel(misfrom_25)-numel(misfrom_35));
display(acc_model);


cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
for i=1:4
    subplot(1,4,i);
    imshow(sprintf('%d.jpg',misfrom_11(i)+200));
    mis_11(i)    
end


cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
figure();
for i=1:4
    subplot(1,4,i);
    imshow(sprintf('%d.jpg',misfrom_12(i)+200));
    mis_12(i)
    
end
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
figure();
for i=1:4
    subplot(1,4,i);
    imshow(sprintf('%d.jpg',misfrom_13(i)+200));
    mis_13(i)
    
end
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
for i=1:4
    
    %subplot(1,4,i);
    %imshow(sprintf('%d.jpg',misfrom_14(i)+200));
    %mis_14(i)
end
cd D:\6thsem\EE657\Assignment_list\TestCharacters\TestCharacters\1
figure();
for i=1:4
    
    subplot(1,4,i);
    imshow(sprintf('%d.jpg',misfrom_15(i)+200));
    mis_15(i)
end