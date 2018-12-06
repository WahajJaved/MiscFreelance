play_again = 1;
while play_again
    
    %scan directory and save all files that match save files
    files = dir('*save*.txt'); 
    
    %ask if user wants to load saved game. If so, skip initial setup and
    %start playing
    %also make sure there are saves. If no saves, need to skip this
    if input('Would you like to load a previous save?\nPlease type 1 for yes and 0 for no.\n') && length(files)
        save_files = string(); %<-- this string array will contain all of the save file names, like save1.txt, save2.txt, etc...
        for ii = 1:length(files)
            save_files(ii) = files(ii).name;
        end
        
        % You should now have a string array called save_files that has all of your save file names in it.
        % You need to ask the user to select a save file, then process that
        % file to extract the player array and the maze so that you can
        % continue to play the game.
        
        %example of process
        %1) extract player values and save into player variable (player is the
        %array I am saving my player stats to
        %2) extract values and save into maze variable
    
    else %no save files, just start the game normally
        %create or use default player values
        player = [5 5];
        default_player = input('Default player values are 5 hp, and 5 dph. Would you like to change?\n1 for yes and 0 for no.\n');
        if default_player
            player(1) = input('Enter player custom health.\n');
            player(2) = input('Enter player default damage.\n');
        end
    
        %create maze
        maze_size = input('How large would you like the maze to be?\n');
        monsters = input('Enter 0 if you do not want monsters. Any other number if you do.\n');
        maze = create_maze(maze_size, monsters);
    end
    
    %play game!
    game_over = 1;
    %auto play (except for monster fights)
    disp('Would you like to enable the auto-play feature?');
    disp('You would only be required to manually enter input at the beginning of monster battles.');
    auto_play = input('1 for yes, 0 for no.\n');
    if auto_play
        while game_over
            [maze, player, game_over] = random_move(maze, player);
            disp(maze);
            disp(player);
        end
    else
        while game_over
            [maze, player, game_over] = random_move(maze, player);
            disp(maze);
            disp(player);
            next_move = input('Type anything to make next move.\n');
            %need to ask user if they want to save game and exit.
            %that code goes here.
            %make sure you don't overwrite any previous saves. 
            %hint: length(files) tell you how many saved files are in the
            %directory. Save THIS game using the next available number.
            % for example: if the directory currently has 2 saved games
            % (save1.txt and save2.txt), this game should be saved as
            % save3.txt
        end
    end
        
    disp('Would you like to play again?');
    play_again = input('1 for yes, 0 for no\n');
end