SRC_URI:edgeai = "repo://git.ti.com/git/processor-sdk/psdk_repo_manifests.git;protocol=https;branch=refs/tags/REL.PSDK.ANALYTICS.11.02.02.07;manifest=vision_apps_yocto.xml"

python do_fetch:prepend() {
    import os
    native_bin = d.getVar("STAGING_BINDIR_NATIVE")
    os.makedirs(native_bin, exist_ok=True)
    ssh_path = os.path.join(native_bin, "ssh")
    if os.path.lexists(ssh_path):
        os.remove(ssh_path)
    with open(ssh_path, "w") as f:
        f.write('#!/bin/sh\necho "OpenSSH_9.0p1" >&2\nexit 0\n')
    os.chmod(ssh_path, 0o755)
}

DEPENDS:append = " nlohmann-json stb ti-img-rogue-umlibs"
CXXFLAGS:append = " -I${WORKDIR}/repo/vision_apps/kernels/srv/gpu/3dsrv/Tools/OGLES2 -I${WORKDIR}/repo/vision_apps/kernels/srv/gpu/3dsrv/Tools"

do_compile:prepend() {
    sed -i 's|IDIRS       += $(3DSRV_ROOT)|IDIRS       += $(3DSRV_ROOT) $(3DSRV_ROOT)/Tools/OGLES2 $(3DSRV_ROOT)/Tools|' ${WORKDIR}/repo/vision_apps/kernels/srv/gpu/3dsrv/concerto.mak
}

