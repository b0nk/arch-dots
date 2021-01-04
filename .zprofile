#!/bin/zsh

export PATH="$PATH:$HOME/.local/bin"

export EDITOR="nano"
export TERMINAL="xfce4-terminal"
export BROWSER="firefox"

export MOZ_X11_EGL=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
