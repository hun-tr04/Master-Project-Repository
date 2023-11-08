%{
LW: A
RW: B
Lift: C

Touch 1: 1
Touch 2: 2
Color: 3
Ultrasonic: 4
Gyro: 5
%}

brick.SetColorMode(2, 2);

threshold = 50;

while 1
    touch1 = brick.TouchPressed(1);
    touch2 = brick.TouchPressed(2);
    color = brick.ColorCode(3);
    d1 = brick.UltrasonicDist(4);

    if color == 5
        brick.StopMotor('AD', 'Brake');
        pause(4);
        brick.MoveMotor('A', -25); 
        brick.MoveMotor('D', -25);
        pause(0.5);
    elseif color == 4
        brick.StopMotor('AD', 'Brake');
        pause(1);
        brick.MoveMotor('A', -25);
        brick.MoveMotor('D', 25);
        pause(1);
        brick.MoveMotor('C', 25);
        pause(1);
    end

    brick.MoveMotor('A', -25);
    brick.MoveMotor('B', -25);

    if touch1 || touch2
        pause(1);
        brick.StopMotor('AB');
        brick.MoveMotor('A', 25);
        brick.MoveMotor('B', 25);
        pause(3.5);
        brick.StopMotor('AB', 'Brake');
        if d1 < threshold
            brick.MoveMotor('B', -22); 
            pause(2.5);
            brick.StopMotor('B', 'Brake');
            brick.MoveMotor('A', -50); 
            brick.MoveMotor('B', -50);
            pause(2);
        else
            brick.MoveMotor('A', -22);
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', -50); 
            brick.MoveMotor('B', -50);
            pause(2);
        end
    end
    
    %{
    if touch
        pause(1);
        disp('touched');
        brick.StopMotor('AB');
        brick.MoveMotor('A', 25);
        brick.MoveMotor('B', 25);
        pause(3.5);
        brick.StopMotor('AB', 'Brake');

        if d1 < threshold
            brick.MoveMotor('B', -25); 
            pause(2.5);
            brick.StopMotor('B', 'Brake');
            brick.MoveMotor('A', -50); 
            brick.MoveMotor('B', -50);
            pause(2);
        else
            brick.MoveMotor('A', -25);
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', -50); 
            brick.MoveMotor('B', -50);
            pause(2);
        end
    end
    %}
end