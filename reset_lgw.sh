#!/bin/sh

# This script is intended to be used on SX1302 CoreCell platform, it performs
# the following actions:
#       - export/unpexort GPIO17 to reset the SX1302 chip and to enable the LDOs
#       - the script uses the GPIO sets for RPi5 compatibility
# Usage examples:
#       ./reset_lgw.sh stop
#       ./reset_lgw.sh start

# GPIO mapping has to be adapted with HW
#

SX1302_RESET_PIN=25

WAIT_GPIO() {
    sleep 0.2
}

init() {
    # setup GPIOs
    gpioset gpiochip0 $SX1302_RESET_PIN=0; WAIT_GPIO

    # set GPIOs as output
    gpioset gpiochip0 $SX1302_RESET_PIN=1; WAIT_GPIO

    # inform user where this file is
    echo "using gpioset because of breaking changes in 6.6+ Kernels"
    echo "init GPIO25 for SX130x on Pi-Hat for RAK2287"
}

reset() {
    echo "SX130x reset through GPIO$SX1302_RESET_PIN"

    gpioset gpiochip0 $SX1302_RESET_PIN=1; WAIT_GPIO
    gpioset gpiochip0 $SX1302_RESET_PIN=0; WAIT_GPIO
}

term() {
    # cleanup all GPIOs
    if [ $(gpioget gpiochip0 $SX1302_RESET_PIN) -eq 1 ]
    then
        echo "$SX1302_RESET_PIN" > /sys/class/gpio/unexport; WAIT_GPIO
    fi
}

case "$1" in
    start)
    term # just in case
    init
    reset
    ;;
    stop)
    reset
    term
    ;;
    *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

exit 0
