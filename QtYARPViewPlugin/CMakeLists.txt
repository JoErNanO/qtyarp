project(QtYARPViewPlugin)

file(GLOB QtYARPViewPlugin_SRCS *.cpp)
file(GLOB QtYARPViewPlugin_HDRS *.h)
file(GLOB QtYARPViewPlugin_QRC_FILES *.qrc)

qt5_add_resources(QtYARPViewPlugin_QRC_GEN_SRCS ${QtYARPViewPlugin_QRC_FILES})

source_group("Source Files" FILES ${QtYARPViewPlugin_SRCS})
source_group("Header Files" FILES ${QtYARPViewPlugin_HDRS})
source_group("Resources Files" FILES ${QtYARPViewPlugin_QRC_FILES})
source_group("Generated Files" FILES ${QtYARPViewPlugin_QRC_GEN_SRCS})

set(QtYARPViewPlugin_QMLDIR "${CMAKE_INSTALL_LIBDIR}/qml/imports/robotology/yarp/view")
# file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${QtYARPViewPlugin_QMLDIR})

add_library(QtYARPViewPlugin MODULE ${QtYARPViewPlugin_SRCS} ${QtYARPViewPlugin_HDRS} ${QtYARPViewPlugin_QRC_GEN_SRCS} )
target_link_libraries(QtYARPViewPlugin YARP::YARP_OS YARP::YARP_init YARP::YARP_sig)
qt5_use_modules(QtYARPViewPlugin Widgets Qml Quick Multimedia)
set_target_properties(QtYARPViewPlugin PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${QtYARPViewPlugin_QMLDIR})
set_property(TARGET QtYARPViewPlugin APPEND PROPERTY COMPILE_DEFINITIONS QT_PLUGIN)
configure_file(qmldir ${CMAKE_BINARY_DIR}/${QtYARPViewPlugin_QMLDIR}/qmldir COPYONLY)

install(TARGETS QtYARPViewPlugin DESTINATION ${QtYARPViewPlugin_QMLDIR})
install(FILES qmldir DESTINATION ${QtYARPViewPlugin_QMLDIR})
