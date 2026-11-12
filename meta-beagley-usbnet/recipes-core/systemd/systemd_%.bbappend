# Явно указываем BitBake искать файлы в папке "systemd-networkd" вместо стандартной "systemd"
FILESEXTRAPATHS:prepend := "${THISDIR}/systemd-networkd:"

SRC_URI += "file://20-usb0.network"

do_install:append() {
    # Устанавливаем файл конфигурации сети usb0
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/20-usb0.network ${D}${sysconfdir}/systemd/network/
}

