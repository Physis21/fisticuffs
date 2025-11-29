# Project repository for fisticuffs_v1.0.0

- Solo(-ish) personal project of a 2D fighter
- Heavily follow structures from [godot platform fighter series](https://www.youtube.com/watch?v=FKMBkZsPCCA&list=PLeJDGeZe3by2tQIJmCZfaSRl95cot070t)
- To implement more traditional fighter-like mechanics, I differ from the tutorial greatly starting from the 5th video

## Requirements and installing

- Clone the repository into a local directory
- Download godot ver4.5 stable for your OS: [download link](https://godotengine.org/download/archive/4.5-stable/)
  - Advantage of being very lightweight and portable
- From the godot executable, **import** the local directory of the project (`Ctrl+I`) and edit it (select then `Ctrl+E`)
  - This will re-import the assets into the godot project
  - This step is important otherwise some textures will not appear when just running the game directly
- Run the game from the godot game engine with `F5`

## Dimensions

- For now, keep 1200px width and 900px height, for a 4:3 ratio like [*Street Fighter 3 : Third Strike*](https://en.wikipedia.org/wiki/Street_Fighter_III:_3rd_Strike) and [*Melty Blood : Actress Again Current Code*](https://en.wikipedia.org/wiki/Melty_Blood)

## Differences with respect to tutorial

- Rename the frame function to `_frame()`, in order to not be redundant with `frame` var

## Game progression

- Single character with animations (John)
- Movement (running and walljumps), attack and hitstun states functionnal
- Player-to-Player pushing **work in progress**
- No healthbars yet
- Very basic intro menu

## Tutorial progression

- Part 12, 05:08 (Hitlag)
- Small changes to do in "Revamping your Plat... Godot 4.0", which are possible reasons for bugs before this video
- Replace clamp and lerp by `clampf` and `lerpf` for floats, or corresponding functions for ints

## Unit testing

- Consensus is that unit testing in games is time consuming and challenging → **not worth the time investment** in this solo dev project

## TODO

- Pushboxes to implement **street-fighter like collision**, as opposed to smash-like collision with ECBs
- Shoot locations for stage backgrounds
