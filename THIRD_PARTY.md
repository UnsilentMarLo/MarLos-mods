# Third-party and game-derived material

"Marlo's mod Compilation" adds units, projectiles and effects that the author made or edited **based on vanilla units**
(its own `mod_info.lua` says so). That makes a large part of it derived from Supreme Commander: Forged Alliance game data.
This file lists what is known. **The owner has set the whole repository to MIT** (see `LICENSE`).

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

## License

MIT for the whole repository, as decided by the owner (see `LICENSE`). The list above only records where parts of the mod come from. For a release,
it is still worth noting which of the textures, models and sounds are the author's own, and the origin of the `KEB2305` script.
## Release size

The mod folder is about 313 MB uncompressed (the release zip is about 120 MB).
GitHub allows release assets up to 2 GB, so the one-zip release is possible; the CI run needs the checkout (about 130 MB
packed) plus the zip.
