# Errata

This document lists any errors and/or corrections to the printed material of the book. This does not indicate errors with the code in this repository, which is tested and updated separately.

NOTE: Page numbers are for the print version. Ebook page numbers may be slightly different.

## Chapter 2

p. 42 - [TYPO] In the `Tween` code snippet, the node name should be `CollisionShape2D`, not `CollisionShape2d`

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

p. 73 - [TYPO] On step 7, when adding the `VBoxContainer`, the layout option in the dropdown is called "HCenter Wide", not "Center Wide".

## Chapter 4

p. 99 - [TYPO] In the table of input actions, 'S' is listed for "up" and `W` for "down". This should be reversed.
