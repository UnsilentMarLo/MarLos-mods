# Marlo's mod Compilation

A unit pack for **Supreme Commander: Forged Alliance** (FAF): around 65 new or reworked units (UEF, Aeon, Cybran,
Seraphim; land, air, naval, structures; T1 to T4), their projectiles, effects and a sound bank. Some factions are
unfinished. The units are made or edited from vanilla units. The mod also adds the new units to the AI's upgrade lists.

Status: playable pack, maintained occasionally (mod version 160). Not balanced for ladder play. **Licensing is an open
decision and the repository contains game-derived assets; read [THIRD_PARTY.md](THIRD_PARTY.md) before using or
redistributing anything.**

## Install

1. Download `marlos-mods-<version>.zip` from the Releases page (large: about 120 MB).
2. Extract it so that the folder `#Marlos mods compilation` ends up in
   `Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\Mods`.
3. Enable **Marlo's mod Compilation** in the Mods menu. Every player in the game needs the same version.

## Requirements

Supreme Commander: Forged Alliance with the FAF client. No other mod needed.

## Build

There is nothing to compile; the release is one zip of the mod folder:

```
python <fa-patch-installer>/tools/make_release.py --project . --version 0.1.0 --out out
```

Pushing a tag `vX.Y.Z` runs `.github/workflows/release.yml` (reusable workflow of
[fa-patch-installer](https://github.com/UnsilentMarLo/fa-patch-installer)). The zip is about 120 MB (the mod folder 313 MB), well below GitHub's
2 GB limit for release assets.

## Repository layout

| Path | What |
|---|---|
| `mod/#Marlos mods compilation/mod_info.lua` | mod description |
| `.../units/` | 65 unit folders (`K<faction><layer><tier>`): blueprint, script, models, animations, textures (most of the size) |
| `.../projectiles/`, `effects/`, `textures/`, `sounds/` | projectiles, emitters, particle and UI textures, sound bank |
| `.../lua/` | `CustomUnits/MK_Units_*.lua` (unit classes), `MK*.lua` (projectiles, weapons, effects), AI upgrade builders |
| `.../hook/lua/` | hooks into FAF's `simInit`, `upgradetemplates`, AI builder tables, help texts |
| `docs/` | the author's to-do list of planned units and balance notes (not part of the release) |
| `patch.json` | release description for the kit (`kind: lua`) |

## Testing

Start a skirmish with the mod enabled; the units are available from the factories and engineers of the matching faction and
tech level. Hook problems show up in the game log.

## Credits and license

Units by Marlo (aka Degulum), based on the vanilla units of Gas Powered Games; the `KEB2305` script follows code by Mikko
Tyster / Blade Braver. See [THIRD_PARTY.md](THIRD_PARTY.md) for what is known and what is open, and [LICENSE](LICENSE) for the
restricted, pending MIT notice.
