# Mobile_dev

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

🔗 ESP32 & Flutter QR Code Storage System
This project connects an ESP32 microcontroller to a Flutter mobile app via USB-C, enabling users to scan a QR code, send its contents to the ESP32, and store it in EEPROM memory. Upon request, the stored message can be retrieved and displayed on the app — even after the ESP32 restarts.

- Features
QR Code Scanning on the mobile app
USB Serial Communication between Flutter and ESP32
EEPROM storage on ESP32 for persistent message saving
Message retrieval via command-based protocol (GET)
Autostart behavior: ESP initializes and awaits commands from the app

U need ESP32-WROOM-32D microcontroller.

- How It Works:
The user scans a QR code using the Flutter app.
The decoded text is sent to the ESP32 via USB.
ESP32 saves this text to EEPROM.
When the user reopens the app or requests the message, it sends a "GET" command.
ESP32 responds with the saved message, which is shown in the app.
