#!/bin/bash
for win in $(hyprctl clients | grep -oP '^\s*\K[^ ]+'); do
    hyprctl dispatch togglefloating "$win"
done
