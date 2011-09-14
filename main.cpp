#include <QtGui/QApplication>
#include <QtDeclarative>
//#include <QSplashScreen>
//#include <QPixmap>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QDeclarativeView view;

    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.showFullScreen();



    return app.exec();
}
