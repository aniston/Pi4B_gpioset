#!/bin/bash

# Reset iC880a PIN
SX1301_RESET_BCM_PIN=25

# Export the GPIO pin
gpioset gpiochip0 $SX1301_RESET_BCM_PIN=0
gpioset gpiochip0 $SX1301_RESET_BCM_PIN=1
gpioset gpiochip0 $SX1301_RESET_BCM_PIN=0

# Run other commands
./set_eui.sh
sleep 0.2
# ./update_gwid.sh ./local_conf.json
sleep 0.5
./lora_pkt_fwd
