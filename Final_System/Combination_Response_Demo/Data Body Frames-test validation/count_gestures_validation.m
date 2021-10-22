function count=count_gestures_validation(datos)
%count=count_gestures_validation('PH_BF_410-710.mat');
load(datos)

j=0;
k=0;
datos=datos(1:length(datos)-11);
for i=410:710
    
    if(i==419 ||i==511||i==512||i==513||i==514 || i==515 ||i==540||i==551|| i==649 || i==650 || i==652 || i==690 || i==691 || i==701)
       j=j+1;
    else
v=genvarname([datos,num2str(i)]);
t=eval(v);
t=size(t.groundtruth,1);
m(i)=t(1,1);
k=k+1;
    end
end

count=sum(m);
k
j