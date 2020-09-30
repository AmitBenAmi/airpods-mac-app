#!/bin/bash

BLUEUTIL_BIN=/usr/local/bin/blueutil
AUDIO_BIN=/usr/local/bin/SwitchAudioSource

AIRPODS_BLUETOOTH_DEVICE_ID="ac-90-85-dd-c0-3e"
AIRPODS_AUDIO_DEVICE_NAME="Amit’s AirPods Pro"

IS_AIRPODS_CONNECTED_TO_BLUETOOTH=$($BLUEUTIL_BIN --is-connected $AIRPODS_BLUETOOTH_DEVICE_ID)

if [ $IS_AIRPODS_CONNECTED_TO_BLUETOOTH -eq 0 ]
then
  echo "Connecting to the AirPods Pro"
  $BLUEUTIL_BIN --connect $AIRPODS_BLUETOOTH_DEVICE_ID
  echo "Connected to the AirPods Pro"

  echo "Waiting for Bluetooth to connect to AirPods Pro"
  sleep 5
fi

CONNECTED_AUDIO_DEVICE=$($AUDIO_BIN -c)

if [[ $CONNECTED_AUDIO_DEVICE != $AIRPODS_AUDIO_DEVICE_NAME ]]
then
  echo $TEST
  echo "Audio switch to AirPods Pro"
  $AUDIO_BIN -s "${AIRPODS_AUDIO_DEVICE_NAME}"
  echo "Audio is set to AirPods Pro"
fi

echo "AirPods connected to Mac"
