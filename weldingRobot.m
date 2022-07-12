clear all; close all
%%
%Robot
DH= [0.000 0.000    0.00    pi/2  0;
     0.000 0.000    0.4318 0.000 0;
     0.000 0.15005  0.0203 -pi/2  0;
     0.000 0.4318   0.000  pi/2  0;
     0.000 0.000    0.000 -pi/2 0;
     0.000 0.0000   0.000 0.000 0];
 robot= SerialLink(DH,'name','WeldingRobot');
 robot.plot([0 0 0 0 0 0 ])
 
%% 
%1st line
t=[0:0.1:2];
T1=transl(0.5,-0.5,0.1);
T2=transl(0.5,-0.5,0.5);
T=ctraj(T1,T2,length(t));
q=robot.ikine6s(T,'r')
p1=transl(T1)
p2=transl(T2)
x=[p1(1),p2(1)]
y=[p1(2),p2(2)]
z=[p1(3),p2(3)]
robot.plot(q)
hold on
plot3(x,y,z,'o')
plot3(x,y,z,'b')
%% 2nd line
T3=transl(0.5,-0.5,0.5);
T4=transl(0.5,0.5,0.5);
T=ctraj(T3,T4,length(t));
q1=robot.ikine6s(T)
p3=transl(T3)
p4=transl(T4)
x=[p3(1),p4(1)]
y=[p3(2),p4(2)]
z=[p3(3),p4(3)]
robot.plot(q1)
hold on
plot3(x,y,z,'o')
plot3(x,y,z,'b')

%% 3rd line
T5=transl(0.5,0.5,0.5);
T6=transl(0.5,0.5,0.1);
T=ctraj(T5,T6,length(t));
q2=robot.ikine6s(T)
p5=transl(T5)
p6=transl(T6)
x=[p5(1),p6(1)]
y=[p5(2),p6(2)]
z=[p5(3),p6(3)]
robot.plot(q2)
hold on
plot3(x,y,z,'o')
plot3(x,y,z,'b')

%% 4th line
T7=transl(0.5,0.5,0.1);
T8=transl(0.5,-0.5,0.1);
T=ctraj(T7,T8,length(t));
q3=robot.ikine6s(T)
p7=transl(T7)
p8=transl(T8)
x=[p7(1),p8(1)]
y=[p7(2),p8(2)]
z=[p7(3),p8(3)]
robot.plot(q3)
hold on
plot3(x,y,z,'o')
plot3(x,y,z,'b')
%% Go back to original position
qfi=robot.ikine6s(T8)
qfo=[0 pi/2 0 0 0 0]
qf=jtraj(qfi,qfo,length(t))
robot.plot(qf)

%% workspace generation
for i=1:1:1000
    %generate random sample within the joint limits
a1(i)=(160+160)*rand()-160;
a2(i)=(225+45)*rand()-45;
a3(i)=(45+225)*rand()-225;
a4(i)=(170+110)*rand()-110;
a5(i)=(100+100)*rand()-100;
a6(i)=(266+266)*rand()-266;
end

for i=1:1000
    q=[a1(1,i),a2(1,i),a3(1,i),a4(1,i),a5(1,i),a6(1,i)];
    T=robot.fkine(q);
    p=transl(T);
    plot=plot3(p(1,1),p(1,2),p(1,3),'r.')
    robot.plot(q)
    plot.LineWidth=5;
    hold on
%     pause(0.1);
    
end
grid on
hold on
robot.plot([0 0 0 0 0 0])