import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id: aboutDialog
    title: "About Mitech Merge Image"

    // Căn giữa màn hình cha
    anchors.centerIn: parent

    // Modal = true: Bắt buộc người dùng đóng dialog này mới thao tác được cái khác (làm tối nền sau)
    modal: true
    focus: true

    // Kích thước cố định
    width: 500
    height: 400


    background: Rectangle {
        color: "#252526"
        border.color: "#3E3E42"
        radius: 8
    }

    // Tùy chỉnh Header (Tiêu đề)
    header: Label {
        text: aboutDialog.title
        color: "white"
        font.bold: true
        font.pixelSize: 18
        padding: 15
        background: Rectangle { color: "transparent" } // Trong suốt để hiện màu nền gốc
    }

    // Nội dung chính
    contentItem: ColumnLayout {
        spacing: 15

        // 1. Logo (Dùng text icon tạm hoặc thay bằng Image sau này)
        Image {
            id: appLogo

            // 1. Đường dẫn ảnh (Qt 6 tự hiểu đường dẫn tương đối trong Module)
            source: "Assets/logo.jpg"

            // 2. Kích thước hiển thị
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100

            // 3. Chế độ co giãn (Giữ nguyên tỷ lệ, không bị méo)
            fillMode: Image.PreserveAspectFit

            // 4. Căn giữa
            Layout.alignment: Qt.AlignHCenter

            // (Tùy chọn) Tối ưu bộ nhớ: Chỉ load ảnh ở độ phân giải này
            sourceSize.width: 100
            sourceSize.height: 100
        }

        // 2. Tên App & Version
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 5

            Text {
                text: "Mitech Merge Image Pro"
                color: "white"
                font.bold: true
                font.pixelSize: 16
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: "Version 1.0.0 (Beta)"
                color: "#CCCCCC"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // 3. Mô tả
        Text {
            text: "Ứng dụng ghép ảnh chuyên nghiệp sử dụng công nghệ Qt 6 và C++ hiệu năng cao.\n\nDeveloped by Quang Nam."
            color: "#DDDDDD"
            wrapMode: Text.WordWrap // Tự xuống dòng nếu dài quá
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.margins: 10
        }
    }

    // Footer chứa nút Close
    footer: DialogButtonBox {
        alignment: Qt.AlignHCenter
        background: Rectangle { color: "transparent" } // Trong suốt

        Button {
            text: "Close"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole // Role đóng dialog

            // Style nút bấm cho hợp tông
            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                color: parent.down ? "#005A9E" : "#007ACC"
                radius: 4
            }
            // Logic đóng: Dialog tự đóng khi bấm nút RejectRole, không cần viết onClicked
        }
    }
}
