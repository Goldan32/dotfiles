#!/usr/bin/env bash

HEADPHONE='alsa_output.usb-HP__Inc_HyperX_Cloud_III_000000000000-00.analog-stereo'
SPEAKER='alsa_output.pci-0000_0d_00.3.iec958-stereo'

if [ "$1" == "" ]; then
    if [ "$(pactl get-default-sink)" == "$HEADPHONE" ]; then
        pactl set-default-sink "$SPEAKER"
    else
        pactl set-default-sink "$HEADPHONE"
    fi
    exit 0
fi

case "$1" in
    "headphone")
        pactl set-default-sink "$HEADPHONE"
    ;;
    "speaker")
        pactl set-default-sink "$SPEAKER"
    ;;
esac
