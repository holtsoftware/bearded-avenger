import usb_hid
import board
import digitalio
from hid_gamepad import Gamepad

class BoardButton:
    def __init__(self, button, boardPin):
        self.Button = button
        self.BoardPin = boardPin

class DIOButton:
    def __init__(self, dio, button):
        self.Button = button
        self.DigitalInOut = dio

class GamepadManager:
    def __init__(self):
        self.gp = Gamepad(usb_hid.devices)
        self.buttons = (
            BoardButton(1,board.GP1),
            BoardButton(2,board.GP2),
            BoardButton(3,board.GP3),
            BoardButton(4,board.GP4),
            BoardButton(5,board.GP5),
            BoardButton(6,board.GP6),
            BoardButton(7,board.GP7),
            BoardButton(8,board.GP8),
            BoardButton(9,board.GP9),
            BoardButton(10,board.GP10),
            BoardButton(11,board.GP11),
            BoardButton(12,board.GP12),
            BoardButton(13,board.GP13),
            BoardButton(14,board.GP14),
            BoardButton(15,board.GP15),
            BoardButton(16,board.GP16),
            BoardButton(17,board.GP17),
            BoardButton(18,board.GP18),
            BoardButton(19,board.GP19),
            BoardButton(20,board.GP20),
            BoardButton(21,board.GP21),
            BoardButton(22,board.GP22),
            BoardButton(23,board.GP23)
        )
        self.pins = [DIOButton(digitalio.DigitalInOut(pin.BoardPin),pin.Button) for pin in self.buttons]

        for b in self.pins:
            b.DigitalInOut.direction = digitalio.Direction.INPUT
            b.DigitalInOut.pull = digitalio.Pull.DOWN

    def process(self):
        for b in self.pins:
            if b.DigitalInOut.value:
                self.gp.press_buttons(b.Button)
            else:
                self.gp.release_buttons(b.Button)
