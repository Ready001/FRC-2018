#!/bin/sh

# Update the system
sudo apt update -y
sudo apt upgrade -y

# Start jetson_clocks
sudo ~/jetson_clocks.sh

# Install opencv
cd $HOME
sudo apt-get install -y \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng12-dev \
    libjasper-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libeigen3-dev \
    libtbb-dev \
    libgtk2.0-dev \
    cmake \
    pkg-config

# Python 2.7
sudo apt-get install -y python-dev python-numpy python-py python-pytest
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 


git clone https://github.com/opencv/opencv.git
cd opencv
git checkout -b v3.3.0 3.3.0
# This is for the test data
cd $HOME
git clone https://github.com/opencv/opencv_extra.git
cd opencv_extra
git checkout -b v3.3.0 3.3.0

cd $HOME
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout -b v3.3.0 3.3.0


cd $HOME/opencv
mkdir build
cd build
# Jetson TX1 
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_PNG=OFF \
    -DBUILD_TIFF=OFF \
    -DBUILD_TBB=OFF \
    -DBUILD_JPEG=OFF \
    -DBUILD_JASPER=OFF \
    -DBUILD_ZLIB=OFF \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_python2=ON \
    -DBUILD_opencv_python3=OFF \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENMP=OFF \
    -DWITH_FFMPEG=ON \
    -DWITH_GSTREAMER=ON \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_CUDA=ON \
    -DWITH_GTK=ON \
    -DWITH_VTK=OFF \
    -DWITH_TBB=ON \
    -DWITH_1394=OFF \
    -DWITH_OPENEXR=OFF \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
    -DCUDA_ARCH_BIN=5.3 \
    -DCUDA_ARCH_PTX="" \
    -DINSTALL_C_EXAMPLES=ON \
    -DINSTALL_TESTS=ON \
    -DOPENCV_TEST_DATA_PATH=../opencv_extra/testdata \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    ../

make -j4

cd ~/opencv/build
make
sudo make install

# Install realsense
cd $HOME
git clone https://github.com/jetsonhacks/installLibrealsenseTX1.git
cd installLibrealsenseTX1
./installLibrealsense.sh

# install pip and pyrealsense
cd $HOME
sudo apt install -y python-pip
sudo -H pip install --upgrade pip
sudo -H pip install pycparser numpy cython pyyaml
sudo -H pip install pyrealsense

# install pynetworktables
sudo -H pip install pynetworktables

sudo -H pip install ipython

# Install GStreamer
sudo apt-get install gstreamer1.0-tools gstreamer1.0-alsa \
  gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-libav v4l-utils -y
