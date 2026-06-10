# Open in iTerm2

A lightweight macOS utility that opens the current Finder folder in **iTerm2** with a single click from the Finder toolbar.

![Dragging](.github/assets/Dragging.gif)
![Using](.github/assets/Using.gif)

## Features

- **One-click**: opens the active Finder window's folder in iTerm2
- **Headless**: no windows, no Dock icon
- **Universal binary**: runs natively on Intel and Apple Silicon
- **Zero dependencies** beyond macOS Command Line Tools
- **Minimal codebase**: ~30 lines of Swift

## Requirements

- macOS 11.0+ (Big Sur)
- [iTerm2](https://iterm2.com/) installed in `/Applications`

## Installation

### Download

Grab the latest `Open in iTerm2.app.zip` from [Releases](../../releases), unzip, and move to `/Applications`.

### Build from source

```bash
./build.sh
```

The app bundle appears at `build/Open in iTerm2.app`.

## Usage

1. Drag `Open in iTerm2.app` into `/Applications`.
2. Open a Finder window and navigate to the folder you want.
3. Hold **⌘** and drag `Open in iTerm2.app` onto the Finder toolbar.
4. Click the toolbar icon — iTerm2 opens at that folder.

## How it works

The app runs a small embedded AppleScript to ask Finder for the path of the frontmost window, then launches iTerm2 at that path via `/usr/bin/open`.

## License

[MIT](LICENSE)
