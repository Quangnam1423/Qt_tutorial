#ifndef FOLDERWORK_H
#define FOLDERWORK_H

#include <QObject>
#include <QDir>

class FolderWork : public QObject
{
    Q_OBJECT
public:
    explicit FolderWork(QObject *parent = nullptr);
public slots:
    void abort();
    void process(const QString & folderPath);
private:
    std::atomic<bool> m_abort;
signals:
    void finished(const QStringList &files);
    void canceled();
};

#endif // FOLDERWORK_H
