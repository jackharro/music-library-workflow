#!/bin/bash

# 1. case

convert () {
    case "$@" in
        *.m4a) suffix=m4a ;;
        *.mp3) suffix=mp3 ;;
        *) echo "$0: warn: $@ has an unknown extension, skipping on user input" >&2 && read ;;
    esac
# This block is useless
# vfat uses utf16
# If CONFIG_FAT_DEFAULT_UTF8 is unset by the distro (like in Fedora) it seems to default to false
# Add utf8=true to the mount options (e.g. in fstab)
# For mp3 players that actually don't support Unicode, get a better mp3 player.
# If the SanDisk Clipjam can do it, you should expect your thing to do it too.
# I'm using that device as a minimum supported hardware
# p.s. what does 東京 とうきょう に 住 す んでいる.mp3 even say?
#     # This works, but each character has to be supported manually
#     # The resulting filename is still pretty readable
#     # safe_filename=$(echo "$@" | sed 's/é/e/g')
#     #
#     # This works for all UTF—even all encodings
#     # Multibyte chars are deleted, however
#     # One massive issue would be if all characters for any part of the
#     # ./artist/album/song are deleted such that 
#     safe_filename=$(iconv -ct US-ASCII <(echo "$@"))
#     safe_filename=$(basename "$safe_filename" $suffix).mp3
    echo ffmpeg -i "$@" "$"
}

export -f convert

find archive/dl -type f -name *.m4a -exec bash -c 'convert "{}"' \;
