import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 6.3

ApplicationWindow {
    id: mainWindow
    visible: true
    title: "Mitech Merge Image"
    visibility: Window.Maximized
    width: 1280
    height: 720
    color: "#1E1E1E"

    FolderDialog {
        id: folderDialog
        title: "Select Image Folder"
        onAccepted: mainVM.openFolder(selectedFolder)
    }

    AboutDialog {
        id: aboutDialog
    }

    // 2. Menu Bar (Thanh menu trên cùng: File, Edit...)
        menuBar: MenuBar {
            Menu {
                title: "File"
                MenuItem {
                    text: "Open Folder"
                    onTriggered: folderDialog.open()
                }
                MenuItem {
                    text: "Process (Test Logic)"
                    onTriggered: mainVM.startProcessing()
                }
                MenuItem {
                    text: "Exit"
                    onTriggered: Qt.quit()
                }
            }
            Menu {
                title: "Edit"
            }

            Menu {
                title: "View"
            }

            Menu {
                title: "Tools"
            }

            Menu {
                title: "Setting"
                MenuItem {
                    text: "Show Recipe"
                }

            }

            Menu {
                title: "Help"
                MenuItem {
                    text: "About"
                    onTriggered: aboutDialog.open()
                }
            }
        }

        // 3. Header (Toolbar chứa các nút nhanh)
        header: ToolBar {
            height: 60
            background: Rectangle {
                color: "#252526"
                border.color: "#3E3E42"
                border.width: 1
            }

            RowLayout {
                anchors.fill: parent
                spacing: 10
                anchors.leftMargin: 15

                Label {
                    text: mainVM.dashboardTitle
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                }
            }
        }

        // --- 3. CONTENT (Đã chia layout 2/3 và 1/3) ---
            Item {
                anchors.fill: parent // Item này nằm giữa Header và Footer

                RowLayout {
                    anchors.fill: parent
                    spacing: 0 // Không có khe hở giữa 2 vùng

                    // ==========================================
                    // VÙNG 1: LEFT CONTENT (Chiếm 2/3 màn hình)
                    // ==========================================
                    Rectangle {
                        color: "#1E1E1E" // Màu nền vùng nội dung

                        // Tỷ lệ 2/3
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 2

                        // --- Nội dung cũ của bạn đặt ở đây ---
                        BusyIndicator {
                            anchors.centerIn: parent
                            running: mainVM.statusText.includes("Processing")
                            visible: running
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "Image Viewer Area"
                            color: "white"
                            font.pixelSize: 24
                            visible: !mainVM.statusText.includes("Processing")
                        }
                        // -------------------------------------
                    }

                    // ==========================================
                    // VÙNG 2: RIGHT PANEL (Chiếm 1/3 màn hình)
                    // ==========================================
                    Rectangle {
                        color: "#252526"

                        // Tỷ lệ 1/3
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 1

                        // Đường kẻ ngăn cách bên trái
                        Rectangle {
                            width: 1; height: parent.height
                            color: "#3E3E42"
                            anchors.left: parent.left
                        }

                        // Cột chứa nội dung Control Panel
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15

                            // 1. Tiêu đề
                            Label {
                                text: "Control Panel"
                                color: "white"
                                font.bold: true
                                font.pixelSize: 18
                                Layout.alignment: Qt.AlignHCenter
                            }

                            // 2. Khung Settings (Nằm trên cùng)
                            GroupBox {
                                title: "Settings Parameter" // Tiêu đề khung
                                Layout.fillWidth: true

                                // Bạn có thể đặt chiều cao cố định hoặc để nó tự giãn theo nội dung
                                // Layout.preferredHeight: 300

                                background: Rectangle {
                                    color: "transparent"
                                    border.color: "#3E3E42"
                                    radius: 4
                                }

                                label: Label {
                                    x: 10
                                    y: -10
                                    width: implicitWidth
                                    text: parent.title
                                    font.bold: true
                                    color: "#007ACC" // Màu chữ tiêu đề khung
                                    background: Rectangle { color: "#252526" } // Màu nền đè lên đường viền
                                }

                                // Nội dung bên trong khung Settings
                                // ... (Phần code bên trên giữ nguyên)

                                // Cột chứa nội dung Control Panel
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 15

                                    // 1. Tiêu đề
                                    Label {
                                        text: "Control Panel"
                                        color: "white"
                                        font.bold: true
                                        font.pixelSize: 18
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    // 2. Khung Settings
                                    GroupBox {
                                        title: "Settings Parameter"
                                        Layout.fillWidth: true
                                        // KHÔNG set Layout.fillHeight ở đây

                                        // Style cho khung viền
                                        background: Rectangle {
                                            color: "transparent"
                                            border.color: "#3E3E42"
                                            radius: 4
                                        }

                                        // Style cho tiêu đề (đè lên đường viền)
                                        label: Label {
                                            x: 10
                                            y: -10 // Đẩy lên để nằm giữa đường viền
                                            width: implicitWidth
                                            text: parent.title
                                            font.bold: true
                                            color: "#007ACC"

                                            // Background trùng màu nền app để che đường viền đi qua chữ
                                            background: Rectangle {
                                                color: "#252526"
                                                anchors.fill: parent
                                                anchors.margins: -4 // Mở rộng vùng che một chút
                                            }
                                        }

                                        // Nội dung bên trong (QUAN TRỌNG: SỬA LẠI PHẦN NÀY)
                                        ColumnLayout {
                                            // ĐỪNG DÙNG anchors.fill: parent
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: parent.top // Chỉ neo bên trên
                                            anchors.margins: 10
                                            spacing: 10

                                            RowLayout {
                                                Label { text: "Threshold:"; color: "white" }
                                                TextField { Layout.fillWidth: true; placeholderText: "0-255"; color: "black"; background: Rectangle { color: "white" } }
                                            }
                                            RowLayout {
                                                Label { text: "Opacity:"; color: "white" }
                                                Slider { Layout.fillWidth: true; from: 0; to: 100; value: 50 }
                                            }
                                            CheckBox {
                                                text: "Enable Advanced Mode"
                                                checked: true
                                                contentItem: Text {
                                                    text: parent.text
                                                    color: "white"
                                                    leftPadding: parent.indicator.width + parent.spacing
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                            }
                                        }
                                    }

                                    // 3. SPACER: Đẩy nút xuống đáy
                                    Item {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }

                                    // 4. Khu vực 2 nút chức năng
                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 60
                                        Layout.fillHeight: false // QUAN TRỌNG: Không cho phép tự giãn chiều cao
                                        spacing: 15

                                        // Nút 1
                                        Button {
                                            text: "Auto Merge\nAll Slot"
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true // Fill theo chiều cao của RowLayout (60px)
                                            highlighted: true

                                            background: Rectangle {
                                                color: parent.down ? "#005A9E" : "#007ACC"
                                                radius: 4
                                            }
                                            contentItem: Text {
                                                text: parent.text
                                                color: "white"
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            onClicked: mainVM.startProcessing()
                                        }

                                        // Nút 2
                                        Button {
                                            text: "Merge\nOne Slot"
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            highlighted: true

                                            background: Rectangle {
                                                color: parent.down ? "#005A9E" : "#007ACC"
                                                radius: 4
                                            }
                                            contentItem: Text {
                                                text: parent.text
                                                color: "white"
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            onClicked: mainVM.mergeOneSlot()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // --- 4. FOOTER ---
            footer: Rectangle {
                height: 30
                color: "#007ACC"

                Text {
                    anchors.centerIn: parent

                    // BINDING: Tự cập nhật trạng thái từ C++
                    text: mainVM.statusText

                    color: "white"
                    font.pixelSize: 12
                }
            }
}
