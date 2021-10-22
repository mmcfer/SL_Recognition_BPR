function drawBones2D_pixels(Pos)

           

  hold on
    y=Pos(1:11,2);
    x=Pos(1:11,1);

    hh(1)=plot(x,y,'r.');
   hh(4)=plot(x([9  11]),y([9  11]),'m');
    hh(3)=plot(x([10 11 ]),y([10 11 ]),'g');
    hh(4)=plot(x([9 10]),y([9 10]),'m');
   
    hh(6)=plot(x([2 3 4 5]),y([2 3 4 5]),'b');
    hh(7)=plot(x([2 6 7 8]),y([2 6 7 8]),'b');
    hh(8)=plot(x([1 2]),y([1 2]),'c');
    hh(9)=plot(x([2 9]),y([2 9]),'c');
    drawnow
hold off

