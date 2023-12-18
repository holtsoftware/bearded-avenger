# SPDX-FileCopyrightText: 2018 Dan Halbert for Adafruit Industries
#
# SPDX-License-Identifier: MIT

"""
`Gamepad`
====================================================

* Author(s): Dan Halbert
"""

import struct
import time

try:
    import supervisor
except ImportError:
    supervisor = None

try:
    from typing import Sequence
except ImportError:
    pass

# usb_hid may not exist on some boards that still provide BLE or other HID devices.
try:
    from usb_hid import Device
except ImportError:
    Device = None

def find_device(
    devices: Sequence[object],
    *,
    usage_page: int,
    usage: int,
    timeout: int = None,
) -> object:
    """Search through the provided sequence of devices to find the one with the matching
    usage_page and usage.

    :param timeout: Time in seconds to wait for USB to become ready before timing out.
    Defaults to None to wait indefinitely.
    Ignored if device is not a `usb_hid.Device`; it might be BLE, for instance."""

    if hasattr(devices, "send_report"):
        devices = [devices]  # type: ignore
    device = None
    for dev in devices:
        if (
            dev.usage_page == usage_page
            and dev.usage == usage
            and hasattr(dev, "send_report")
        ):
            device = dev
            break
    if device is None:
        raise ValueError("Could not find matching HID device.")

    # Wait for USB to be connected only if this is a usb_hid.Device.
    if Device and isinstance(device, Device):
        if supervisor is None:
            # Blinka doesn't have supervisor (see issue Adafruit_Blinka#711), so wait
            # one second for USB to become ready
            time.sleep(1.0)
        elif timeout is None:
            # default behavior: wait indefinitely for USB to become ready
            while not supervisor.runtime.usb_connected:
                time.sleep(1.0)
        else:
            # wait up to timeout seconds for USB to become ready
            for _ in range(timeout):
                if supervisor.runtime.usb_connected:
                    return device
                time.sleep(1.0)
            raise OSError("Failed to initialize HID device. Is USB connected?")

    return device

class Gamepad:
    """Emulate a generic gamepad controller with 16 buttons,
    numbered 1-16, and two joysticks, one controlling
    ``x` and ``y`` values, and the other controlling ``z`` and
    ``r_z`` (z rotation or ``Rz``) values.

    The joystick values could be interpreted
    differently by the receiving program: those are just the names used here.
    The joystick values are in the range -127 to 127."""

    def __init__(self, devices):
        """Create a Gamepad object that will send USB gamepad HID reports.

        Devices can be a list of devices that includes a gamepad device or a gamepad device
        itself. A device is any object that implements ``send_report()``, ``usage_page`` and
        ``usage``.
        """
        self._gamepad_device = find_device(devices, usage_page=0x1, usage=0x05)

        # Reuse this bytearray to send mouse reports.
        # Typically controllers start numbering buttons at 1 rather than 0.
        # report[0] buttons 1-8 (LSB is button 1)
        # report[1] buttons 9-16
        # report[2] buttons 17-25
        # report[3] buttons ....
        # report[4] joystick 0 x: -127 to 127
        # report[5] joystick 0 y: -127 to 127
        self._report = bytearray(6)

        # Remember the last report as well, so we can avoid sending
        # duplicate reports.
        self._last_report = bytearray(6)

        # Store settings separately before putting into report. Saves code
        # especially for buttons.
        self._buttons_state = 0
        self._buttons_state2 = 0
        self._joy_x = 0
        self._joy_y = 0
        self._joy_z = 0
        self._joy_r_z = 0

        # Send an initial report to test if HID device is ready.
        # If not, wait a bit and try once more.
        try:
            self.reset_all()
        except OSError:
            time.sleep(1)
            self.reset_all()

    def press_buttons(self, *buttons):
        """Press and hold the given buttons."""
        for button in buttons:
            if button >= 17 and button <= 25:
                self._buttons_state2 |= 1 << self._validate_button_number(button) - 17
            else:
                self._buttons_state |= 1 << self._validate_button_number(button) - 1
        self._send()

    def release_buttons(self, *buttons):
        """Release the given buttons."""
        for button in buttons:
            if button >= 17 and button <= 25:
                self._buttons_state2 &= ~(1 << self._validate_button_number(button) - 17)
            else:
                self._buttons_state &= ~(1 << self._validate_button_number(button) - 1)
        self._send()

    def release_all_buttons(self):
        """Release all the buttons."""

        self._buttons_state = 0
        self._buttons_state2 = 0
        self._send()

    def click_buttons(self, *buttons):
        """Press and release the given buttons."""
        self.press_buttons(*buttons)
        self.release_buttons(*buttons)

    def move_joysticks(self, x=None, y=None, z=None, r_z=None):
        """Set and send the given joystick values.
        The joysticks will remain set with the given values until changed

        One joystick provides ``x`` and ``y`` values,
        and the other provides ``z`` and ``r_z`` (z rotation).
        Any values left as ``None`` will not be changed.

        All values must be in the range -127 to 127 inclusive.

        Examples::

            # Change x and y values only.
            gp.move_joysticks(x=100, y=-50)

            # Reset all joystick values to center position.
            gp.move_joysticks(0, 0, 0, 0)
        """
        if x is not None:
            self._joy_x = self._validate_joystick_value(x)
        if y is not None:
            self._joy_y = self._validate_joystick_value(y)
        if z is not None:
            self._joy_z = self._validate_joystick_value(z)
        if r_z is not None:
            self._joy_r_z = self._validate_joystick_value(r_z)
        self._send()

    def reset_all(self):
        """Release all buttons and set joysticks to zero."""
        self._buttons_state = 0
        self._buttons_state2 = 0
        self._joy_x = 0
        self._joy_y = 0
        self._joy_z = 0
        self._joy_r_z = 0
        self._send(always=True)

    def _send(self, always=False):
        """Send a report with all the existing settings.
        If ``always`` is ``False`` (the default), send only if there have been changes.
        """
        struct.pack_into(
            "<Hbbbb",
            self._report,
            0,
            self._buttons_state,
            self._buttons_state2,
            0,
            self._joy_x,
            self._joy_y,
        )

        if always or self._last_report != self._report:
            self._gamepad_device.send_report(self._report)
            # Remember what we sent, without allocating new storage.
            self._last_report[:] = self._report

    @staticmethod
    def _validate_button_number(button):
        if not 1 <= button <= 25:
            raise ValueError("Button number must in range 1 to 16")
        return button

    @staticmethod
    def _validate_joystick_value(value):
        if not -127 <= value <= 127:
            raise ValueError("Joystick value must be in range -127 to 127")
        return value
