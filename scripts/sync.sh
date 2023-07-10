#!/bin/sh
rsync -av --exclude="nvim/plugin/" "${HOME}/.config/nvim" ./

