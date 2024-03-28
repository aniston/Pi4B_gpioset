#!/bin/bash

# Reset iC880a PIN
SX1301_RESET_BCM_PIN=17
SX1301_GPIO_CHIP=4

# Export the GPIO pin on the specified chip
echo "$SX1301_RESET_BCM_PIN" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/direction
echo "0" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "1" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "0" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1

# Unexport the GPIO pin on the specified chip
echo "$SX1301_RESET_BCM_PIN" > /sys/class/gpio/gpiochip$SX1301_GPIO_CHIP/unexport

# Run other commands
./set_eui.sh
sleep 0.2
# ./update_gwid.sh ./local_conf.json
sleep 0.5
./lora_pkt_fwd
