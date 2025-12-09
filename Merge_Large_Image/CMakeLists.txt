cmake_minimum_required(VERSION 3.16)

project(Merge_Large_Image VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appMerge_Large_Image
    main.cpp
)

# qt_add_qml_module(appMerge_Large_Image
#     URI Merge_Large_Image
#     QML_FILES

#     SOURCES
#         QML_FILES Resources/Main.qml
#         SOURCES mainviewmodel.h mainviewmodel.cpp
#         QML_FILES Resources/AboutDialog.qml
#         Assets/logo.jpg
#         RESOURCES Resources/Assets/logo.jpg
# )

qt_add_qml_module(appMerge_Large_Image
    URI "Merge_Large_Image"
    VERSION 1.0

    # 1. Các file C++ (Logic) - Đặt riêng trong SOURCES
    SOURCES
        mainviewmodel.h
        mainviewmodel.cpp

    # 2. Các file giao diện .qml - Đặt riêng trong QML_FILES
    QML_FILES
        Resources/Main.qml
        Resources/AboutDialog.qml

    # 3. Các file tài nguyên (Ảnh) - Đặt riêng trong RESOURCES
    RESOURCES
        Resources/Assets/logo.jpg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMerge_Large_Image PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMerge_Large_Image
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMerge_Large_Image
    PRIVATE Qt6::Quick
)
target_link_libraries(appMerge_Large_Image PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appMerge_Large_Image
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
