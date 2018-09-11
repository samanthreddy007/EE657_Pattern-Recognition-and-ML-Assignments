clc;
clear all;
load('D:\6thsem\EE657\Assignment_list\Pattern1.mat')
load('D:\6thsem\EE657\Assignment_list\Pattern2.mat')
load('D:\6thsem\EE657\Assignment_list\Pattern3.mat')
t1=train_pattern_1{1,1};
t2=train_pattern_2{1,1};
t3=train_pattern_3{1,1};
for i=2:200;
    t1=[t1;train_pattern_1{1,i}];
end
for i=2:200;
    t2=[t2;train_pattern_2{1,i}];
end
for i=2:200;
    t3=[t3;train_pattern_3{1,i}];
end
X=[t1;t2;t3];
label=[ones(200,1);2.*ones(200,1);3.*ones(200,1) ];

load('D:\6thsem\EE657\Assignment_list\Test1.mat')
load('D:\6thsem\EE657\Assignment_list\Test2.mat')
load('D:\6thsem\EE657\Assignment_list\Test3.mat')
t11=test_pattern_1{1,1};
t12=test_pattern_2{1,1};
t13=test_pattern_3{1,1};
for i=2:100;
    t11=[t11;test_pattern_1{1,i}];
end
for i=2:100;
    t12=[t12;test_pattern_2{1,i}];
end
for i=2:100;
    t13=[t13;test_pattern_3{1,i}];
end
Y1=[t11;t22;t33];
label1=[ones(100,1);2.*ones(100,1);3.*ones(100,1) ];

bestcv = 0;
for log2c = -1:3,
 for log2g = -4:1
  cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
  cv = svmtrain(label,X,cmd);
  [predicted_label]=svmpredict(label1,Y1,cv);
  if (cv >= bestcv),
   bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
 end
  fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
end
end

c=[0.5,1,2,3,4,5,6,7,7.5,8]
    g=[0.0625,0.125,0.25,0.5,0.5,0.5,0.5,0.25,0.5,0.54,0.55]
    acc=[87.6667,89.1667,90.3333,91.8333,92.3,92.40,92.9,93.0,94.667,95.10]
    figure();
    plot(c,acc);