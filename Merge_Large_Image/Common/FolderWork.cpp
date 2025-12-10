#include "FolderWork.h"
#include <QUrl>
#include <QDirIterator>

FolderWork::FolderWork(QObject* parent) : QObject(parent)
{
    m_abort = false;
}

void FolderWork::abort()
{
    m_abort = true;
}

void FolderWork::process(const QString &folderPath)
{
    m_abort = false;
    QUrl url(folderPath);
    QString localPath = url.isLocalFile() ? url.toLocalFile() : folderPath;

    QStringList result;
    QStringList filters;
    filters << "*.png" << "*.jpg" << "*.jpeg" << "*.bmp" << "*.tif";

    QDirIterator it(localPath, filters, QDir::Files | QDir::NoDotAndDotDot);

    while (it.hasNext())
    {
        if (m_abort) {
            emit canceled();
            return; // Thoát ngay lập tức
        }
        it.next();
        result << it.fileName();
    }
    emit finished(result);
}
