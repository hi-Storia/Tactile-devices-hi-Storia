/* The Javascript code for micro:bit's online editor */
/* in this code, we have only 3 capacitive sensor */

let handshake = false
basic.forever(() => {
    if (!(handshake)) {
        serial.writeString("Z")
        basic.pause(350)
    }
    basic.pause(50)
})
input.onPinPressed(TouchPin.P0, () => {
    if (handshake) {
        serial.writeNumber(1)
        basic.showString("1")
    }
})
serial.onDataReceived(serial.delimiters(Delimiters.Hash), () => {
    handshake = true
    basic.showIcon(IconNames.Heart)
})
input.onPinPressed(TouchPin.P1, () => {
    if (handshake) {
        serial.writeNumber(2)
        basic.showString("2")
    }
})
input.onButtonPressed(Button.AB, () => {
    handshake = false
    basic.showIcon(IconNames.No)
})
input.onPinPressed(TouchPin.P2, () => {
    if (handshake) {
        serial.writeNumber(3)
        basic.showString("3")
    }
})
handshake = false
basic.showIcon(IconNames.No)
