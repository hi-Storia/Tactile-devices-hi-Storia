# Hi-Storia Tactile Devices

<p align="center">
  <a href="https://www.hi-storia.it/audioguida-tattile/">
    <img
      src="https://www.hi-storia.it/wp-content/uploads/2015/06/laquila.jpg"
      alt="Hi-Storia tactile device"
      width="900"
    />
  </a>
</p>

Open-source firmware and hardware references for **Hi-Storia tactile audio guides**: 3D-printed cultural heritage models with capacitive touch activators that trigger audio and multimedia content.

Learn more about the project:

- [What is a Hi-Storia tactile audio guide?](https://www.hi-storia.it/audioguida-tattile/)
- [Hardware and electronics](https://www.hi-storia.it/audioguida-tattile/hardware/)

## Current reference architecture

The **2026 reference implementation** for new Hi-Storia tactile devices is:

**Arduino UNO R4 Minima + R4_Touch + USB serial + Hi-Storia Go on Android**

```text
3D-printed tactile model
        ↓
capacitive activators
        ↓
Arduino UNO R4 Minima
        ↓
USB serial · T1 / T2 / T3 / ...
        ↓
Android smartphone
        ↓
Hi-Storia Go
        ↓
audio and interactive content
```

This architecture keeps the electronics simple, visible and repairable, while allowing an Android smartphone — including a reused or refurbished device — to act as the player and configuration interface.

## Supported hardware

| Board | Touch sensing | Connection | Status | Field-tested on |
| --- | --- | --- | --- | --- |
| **Arduino UNO R4 Minima** | `R4_Touch` / built-in CTSU | USB serial | **Reference hardware** | Torpignattara, Rome (2026) |
| **ESP32** | Native capacitive touch | USB serial + Bluetooth Classic | **Supported alternative** | San Flaviano (2026) |
| Arduino UNO R3 | Legacy capacitive sensing | USB serial | Legacy | Previous Hi-Storia devices |
| Arduino Micro | Legacy capacitive sensing | USB serial | Legacy | Previous Hi-Storia devices |
| BBC micro:bit | Previous implementation | Serial / project-specific | Legacy / educational | Previous Hi-Storia workshops |

The older implementations remain in the repository for compatibility, documentation and educational reuse.

## Arduino UNO R4 Minima

The UNO R4 Minima is the current reference board for new Hi-Storia devices.

The reference firmware uses the [`R4_Touch`](https://github.com/delta-G/R4_Touch) library to access the capacitive touch sensing unit built into the UNO R4 microcontroller.

Current reference sketch:

```text
Firmware/Arduino/historia_arduino_uno_r4/
└── historia_arduino_uno_r4.ino
```

The current Hi-Storia configuration uses touch-capable pins:

```text
2, 3, 8, 9, 11
```

### R4_Touch hardware note

On the **UNO R4 Minima**, `R4_Touch` requires a capacitor between **TSCAP (pin 10)** and **GND**. The library recommends approximately **10 nF**.

The firmware uses single-scan touch acquisition, the configuration field-tested on the Torpignattara tactile device.

## ESP32

ESP32 is maintained as a supported alternative for installations where its integrated features are useful.

The Hi-Storia ESP32 firmware uses:

- native ESP32 capacitive touch inputs;
- USB serial;
- Bluetooth Classic;
- persistent threshold configuration through `Preferences`.

Reference sketch:

```text
Firmware/ESP32/historia_esp32/
└── historia_esp32.ino
```

This implementation was field-tested on the **San Flaviano Hi-Storia tactile device (2026)**.

The reference Hi-Storia Go workflow currently uses USB serial. Bluetooth support in the ESP32 firmware can also be used by compatible players or custom integrations.

## Serial protocol

Current firmware implementations share a small text-based protocol.

### Board → player

```text
T1
T2
T3
...
MSG:HI-STORIA READY
```

`T<n>` means that tactile activator number `n` has been touched.

### Player → board

```text
Z
SET:6500
PING
```

| Command | Meaning |
| --- | --- |
| `Z` | Reset the currently active tactile track |
| `SET:<value>` | Change and persist the touch threshold |
| `PING` | Test the connection; the board replies with `PONG` |

This keeps the firmware independent from the content itself: the board reports tactile events, while the player decides which audio or multimedia content is associated with each activator.

## Default player: Hi-Storia Go

The reference player for current Hi-Storia tactile devices is **[Hi-Storia Go](https://github.com/hi-Storia/Hi-Storia-Go)**, an open-source Android application.

Hi-Storia Go turns an Android smartphone into the player for a tactile model. It receives events such as `T1`, `T2` and `T3` from the board and associates them with the corresponding audio tracks.

The app is designed to make projects configurable directly from the phone and to support the reuse of older Android smartphones as dedicated players.

Hi-Storia Go is currently under active development and its public repository should be considered an **alpha release**.

## Repository layout

```text
Firmware/
├── Arduino/
│   ├── historia_arduino_uno_r4/
│   │   └── historia_arduino_uno_r4.ino
│   ├── historia_arduino_uno_r3/
│   │   └── historia_arduino_uno_r3.ino
│   └── historia_arduino_micro/
│       └── historia_arduino_micro.ino
│
├── ESP32/
│   └── historia_esp32/
│       └── historia_esp32.ino
│
└── Microbit/
    └── ...
```

Some legacy material may still use older directory or sketch names. These files document previous generations of Hi-Storia hardware.

## About Hi-Storia

Hi-Storia is an educational and cultural heritage project in which students and teachers research local heritage and build interactive tactile devices through 3D modelling and printing, electronics, coding, writing and audio production.

The tactile models are designed for shared use and include interaction modes intended to improve access for blind and partially sighted visitors.

More information:

- [Hi-Storia](https://www.hi-storia.it/)
- [Tactile audio guides](https://www.hi-storia.it/audioguida-tattile/)
- [Hardware](https://www.hi-storia.it/audioguida-tattile/hardware/)
- [Hi-Storia Go](https://github.com/hi-Storia/Hi-Storia-Go)

## License

The firmware in this repository is released under the **GNU General Public License v2.0 (GPL-2.0)**. See [LICENSE](LICENSE).
