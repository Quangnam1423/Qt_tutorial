#ifndef MAINVIEWMODEL_H
#define MAINVIEWMODEL_H

#include <QObject>
#include <QDebug>

class FolderManager;

class MainViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString statusText READ statusText NOTIFY statusTextChanged)
    Q_PROPERTY(QString dashboardTitle READ dashboardTitle NOTIFY dashboardTitleChanged)
public:
    explicit MainViewModel(QObject *parent = nullptr);

    // getter
    QString statusText() const { return m_statusText; }
    QString dashboardTitle() const { return m_dashboardTitle; }

    Q_INVOKABLE void openFolder(const QString &path);
    Q_INVOKABLE void startProcessing();
signals:
    void statusTextChanged();
    void dashboardTitleChanged();

private slots:
    void onManagerFinished();
    void onManagerCanceled();

private:
    QString m_statusText;
    QString m_dashboardTitle;
    FolderManager* m_manager;

private:
    void setStatusText(const QString &text);
};

#endif // MAINVIEWMODEL_H
