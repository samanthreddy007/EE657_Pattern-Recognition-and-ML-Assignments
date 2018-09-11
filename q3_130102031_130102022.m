
sum_x=zeros(10304,1);
for i=1:1:40
    for j=1:1:5
         t=strcat('D:\6thsem\EE657\Assignment_list\gallery\s',int2str(i),'\',int2str(j),'.pgm');
         x=imread(t);
         x=double(x(:));
         sum_x=sum_x + x;
    end
end
mean=sum_x/200;
a=zeros(10304,200);

k=1;
for i=1:1:40
    for j=1:1:5
        t=strcat('D:\6thsem\EE657\Assignment_list\gallery\s',int2str(i),'\',int2str(j),'.pgm');
         x=imread(t);
         x=double(x(:));
         a(:,k)=x-mean;
         k=k+1;
    end
end

var_x=a'*a/200;

[V D]=eigs(var_x,200);
for i=1:5
z=a*V(:,i);
   z=z/norm(z);
   I=reshape(z,[112,92]);
  
   subplot(2,3,i);

   imshow(mat2gray(I));
end
%x=1:10304;
%[a b]=eigs(a*a'/200,10304);
%y=a/sum(a);
%plot(x,y)

totallambda=trace(D);
lambda=[];
sum=0;
    for i=1:200
        sum=sum+D(i,i);
        lambda=[lambda sum/totallambda]
    end
    lambda=double(lambda*100);
    
    i=1:200;
    figure();
    plot(i,lambda);
    value=i(find(lambda>=95));
    minvalue=min(value)
    
      cd:'D:\6thsem\EE657\Assignment_list';
  
    image=imread('face_input_1.pgm');
    x=double(image(:));
    final=zeros(10304,1);
    sum_11=zeros(10304,1);
    wnew=zeros(10304,1);
    meansqerr=[];
    for i=1:1:200
        
        wnew=a*V(:,i);
        wnew=wnew/norm(wnew);
        f=((x'*wnew)*wnew);
        
        if(i==1)
            I_1= reshape(f+mean,[112,92]);
            figure();
            k_1=mat2gray(I_1);
            
            imshow(k_1);
        end
        
        final=final+f;
        
         I_11=reshape(final,[112,92]);
        k_11=mat2gray(I_11);
        u_11=double(k_11(:));
        sum_11=sum_11+u_11;
        
        if(i==15)
            I_2=reshape(final+mean,[112,92]);
            figure();
            k_2=mat2gray(I_2);
            imshow(k_2);
        end
        if(i==200)
            
            I_6=reshape(final+mean,[112,92]);
            
            figure();
            k_6=mat2gray(I_6);
            imshow(k_6);
        end
    end
    
    mean=sum_11/200;
    
    final=zeros(10304,1);
    wnew=zeros(10304,1);
    
    for i=1:1:200
        
        wnew=a*V(:,i);
        wnew=wnew/norm(wnew);
        f=(x'*wnew)*wnew;
        final=final+f;
        
         I_11=reshape(final,[112,92]);
        k_11=mat2gray(I_11);
        u_11=double(k_11(:));
        
      meansqerr=[meansqerr (u_11-mean)'*(u_11-mean)/10304];   
        
    end
    
   
    figure();
    d1=1:1:200 
    plot(d1,meansqerr);
    
    fprintf('meanssqaure error for 1 eigen face');
    meansqerr(1)
    fprintf(' ');
    fprintf('meanssqaure error for 15 eigen face');
    meansqerr(15)
     fprintf(' ');
    fprintf('meanssqaure error for 200 eigen face');
    meansqerr(200)
     fprintf(' ');
    
    
    cd:'D:\6thsem\EE657\Assignment_list';
    image=imread('face_input_2.pgm');
    x=double(image(:));
    final=zeros(10304,1);
    sum_11=zeros(10304,1);
    wnew=zeros(10304,1);
    meansqerr=[];
    for i=1:1:200
        
        wnew=a*V(:,i);
        wnew=wnew/norm(wnew);
        f=((x'*wnew)*wnew);
        
        if(i==1)
            I_1= reshape(f+mean,[112,92]);
            figure();
            k_1=mat2gray(I_1);
            
            imshow(k_1);
        end
        
        final=final+f;
        
         I_11=reshape(final,[112,92]);
        k_11=mat2gray(I_11);
        u_11=double(k_11(:));
        sum_11=sum_11+u_11;
        
        if(i==15)
            I_2=reshape(final+mean,[112,92]);
            figure();
            k_2=mat2gray(I_2);
            imshow(k_2);
        end
        if(i==200)
            
            I_6=reshape(final+mean,[112,92]);
            
            figure();
            k_6=mat2gray(I_6);
            imshow(k_6);
        end
    end
           
    
    mean=sum_11/200;
    
    final=zeros(10304,1);
    wnew=zeros(10304,1);
    
    for i=1:1:200
        
        wnew=a*V(:,i);
        wnew=wnew/norm(wnew);
        f=(x'*wnew)*wnew;
        final=final+f;
        
         I_11=reshape(final,[112,92]);
        k_11=mat2gray(I_11);
        u_11=double(k_11(:));
        
      meansqerr=[meansqerr (u_11-mean)'*(u_11-mean)/10304];   
        
    end
    fprintf('meanssqaure error for 1 eigen face');
    meansqerr(1)
     fprintf(' ');
    fprintf('meanssqaure error for 15 eigen face');
    meansqerr(15)
     fprintf(' ');
    fprintf('meanssqaure error for 200 eigen face');
    meansqerr(200)
     fprintf(' ');
   
    figure();
    d1=1:1:200 
    plot(d1,meansqerr);
    
            %I_3=reshape(final,[112,92]);
            %figure();
            % k_3=mat2gray(I_3);
            %imshow(k_3);
            
         
      
    
        