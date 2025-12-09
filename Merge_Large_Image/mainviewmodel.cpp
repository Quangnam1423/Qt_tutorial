#include "mainviewmodel.h"
#include <QTime>
#include <QTimer>

MainViewModel::MainViewModel(QObject *parent)
    : QObject{parent}
{

}

void MainViewModel::openFolder(const QString &path)
{
    // path nhận từ QML sẽ có dạng "file:///C:/Users/...", cần xử lý sạch
    QString localPath = path;
    if (localPath.startsWith("file://")) {
#ifdef Q_OS_WIN
        localPath.remove(0, 8); // Windows bỏ file:///
#else
        localPath.remove(0, 7); // Linux/Mac bỏ file://
#endif
    }

    qDebug() << "C++ received path:" << localPath;
    setStatusText("Selected folder: " + localPath);
    m_dashboardTitle = "Working on: " + localPath; // Cập nhật cả tiêu đề
    emit dashboardTitleChanged();
}

void MainViewModel::startProcessing()
{
    setStatusText("Processing images... Please wait.");

    // Giả lập delay 2 giây rồi báo xong
    QTimer::singleShot(2000, this, [=]() {
        setStatusText("✅ Process Completed Successfully!");
    });
}

void MainViewModel::setStatusText(const QString &text)
{
    if (m_statusText != text) {
        m_statusText = text;
        emit statusTextChanged();
    }
}


