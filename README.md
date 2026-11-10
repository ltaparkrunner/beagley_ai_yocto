# Beagley-AI Yocto Project

**Yocto Project-based build system using the `kas` Docker container for the BeagleBoard Beagley-AI single-board computer.**

This repository uses the `kas` setup tool to orchestrate the build process. It automatically fetches the required metadata layers (`poky`, `meta-arm`, `meta-ti`, etc.) based on the configuration provided in `kas-beagley-ai.yml` and spins up an isolated Docker container to ensure reproducible builds.

---

## 🚀 Getting Started

### Prerequisites
Before you begin, ensure you have the following installed on your host machine:
* **Docker** (configured to run without `sudo` is highly recommended)
* **git** (to clone this repository)

---

## 🛠️ Building the Image

To build the image inside an isolated `kas` Docker container, follow these steps:

1. **Clone the repository** (if you haven't already):
   ```bash
   git clone https://github.com/ltaparkrunner/beagley_ai_yocto.git
   cd beagley_ai_yocto
   ```

2. **Run the build inside the Kas Docker container:**
   Execute the following command in the root of the project directory. This will mount your current workspace, forward your user permissions, set up a global cache folder in your home directory, and trigger BitBake via Kas:
   ```bash
   # Create the cache directory first to avoid root-permission issues
   mkdir -p \$HOME/.kas-cache

   # Start the build container
   docker run --rm -it \
     --user (id -u):(id -g) \
     --workdir=/workspace \
     -v \$(pwd):/workspace \
     -v \$HOME/.kas-cache:/work/cache \
     ghcr.io/siemens/kas/kas:5.3 \
     build kas-beagley-ai.yml
   ```

The initial build will take some time as it downloads all sources, state caches, and compiles the toolchain. Once completed, your deployment artifacts will be located in the `build/deploy-ti/images/beagley-ai/` directory.

---

## 💾 Flashing the Image to an SD Card

Once the build is successful, you can write the compressed image file to your target media.

### Step 1: Identify your SD Card
Plug your SD card into your host machine and find its device name:
```bash
lsblk
```
*⚠️ **Warning:** Be extremely careful to identify the correct device (e.g., `/dev/sdX` or `/dev/mmcblk0`). Selecting the wrong drive can overwrite your host operating system.*

### Step 2: Write the image
Navigate to the image directory and flash the pointer-link to the latest image using `dd`. Replace `/dev/sdX` with your actual SD card device identifier:

```bash
# Navigate to the deploy folder
cd build/deploy-ti/images/beagley-ai/

# Flash the image directly while decompressing
xz -dc core-image-minimal-beagley-ai.rootfs.wic.xz | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
```

---

## 📁 Repository Structure

* `kas-beagley-ai.yml` — Main Kas configuration file containing layer revisions and BitBake targets.
* `README.md` — This documentation file.
* `.gitignore` — Pre-configured to track only development configurations while ignoring heavy build artifacts and external layers.

