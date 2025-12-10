#include "FolderManager.h"
#include "FolderWork.h"

FolderManager::FolderManager(QObject *parent) : QObject(parent)
{
    m_folderWork = new FolderWork();

    m_folderWork->moveToThread(&m_thread);

    connect(this, &FolderManager::operate, m_folderWork, &FolderWork::process);

    connect(this, &FolderManager::requestAbort, m_folderWork, &FolderWork::abort, Qt::DirectConnection);

    connect(m_folderWork, &FolderWork::finished, this, &FolderManager::filesReady);
    connect(m_folderWork, &FolderWork::canceled, this, &FolderManager::loadCanceled);

    m_thread.start();
}

FolderManager::~FolderManager()
{
    // Dọn dẹp an toàn khi tắt app
    emit requestAbort(); // Báo dừng nếu đang chạy dở
    m_thread.quit();     // Ra lệnh thoát Event Loop
    m_thread.wait();     // Đợi luồng thoát hẳn
    delete m_folderWork;     // Xóa worker
}

void FolderManager::loadFiles(const QString &path)
{
    // Bắn tín hiệu đánh thức luồng
    emit operate(path);
}

void FolderManager::cancelLoad()
{
    // Bắn tín hiệu hủy
    emit requestAbort();
}
