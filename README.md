# dmenu

My personal build of [dmenu](https://dmenu.suckless.org/) 5.4 — the dynamic menu for X, used as the application launcher in my dwm setup.

## Patches Applied

| Patch | Description |
| :--- | :--- |
| [center](https://tools.suckless.org/dmenu/patches/center/) | Centers dmenu on screen instead of anchoring to the edge |
| [fuzzymatch](https://tools.suckless.org/dmenu/patches/fuzzymatch/) | Fuzzy-matching — type non-consecutive characters to narrow results |

## Features

- **Centered** — Appears in the middle of the screen via the `-c` flag (enabled by default in `config.h`), with a minimum width of 200px and no overlap with screen edges
- **Fuzzy matching** — `-F 1` enables fuzzy search: typing "brn" matches "firefox-bin" by skipping characters
- **10-line vertical list** — Shows 10 items at a time for easy scrolling
- **Color scheme** — Tokyonight-inspired (`#c0caf5` on `#24283b` normal, `#24283b` on `#7aa2f7` selected)
- **Launcher scripts** — `dmenu_run` (pipe `PATH` binaries into dmenu) and `dmenu_path` (cached binary listing via `stest`) included

## Config Details

| Setting | Value |
| :------ | :---- |
| Font | `monospace:size=10` |
| Lines | 10 |
| Fuzzy | enabled |
| Centered | enabled |
| Min width | 200px |
| Height ratio | 2.2× line height |
| Normal fg/bg | `#c0caf5` / `#24283b` |
| Selected fg/bg | `#24283b` / `#7aa2f7` |

## How dmenu_run Works

1. `dmenu_path` scans `$PATH` with `stest -flx`, caching the sorted binary list to `~/.cache/dmenu_run`
2. The cache is reused on subsequent calls (faster startup)
3. `dmenu_run` pipes that list into `dmenu`, then executes the selected entry via `$SHELL`

In my dwm config, dmenu is launched with matching colors so it blends seamlessly:

```c
static const char *dmenucmd[] = {
    "dmenu_run", "-m", dmenumon,
    "-fn", dmenufont,
    "-nb", col_bg, "-nf", col_fg,
    "-sb", col_accent, "-sf", col_bg, NULL
};
```

## Installation

```sh
sudo make clean install
```

## Requirements

- Xlib headers
- libXinerama (optional, multi-monitor)
- libXft + fontconfig (font rendering)
