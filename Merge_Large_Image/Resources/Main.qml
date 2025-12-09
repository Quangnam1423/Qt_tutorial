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

                        // Đường kẻ ngăn cách (Optional)
                        Rectangle {
                            width: 1; height: parent.height
                            color: "#3E3E42"
                            anchors.left: parent.left
                        }

                        // Cột chứa các Button điều khiển
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15

                            Label {
                                text: "Control Panel"
                                color: "white"
                                font.bold: true
                                font.pixelSize: 18
                                Layout.alignment: Qt.AlignHCenter
                            }

                            // Ví dụ các nút chức năng
                            Button {
                                text: "Load Image 1"
                                Layout.fillWidth: true
                                onClicked: console.log("Load 1")
                            }

                            Button {
                                text: "Load Image 2"
                                Layout.fillWidth: true
                                onClicked: console.log("Load 2")
                            }

                            Button {
                                text: "Settings"
                                Layout.fillWidth: true
                            }

                            // Spacer đẩy mọi thứ lên trên
                            Item { Layout.fillHeight: true }

                            // Nút to dưới cùng
                            Button {
                                text: "Start Merge"
                                Layout.fillWidth: false            // 1. Không chiếm hết dòng
                                Layout.preferredWidth: parent.width * 0.5 // 2. Rộng bằng 50% khung chứa
                                Layout.alignment: Qt.AlignHCenter  // 3. Căn giữa
                                Layout.preferredHeight: 50
                                highlighted: true
                                onClicked: mainVM.startProcessing()
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
