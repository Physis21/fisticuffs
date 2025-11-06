# fisticuffs_v1.0.0
Follow structure from "godot platform fighter series".
 
## Dimensions
For now, keep 1200 width and 900 height, for a 4:3 ratio like SF3 and MBAACC

## Differences with respect to tutorial
- Here only Run, no dash
- frame function is _frame, to not be redundant with frame var

## Progression
- Part 12, 05:08 (Hitlag)
- Reason was Raycasts need to be "Hit from inside" = On, and I forgot to change John's collision layer mask
- Small changes to do in "Revamping your Plat... Godot 4.0", which were the reason for the bugs
- replace clamp and lerp by clampf and lerpf
 
