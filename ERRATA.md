# Errata

This document lists any errors and/or corrections to the printed material of the book. This does not indicate errors with the code in this repository, which is tested and updated separately.

NOTE: Page numbers are for the print version. Ebook page numbers may be slightly different.

## Chapter 2

p. 42 - [TYPO] In the `Tween` code snippet, the node name should be `CollisionShape2D`, not `CollisionShape2d`

p. 43 - [MISSING IMAGE] The image of the "Detach Script" button is missing at the end of this sentence:

> Change the name of the root node to Powerup and remove the script by clicking the Detach script button

p. 44 - [MISSING TEXT] After this paragraph:

> The powerups should appear unpredictably, so the wait time of PowerupTimer needs to be set whenever you begin a new level. Add this to the _process() function after the new coins are spawned with spawn_coins():

Should be the following code snippet:

```
$PowerupTimer.wait_time = randf_range(5, 10)
$PowerupTimer.start()
```
p. 46 - [MISSING TEXT] When adding the Cactus to the game, before the line

> Play the game and see what happens when you run into the cactus.

Should be the following instruction:

> In the Main scene, add an instance of the Cactus object by pressing the "Instantiate Child Scene" button and then position it somewhere in the play area.

## Chapter 3

p. 66 - [CLARIFICATION] The following sentence:

> Don’t forget to drag rock.tscn onto the Rock property.

Should be moved to after the second code snippet (defining `spawn_rocks()`).

p. 69 - [TYPO] In the last code snippet, the node name should be `Sprite2D` not `Sprite2d`

p. 73 - [TYPO] On step 7, when adding the `VBoxContainer`, the layout option in the dropdown is called "HCenter Wide", not "Center Wide".

p. 75 - [MISSING] After defining the `new_game()` function should be the following:

> To update the player's score when they destroy a rock, add the following code to the `_on_rock_exploded()` function:

```
score += 10 * size
```

p. 77 - [CLARIFICATION] Although `TextureProgressBar` is mentioned here, it is not used in the game's UI until the later section regarding the player's shield functionality.

p. 84 - [CLARIFICATION] After adding the line

```
@export var enemy_scene : PackedScene
```

Should be a reminder to assign the enemy scene to the property in the Inspector.


## Chapter 4

p. 99 - [TYPO] In the table of input actions, 'S' is listed for "up" and `W` for "down". This should be reversed.
