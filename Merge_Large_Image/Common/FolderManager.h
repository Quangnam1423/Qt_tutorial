#ifndef FOLDERMANAGER_H
#define FOLDERMANAGER_H

#include <QObject>
#include <QThread>

class FolderWork;

class FolderManager : public QObject
{
    Q_OBJECT
public:
    explicit FolderManager(QObject *parent = nullptr);
    ~FolderManager();
public:
    void loadFiles(const QString &path);
    void cancelLoad();
signals:
    void operate(const QString &path);
    void requestAbort();

    void filesReady(const QStringList &files);
    void loadCanceled();

private:
    QThread m_thread;
    FolderWork *m_folderWork;
};

#endif // FOLDERMANAGER_H
