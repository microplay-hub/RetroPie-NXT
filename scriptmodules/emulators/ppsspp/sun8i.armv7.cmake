include_directories(SYSTEM
  /usr/local/include
  /usr/include
)

set(ARCH_FLAGS "-O2 -marm -march=armv7-a -mfpu=neon-vfpv4 -mtune=cortex-a7 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARCH_FLAGS}"  CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)

set(USING_FBDEV ON)
set(USING_GLES2 ON)
set(USING_EGL=OFF)
set(USING_DARM=ON)
set(USE_WAYLAND_WSI OFF)
set(USING_X11_VULKAN= OFF)
set(MOBILE_DEVICE=OFF)
set(HEADLESS=ON)
set(USING_QT_UI=OFF)
set(SIMULATOR=OFF)
set(UNITTEST=OFF)
set(APPLE=OFF)
set(WIN32=OFF)
set(ANDROID=OFF)
set(USE_DISCORD=OFF)
set(USE_SYSTEM_FFMPEG=OFF)
set(VULKAN=OFF)
set(USE_FFMPEG=ON)
