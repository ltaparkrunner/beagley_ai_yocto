FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://k3-am67a-beagley-ai-edgeai.dtsi"

do_configure:append() {
    DTS_FILE="${S}/arch/${ARCH}/boot/dts/ti/k3-am67a-beagley-ai.dts"
    if [ -f "${DTS_FILE}" ] && ! grep -q "k3-am67a-beagley-ai-edgeai.dtsi" "${DTS_FILE}"; then
        cp "${WORKDIR}/k3-am67a-beagley-ai-edgeai.dtsi" "${S}/arch/${ARCH}/boot/dts/ti/"
        echo '#include "k3-am67a-beagley-ai-edgeai.dtsi"' >> "${DTS_FILE}"
    fi
}
