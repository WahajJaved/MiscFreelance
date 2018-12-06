function [maze, dplayer, game_over] = random_move(maze, dplayer)
%determine player location in maze
player = find(maze=="P");
[playerx, playery] = ind2sub(size(maze), player);

%choose random x, y directions
randomx_dir = randi(3);
randomy_dir = randi(3);

%if 1, add 1 to current x or y
if randomx_dir == 1
    playerx = playerx + 1;
    if playerx > length(maze)
        playerx = 1;
    end
end

if randomy_dir == 1
    playery = playery + 1;
    if playery > length(maze)
        playery = 1;
    end
end

%if 2, subtract 1 from current x or y
if randomx_dir == 2
    playerx = playerx - 1;
    if playerx < 1
        playerx = length(maze);
    end
end

if randomy_dir == 2
    playery = playery - 1;
    if playery < 1
        playery = length(maze);
    end
end

%if either is 3, just ignore it

%check to see if you found exit, or a monster, or just moved to another
%empty spot
%found monster, fight and win, or lose game
if maze(playerx, playery) == "M"
    monster = create_monster;
    disp('You encountered a monster!');
    disp('Rolling the dice to see who attacks first!');
    pick_a_number = randi(6);
    your_choice = input('Choose the correct number to attack the monster first\n');
    if your_choice == pick_a_number
        disp('You chose the correct number! You attack first');
        while monster(1)>0 & dplayer(1)>0
            %player attack
            monster(1) = monster(1) - dplayer(2);
            %if monster not dead, monster attack
            if monster(1)>0
                dplayer(1) = dplayer(1)-monster(2);
            end
        end
        %you beat monster, keep going
        %otherwise game over
        if dplayer(1)>0
            disp('You defeated the monster!');
            maze(playerx, playery) = "P";
            maze(player) = "0";
            game_over = 1;
			fprintf('Your new coordinates are: %d %d\n', playerx, playery);
        else
            disp('The monster killed you. You lost the game.');
            maze(:) = "L";
            game_over = 0;
        end
    else
        disp('You chose the wrong number! Monster attacks first');
        while monster(1)>0 & dplayer(1)>0
            %monster attack
            dplayer(1) = dplayer(1)-monster(2);
            %if player not dead, monster attack
            if dplayer(1)>0
                monster(1) = monster(1) - dplayer(2);
            end
        end
        %you beat monster, keep going
        %otherwise game over
        if dplayer(1)>0
            disp('You defeated the monster!');
            maze(playerx, playery) = "P";
            maze(player) = "0";
            game_over = 1;
			fprintf('Your new coordinates are: %d %d\n', playerx, playery);
        else
            disp('The monster killed you. You lost the game.');
            maze(:) = "L";
            game_over = 0;
        end
    end
    %found exit, you win
elseif maze(playerx, playery) == "E"
    disp('You win!');
    maze(:) = "W";
    game_over = 0;
    %otherwise, just update coordinates
else
    fprintf('Your new coordinates are: %d %d\n', playerx, playery);
    maze(player) = "0";
    maze(playerx, playery) = "P";
    game_over = 1;
end
end
