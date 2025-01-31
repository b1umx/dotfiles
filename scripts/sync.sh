#!/bin/sh
rsync -av --exclude="nvim/lazy-lock.json"  "${HOME}/.config/nvim" ./

