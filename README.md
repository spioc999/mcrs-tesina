# mcrs-tesina

# Config file
The config file must be set up as follow.

InitialPosition, MovementEnabled, Direction, Delta
[x y w h], 0/1, 0/3, float [-1 1]
[* * * *], *, *, * -> * represents the escape character, totally random block.

## Field Meaning
- InitialPosition: 
    - x: x coordinate
    - y: y coordinate
    - w: width of the rectangle
    - h: height of the rectangle
- MovementEnabled: Boolean, defines if this block moves or not
- Direction: 4 possible directions
    - 0: vertical
    - 1: diagonal-right (bottom:left, up:right)
    - 2: horizontal
    - 3: diagonal-left (bottom:right, up:left)
- Delta: defines the block movement, should be a small value that could be also a negative value. (from -1 to 1) 

Each information will populate a different vector and to retrive info about a specific block you should refer to it by its list index.