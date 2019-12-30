
#ifndef __SYMBOID_CSILLAGVARTA_APP_MAINWINDOW_H__
#define __SYMBOID_CSILLAGVARTA_APP_MAINWINDOW_H__

#include "csillagvarta/app/defs.h"
#include <QMainWindow>
#include "sdk/arch/mainobject.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    MAIN_OBJECT(MainWindow, MainWindow)

public:
    explicit MainWindow(QWidget *parent = Q_NULLPTR);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
};

#endif // __SYMBOID_CSILLAGVARTA_APP_MAINWINDOW_H__
