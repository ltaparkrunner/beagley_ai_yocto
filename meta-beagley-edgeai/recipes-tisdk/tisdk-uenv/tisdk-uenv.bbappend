FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:beagley-ai = "file://uEnv-sk.txt"

do_deploy:beagley-ai() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${S}/uEnv-sk.txt ${DEPLOYDIR}/uEnv.txt
}
