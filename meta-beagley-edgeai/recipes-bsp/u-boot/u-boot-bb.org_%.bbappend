FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://k3-am67a-beagley-ai-edgeai.dtsi"

do_configure:append() {
    DTS_FILE="${S}/dts/upstream/src/arm64/ti/k3-am67a-beagley-ai.dts"
    if [ -f "${DTS_FILE}" ] && ! grep -q "k3-am67a-beagley-ai-edgeai.dtsi" "${DTS_FILE}"; then
        cp "${WORKDIR}/k3-am67a-beagley-ai-edgeai.dtsi" "${S}/dts/upstream/src/arm64/ti/"
        echo '#include "k3-am67a-beagley-ai-edgeai.dtsi"' >> "${DTS_FILE}"
    fi
}
