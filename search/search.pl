%%%%%%%%%%%%%%%%%%%%%%  
% Your code goes here:  
%%%%%%%%%%%%%%%%%%%%%%  

% search(+Actions) finds the shortest sequence of moves to reach the treasure  
search(Actions) :-  
    initial(StartRoom),  
    treasure(TreasureRoom),  
    bfs([(StartRoom, [], [StartRoom], [])], TreasureRoom, Actions).  

% bfs(+Queue, +TreasureRoom, -Actions) performs breadth-first search  
bfs([(Room, Keys, Path, Visited)|_], Room, Path) :-  
    % Found the treasure, return the path of actions  
    write('Path found: '), write(Path), nl.  

bfs([(Room, Keys, Path, Visited)|Queue], TreasureRoom, Actions) :-  
    write('Exploring room: '), write(Room), nl,  

    % Find all valid next states  
    findall((NextRoom, NewKeys, [NextRoom|Path], [NextRoom|Visited]),  
            (  
                door(Room, NextRoom),  
                \+ member(NextRoom, Visited),  % Avoid revisiting rooms  
                (  
                    locked_door(Room, NextRoom, LockType),  
                    member(LockType, Keys)  % Can pass if key collected  
                ;  
                    \+ locked_door(Room, NextRoom, _),  % No lock at all from Room to NextRoom  
                    NewKeys = Keys  % No lock from current Room to NextRoom and currentRoom = nextRoom  
                ),  
                (   key(NextRoom, NewKey) ->  
                    append(Keys, [NewKey], NewKeys)  
                ;   NewKeys = Keys  
                )  
            ),   
            NextStates),  

    % Debugging output: Print next states  
    write('New queue: '), write(NextStates), nl,  

    % Check if the queue is empty  
    (   NextStates = [] ->  
        write('No path to the treasure room'), nl  
    ;   % Goal not reached, continue BFS with the updated queue  
        append(Queue, NextStates, NewQueue),  
        bfs(NewQueue, TreasureRoom, Actions)  
    ).  

% test the code  
?- consult(scenario1).  
%-?- consult(search).