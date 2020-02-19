cmake_minimum_required(VERSION 3.5)

project(msTest LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick WebSockets REQUIRED)

add_executable(msTest
  main.cpp
  qml.qrc
  backend.h
  backend.cpp

  qdevicewatcher/src/qdevicewatcher.h
  qdevicewatcher/src/qdevicewatcher_p.h
  qdevicewatcher/src/qdevicewatcher.cpp
  qdevicewatcher/src/qdevicewatcher_linux.cpp

  usbwatcher.cpp
  usbwatcher.h
)

target_compile_definitions(msTest
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(msTest
  PRIVATE Qt5::Core Qt5::Quick Qt5::WebSockets)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING 1)

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION /usr/bin)

include_directories(${CMAKE_SOURCE_DIR}/qdevicewatcher)
link_directories(${CMAKE_SOURCE_DIR}/qdevicewatcher)

#add_executable(qdevicewatcher ${FOO_SRCS})
#target_link_libraries(qdevicewatcher ) # libbar.so is found in ${CMAKE_SOURCE_DIR}/lib
