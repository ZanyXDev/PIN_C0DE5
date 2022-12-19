#include <QtQuickTest>
#include <QQmlEngine>
#include <QQmlContext>

class Setup : public QObject
{
    Q_OBJECT

public:
    Setup() {}

public slots:
    //    void applicationAvailable() {}
    void qmlEngineAvailable(QQmlEngine *engine)
    {
        engine->rootContext()->setContextProperty("myContextProperty", QVariant(true));
        engine->addImportPath("qrc:///");
        engine->addImportPath("qrc:/Common/");
    }
    //    void cleanupTestCase() {}
};

QUICK_TEST_MAIN_WITH_SETUP(tst_pin_button, Setup)

#include "tst_pin_button.moc"
