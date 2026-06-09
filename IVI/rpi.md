# Deploying the IVI Qt6 App to Raspberry Pi 3B+ via Yocto

---

## Overview

Your app uses the following Qt/system features that all need matching Yocto packages:

| Feature | Requires |
|---|---|
| QML + Qt Quick | `qtdeclarative`, `qtdeclarative-qmlplugins` ✅ already have |
| `QtMultimedia` (Video, Audio, MediaPlayer) | `qtmultimedia`, `qtmultimedia-plugins`, `qtmultimedia-qmlplugins` |
| `QtQuickControls2` (Slider, etc.) | `qtquickcontrols2` |
| Audio playback / mic input | GStreamer + ALSA + PulseAudio |
| Vosk speech recognition | `libvosk.so` + model folder on device |
| D-Bus (Bluetooth HW, WiFi via NetworkManager) | `dbus` |
| Network (WeatherAPI, RadioAPI) | `qtbase` network stack (already included in qtbase) |
| Display (framebuffer, no X11) | EGLFS or LinuxFB platform plugin |

---

## Step 1 — `local.conf` additions

Add all of the following to your `build/conf/local.conf`:

```bitbake
# ── Machine ────────────────────────────────────────────────────────────────────
MACHINE = "raspberrypi3"

# ── Display: no X11, use EGLFS (OpenGL ES via KMS/DRM) ────────────────────────
DISTRO_FEATURES:remove = " x11 wayland vulkan directfb "
DISTRO_FEATURES:append = " opengl eglfs alsa gles2 dbus systemd pulseaudio "

# ── Qt platform plugin config ──────────────────────────────────────────────────
PACKAGECONFIG:append:pn-qtbase = " eglfs kms fontconfig gles2 "

# ── QtMultimedia backend: GStreamer + ALSA + PulseAudio ────────────────────────
PACKAGECONFIG:append:pn-qtmultimedia = " gstreamer alsa pulseaudio "
PACKAGECONFIG:append:pn-pulseaudio   = " systemd "

# ── Accept GStreamer ugly plugins license (needed for MP3, some codecs) ────────
LICENSE_FLAGS_ACCEPTED += " commercial_gstreamer1.0-plugins-ugly "

# ── Packages to install ────────────────────────────────────────────────────────
IMAGE_INSTALL:append = " \
    python3 tcpdump sudo custom-connectivity static-eth nano \
    qtbase qtbase-plugins qtbase-tools \
    qtdeclarative qtdeclarative-qmlplugins qtdeclarative-tools \
    qtmultimedia qtmultimedia-plugins qtmultimedia-qmlplugins \
    qtquickcontrols2 qtquickcontrols2-qmlplugins \
    qtimageformats-plugins \
    qtsvg qtsvg-plugins \
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    alsa-lib alsa-utils alsa-plugins alsa-state \
    pulseaudio pulseaudio-server pulseaudio-misc \
    pulseaudio-module-dbus-protocol \
    pulseaudio-module-bluetooth-discover \
    pulseaudio-module-bluetooth-policy \
    pulseaudio-module-bluez5-device \
    pulseaudio-module-bluez5-discover \
    dbus \
    bluez5 \
    networkmanager \
    liberation-fonts \
    ivi-app \
"

# ── Fonts ──────────────────────────────────────────────────────────────────────
PACKAGECONFIG_FONTS:append:pn-qtbase = " fontconfig "

# ── SSH for remote deployment/debugging ───────────────────────────────────────
IMAGE_INSTALL:append = " openssh-sftp-server rsync "

# ── HDMI output (set to your monitor's mode) ──────────────────────────────────
# Check your monitor with: tvservice -m CEA / tvservice -m DMT on Raspbian
ENABLE_UART = "1"
# Uncomment and adjust if display doesn't appear:
# HDMI_FORCE_HOTPLUG = "1"
# HDMI_GROUP = "2"
# HDMI_MODE  = "82"
```

---

## Step 2 — Create a Yocto recipe for your app

In your custom layer (e.g. `meta-ivi`), create:

```
meta-ivi/
└── recipes-ivi/
    └── ivi-app/
        └── ivi-app_1.0.bb
```

**`ivi-app_1.0.bb`:**

```bitbake
SUMMARY = "IVI Dashboard Qt6 Application"
LICENSE = "CLOSED"

# Fetch from your local source directory (adjust path)
SRC_URI = "file://${THISDIR}/files/"

S = "${WORKDIR}/files"

# Build-time Qt dependencies
DEPENDS = " \
    qtbase \
    qtdeclarative \
    qtmultimedia \
    qtquickcontrols2 \
    vosk \
"

# Runtime dependencies (libs that must be on the device)
RDEPENDS:${PN} = " \
    qtbase \
    qtdeclarative \
    qtdeclarative-qmlplugins \
    qtmultimedia \
    qtmultimedia-plugins \
    qtmultimedia-qmlplugins \
    qtquickcontrols2 \
    qtquickcontrols2-qmlplugins \
    gstreamer1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-base \
    alsa-lib \
    pulseaudio-server \
    dbus \
"

inherit qt6-cmake

# Install the Vosk model alongside the binary
do_install:append() {
    install -d ${D}/opt/ivi/
    cp -r ${THISDIR}/files/assets/models/vosk ${D}/opt/ivi/vosk-model
}

FILES:${PN} += " \
    /opt/ivi/vosk-model \
"
```

Then copy your entire IVI source into `meta-ivi/recipes-ivi/ivi-app/files/`.

> **Tip:** For a cleaner setup, point `SRC_URI` to your git repo with a pinned `SRCREV` instead of copying files.

---

## Step 3 — Write a Vosk recipe

Vosk doesn't have an official meta-qt6 recipe, so you need to write one that ships the prebuilt ARM library. Create:

```
meta-ivi/recipes-support/vosk/vosk_0.3.45.bb
```

```bitbake
SUMMARY = "Vosk offline speech recognition library"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=somemd5"

# Download the prebuilt ARM32 library (matches RPi3 32-bit)
SRC_URI = "https://github.com/alphacep/vosk-api/releases/download/v0.3.45/vosk-linux-armv7l-0.3.45.zip"
SRC_URI[sha256sum] = "<run: sha256sum vosk-linux-armv7l-0.3.45.zip>"

S = "${WORKDIR}/vosk-linux-armv7l-0.3.45"

do_install() {
    install -d ${D}${libdir}
    install -d ${D}${includedir}
    install -m 0755 ${S}/libvosk.so ${D}${libdir}/libvosk.so
    install -m 0644 ${S}/vosk_api.h  ${D}${includedir}/vosk_api.h
}

FILES:${PN}     = "${libdir}/libvosk.so"
FILES:${PN}-dev = "${includedir}/vosk_api.h"
```

> **Note:** If your Yocto image is 64-bit (aarch64), use `vosk-linux-aarch64-0.3.45.zip` instead.
> Check your image arch with: `DEFAULTTUNE` in `local.conf` or the machine config.

---

## Step 4 — Update the model path in `SpeechManager.cpp`

Since the recipe installs the model to `/opt/ivi/vosk-model`, update:

```cpp
m_model = vosk_model_new("/opt/ivi/vosk-model");
```

---

## Step 5 — `config.txt` on the RPi (display & audio)

After flashing, mount the boot partition and edit `config.txt`:

```ini
# Force HDMI on with audio
hdmi_force_hotplug=1
hdmi_drive=2

# Audio via 3.5mm jack (0 = auto, 1 = headphones, 2 = HDMI)
dtparam=audio=on
audio_pwm_mode=2

# GPU memory (QML needs at least 128MB)
gpu_mem=128

# Disable overscan if display has black borders
disable_overscan=1
```

---

## Step 6 — Launch script on the device

Create `/etc/init.d/ivi-app` or a systemd service. For a quick test, SSH in and run:

```bash
# Start D-Bus session (needed for Bluetooth/WiFi managers)
export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch --sh-syntax | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)

# Start PulseAudio (needed for mic input and audio output)
pulseaudio --start --disallow-exit --disallow-module-loading=false

# Run on framebuffer (no X11)
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_ALWAYS_SET_MODE=1

/usr/bin/ivi-app
```

For a **systemd service** that auto-starts on boot, create `/etc/systemd/system/ivi-app.service`:

```ini
[Unit]
Description=IVI Dashboard
After=network.target dbus.service sound.target
Wants=dbus.service

[Service]
Type=simple
User=root
Environment="QT_QPA_PLATFORM=eglfs"
Environment="QT_QPA_EGLFS_ALWAYS_SET_MODE=1"
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket"
ExecStartPre=/usr/bin/pulseaudio --start
ExecStart=/usr/bin/ivi-app
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
```

Enable it in your recipe's `do_install`:
```bitbake
do_install:append() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${THISDIR}/files/ivi-app.service ${D}${systemd_unitdir}/system/
}

inherit systemd
SYSTEMD_SERVICE:${PN} = "ivi-app.service"
SYSTEMD_AUTO_ENABLE = "enable"
```

---

## Step 7 — Build and flash

```bash
# Source your build environment
source poky/oe-init-build-env build-rpi

# Build the full image
bitbake your-image-name

# Flash to SD card (adjust /dev/sdX)
sudo dd if=tmp/deploy/images/raspberrypi3/your-image-name-raspberrypi3.rpi-sdimg \
        of=/dev/sdX bs=4M status=progress conv=fsync
```

---

## Summary of what you need vs. what you have

| Package | Status | Notes |
|---|---|---|
| `qtbase`, `qtbase-plugins` | ✅ Have | Already in your image |
| `qtdeclarative`, `qtdeclarative-qmlplugins` | ✅ Have | Already in your image |
| `qtmultimedia` + plugins | ❌ Missing | Add to `IMAGE_INSTALL` |
| `qtquickcontrols2` | ❌ Missing | Needed for `Slider`, `StackView`, etc. |
| `gstreamer1.0` + plugins | ❌ Missing | Qt Multimedia backend on Linux |
| `alsa-lib`, `alsa-utils` | ❌ Missing | Audio hardware access |
| `pulseaudio` + modules | ❌ Missing | Mic input + Bluetooth audio |
| `dbus` | ❌ Missing | Required by Bluetooth/WiFi managers |
| `bluez5` | ❌ Missing | Bluetooth hardware |
| `networkmanager` | ❌ Missing | WiFi (your WifiManager uses D-Bus NM) |
| `vosk` (libvosk.so) | ❌ Missing | Write the recipe in Step 3 |
| Vosk model folder | ❌ Missing | Ship with app recipe, mount at `/opt/ivi/vosk-model` |
| `liberation-fonts` | ❌ Missing | Font rendering in QML |
| `eglfs` plugin in qtbase | ❌ Missing | Framebuffer display without X11 |