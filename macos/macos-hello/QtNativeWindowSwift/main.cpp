#include <QtWidgets/QtWidgets>
#include "SwiftModule/WindowDelegate-swift.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    
    // QTimer::singleShot(200, []() {
        
    //     MacWindow *macWindow = new MacWindow(contetWindow, leftAccessoryWindow);
    //     macWindow->setContentWindow(contetWindow);
    //     macWindow->setLeftAcccessoryWindow(leftAccessoryWindow);
    //     macWindow->setRightAcccessoryWindow(rigthAccessoryWindow);           
    
    //     macWindow->show();
    //     contetWindow -> show();
    // });

    SwiftModule::sayHello();

    //auto controller = new MainWindowController();
    return app.exec();
}