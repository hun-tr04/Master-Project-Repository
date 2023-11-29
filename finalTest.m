%{
ports:
ultrasonic: 1
color: 2
touch: 3
left motor:  A
right motor: D
-------Numbers Corresponding to colors--------
2 -- blue
3 -- green
4 -- yellow
5 -- red

%}


motorlf = -20;   %A
motorrf = -20; %D
motorlb = 25;
motorrb = 25;
threshold = 50;

brick.SetColorMode(2, 2);
brick.GyroCalibrate(4);
while 1
    %Move Forward
    brick.MoveMotor('A', motorlf);
    brick.MoveMotor('D', motorrf);
    
    %Get Sensor Readings
    touch = brick.TouchPressed(3);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    
    %Color Decisions
    if color == 5                      %if color is red stop for 4 sec                   
        disp('red');
        brick.StopMotor('AD', 'Brake'); %Brake to prevent going off course
        pause(4); %wait 4 seconds
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('D', motorrf);
        pause(0.5);
    elseif  color == 4    %if color is yellow rotate 180 and reverse
        disp('yellow');
      % Perform a 180-degree turn
     brick.MoveMotorAngleAbs('A', 30, 672, 'Brake');
    brick.MoveMotorAngleAbs('D', 30, 672, 'Brake');
     brick.StopMotor('AD', 'Brake');
     brick.MoveMotor('A', motorlf); 
     brick.MoveMotor('D', motorrf);



    end
    
    %Navigation
    if distance > threshold                %if right wall falls away from right side
        pause(.6); %wait to get past wall
        brick.StopMotor('AD', 'Brake');
    brick.MoveMotorAngleAbs('A', 30, 672, 'Brake');
    brick.MoveMotorAngleAbs('D', 30, 672, 'Brake');
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('D', motorrf);
        pause(2);
    end 
    if touch %if hit wall in front
        pause(3); %keep going forward for a short period of time in order to calibrate
      
        disp('touched');
        brick.StopMotor('AD');          %stop
        dist = brick.UltrasonicDist(1); %get distance from right wall
        brick.MoveMotor('A', motorlb);
        brick.MoveMotor('D', motorrb);
        pause(2); %time to back up from wall
        brick.StopMotor('AD', 'Brake'); %stop
        
        %theoretically should never get here if previous method right
        if distance < threshold %if there is no wall on the right
            brick.MoveMotor('D', -18.5); 
            pause(2.5);
            brick.StopMotor('D', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('D', motorrf);
            pause(2);
        else %if there is a wall on the right
            
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('D', motorrf);
            pause(2);
        end
    end
end