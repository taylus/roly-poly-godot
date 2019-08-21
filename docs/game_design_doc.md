# Roly Poly
Roly is trapped in a food factory and needs your help to escape! Eat food to clear stages, but make sure to fill up on Roly's favorites. (He's not about to stop being picky.)

Roly Poly is a retro-style arcade game with two simple rules:

<img src="good_food.gif" alt="Eat tasty food!" title="Eat tasty food!" style="display: block; width: 96px; height: 32px; image-rendering: pixelated; image-rendering: crisp-edges">

<img src="bad_food.gif" alt="Avoid healthy food!" title="Avoid healthy food!" style="display: block; margin-top: 1em; width: 96px; height: 32px; image-rendering: pixelated; image-rendering: crisp-edges">



## Design
Roly Poly's aesthetic is that of a Game Boy game. This is because:

1. I'm a programmer with no art skills, and
2. I think hobbyist development on the Game Boy is fun, but tedious and unnecessarily difficult given modern tools. I realize that's some of the charm, but I want to make a game!

Thus, Roly Poly uses the original Game Boy's [four-color palette](https://gbgfx.legacy.codes) and art style, while forgoing its hardware and programming limitations. Namely, the [Godot game engine](https://godotengine.org/) is used so that I can focus on the game and not the platform. Maybe I'll make an actual Game Boy "demake" later on if it's not too much of a stretch, but the goal of this project is to finish a game and get it published somewhere (Google Play, Steam, etc).

### Graphics
A screen resolution of 256 x 144 pixels was chosen since it is similar to the Game Boy's 160 x 144, but is a more modern 16 : 9 aspect ratio consistent with many mobile devices. Godot supports [scaling up to higher resolutions without any loss of pixel art quality.](https://docs.godotengine.org/en/latest/tutorials/viewports/multiple_resolutions.html)

Game Boy tiles and sprites are 8 x 8 pixels, commonly combined to form larger "metasprites". In Roly Poly, sprites should be multiples of 8 x 8 (so 16 x 16, 32 x 48, etc). It isn't necessary to arbitrarily restrict all graphics to 8 x 8 tiles, but it should *look as if it was*.

(More info on the inner workings of the Game Boy's video memory [here](https://github.com/taylus/gameboy-graphics/blob/master/building_a_rom.md#an-aside-about-game-boy-video-memory).)

## Mechanics
The player controls Roly through a series of levels with a goal of eating until they're full, collecting food that Roly likes (junk food) while avoiding food he doesn't (veggies).

Roly can interact with mechanics in the environment such as:

* Ladders, to reach different floors.
* Pipes and conveyor belts, which deliver food.
* Buttons which control the direction of conveyor belts, the position of walls and floors, and many other aspects of a level.
* Magic pills that grant Roly abilities like flight or ease an upset stomach.

Food expires a few seconds after it touches the ground, disppearing from the game area. If Roly touches it before this, he eats it, reacts appropriately, and gains score (calories).

Roly only has room in his stomach for so much food, however, and will eventually become full. If the player eats too much food that Roly dislikes, by the time they become full, their score won't be high enough to clear the level:

<img src="full_slime_bad.png" alt="Full!" title="Full!" style="display: block; margin-top: 1em; width: 144px; height: 64px; image-rendering: pixelated; image-rendering: crisp-edges">

This prompts a soft "game over" screen and the player is dropped back to a level select menu where they can try again.

However, if the player avoids veggies and eats food Roly likes, they will clear the level and advance onto the next:

<img src="full_slime_good.png" alt="Full!" title="Full!" style="display: block; margin-top: 1em; width: 144px; height: 64px; image-rendering: pixelated; image-rendering: crisp-edges">

# Levels
Levels should strive to "show, don't tell" and introduce at least one new mechanic (or combination of existing mechanics) to keep the player engaged.

## Level 1
A simple level with two pipes + conveyor belts on a single level. This level is meant to be simple, introducing basic movement and the core concept that some food is good and other food is bad.

`TODO: graphic`

## Level 2
This level introduces ladders and multiple floors, making it so it isn't always east to get to food on time before it expires.

`TODO: graphic`

## Level 3
This level introduces buttons the player can press to reverse the direction of a conveyor belt. Food will fall from above onto a central conveyor that will drop food either to its left (where the player is) or its right (inaccessible to the player). The player should use the button to send good food his way while sending bad food to the other side.

`TODO: graphic`

## Level 4
This level introduces longer conveyor belts, some of which feed into each other in a maze-like path. Multiple drop points for food, as well as multiple floors and ladders make timing and paying attention critical so as to collect all the good food without accidentally touching bad food.

`TODO: graphic`

## Level 5

`TODO: description`

`TODO: graphic`

## Level 6

`TODO: description`

`TODO: graphic`

## Level 7

`TODO: description`

`TODO: graphic`

## Level 8

`TODO: description`

`TODO: graphic`

## Level 9
This is the final "escape from the factory" level, taking part outside as food is loaded onto a delivery truck via conveyor. A button collapses a tile on the conveyor belt, making the food drop. The player should do this when good food is over the collapsible tile so as to steal it.

This level should have something more to it if it's the last one, but I don't know what yet.

`TODO: graphic`