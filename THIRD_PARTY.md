# Third-party and game-derived material

"Marlo's mod Compilation" adds units, projectiles and effects that the author made or edited **based on vanilla units**
(its own `mod_info.lua` says so). That makes a large part of it derived from Supreme Commander: Forged Alliance game data.
This file lists what is known. **How to publish the mod is an open decision for the owner** (below). Nothing here is legal
advice.

## Known game-derived or third-party content

| What | Evidence | Terms |
|---|---|---|
| Unit scripts and blueprints | 59 files in `units/`, 6 in `lua/`, 5 in `projectiles/` and 1 in `hook/` carry "Copyright 2005/2006/2007 Gas Powered Games, Inc. All rights reserved" headers (authors named: John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos, Matt Vainio, Ted Snook, Drew Staltman, Aaron Lundquist, ...) | Proprietary, Gas Powered Games / Square Enix. FAF distributes the base game's Lua under GPL-3.0 ([FAForever/fa](https://github.com/FAForever/fa)); the blueprints, models and textures are not covered by that |
| Animations | 9 `.sca` files have exactly the byte size of vanilla animations (`KAS0302_Adeath01-03`, `KEL0306_awater`, `KRS0302_Asink`, `KRS0401_Asink*`, `KSS0301_adeath02/03`; sizes match entries of `/units/UAS0201`, `UAB3201`, `URS0201`, `URS0202`, `XSS0201`) | Almost certainly unmodified copies of game files |
| Projectile models | 9 `.scm` files have exactly the byte size of vanilla models (`AAAZealotMissileMK`, `MKIFMissileTactical01`, `TAAMissileFlayer06/07`, `TDFGauss010`, `TIFAntiMatterShells05/06`, `TIFHETacticalNuclearShell06`, `TIMMissileIntercerptorMK` against `AAALightDisplacementAutoCannonMissile01`, `CIFMissileTactical01`, `TAAMissileFlayer01`, `TDFGauss01`, `TIFAntiMatterShells01`, `TIFHETacticalNuclearShell01`, `TIMMissileIntercerptor01`) | Almost certainly copies of game files. Their textures (`projectiles/*`) could not be compared (same-size DDS files are not evidence) |
| `units/KEB2305/KEB2305_script.lua` | header: "Author(s): Mikko Tyster, Copyright 2008 Blade Braver!" (class `DELK002`); it imports `/lua/kirvesweapons.lua`, which FAF's base game provides | Other authors; license unknown |
| Unit models (`.scm`) and textures (`.dds`, 797 files) in `units/` | No unit `.scm` has a vanilla byte size, so they are edited or new meshes; whether the textures are the author's own paintings or edited vanilla textures cannot be seen from the repository | **Unknown: the owner must say which are original** |
| `lua/MK*.lua` (default projectiles, weapons, effect templates and utilities) | named after FAF's `defaultprojectiles`, `defaultweapons`, `effecttemplates`, `effectutilities`; Gas Powered Games headers sit in 6 files of `lua/` | Probably derived from FAF / GPG Lua |
| `sounds/MarlosSoundsUEF.xwb/.xsb` | a sound bank (4.5 MB); the origin of the audio is not documented | **Unknown** |
| Everything else (`effects/emitters`, `textures/particles`, `textures/ui`) | not identifiable from here | **Unknown** |

The mod depends on the game and FAF only through `import()`; `kirvesweapons.lua` (used by three unit scripts) is part of FAF.

## What probably is the author's own work

`lua/CustomUnits/MK_Units_*.lua`, `lua/AI/AIBuilders/ModdedUnitsUpgrade.lua`, the `hook/` files, the numeric balance values and
new fields of the unit blueprints (as edits), the unit concepts and the notes in `docs/`.

## Decision for the owner

The standards of this account forbid publishing anything taken from the game. This repository already exists on GitHub with
its full history, including the game-derived files and the old 2048x2048 textures, so the question is not only about a first
release. Options:

1. Keep the repository private (or make no release) until the assets are sorted out.
2. Publish only what is provably yours: remove the game-derived scripts, blueprints, animations and projectile models and ship
   the mod as a patch that depends on the game files (merge blueprints, `ModBlueprints`) instead of full copies.
3. Keep it as a fan mod, accepting that the game-derived files stay under Gas Powered Games' / Square Enix's terms. In that
   case do not claim MIT for the whole repository.

Also needed for any release: say which of the 797 textures, the 86 models and the sound bank are your own, and confirm the
origin of the `KEB2305` script.

## Release size

The mod folder is about 313 MB uncompressed (the release zip is about 120 MB).
GitHub allows release assets up to 2 GB, so the one-zip release is possible; the CI run needs the checkout (about 130 MB
packed) plus the zip.
