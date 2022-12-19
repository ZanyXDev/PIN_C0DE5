TEMPLATE = app
TARGET = tst_pin_button
CONFIG += qmltestcase

SOURCES += \
    $$PWD/tst_pin_button.cpp

RESOURCES += \
	../../../shared/quick_shared.qrc

OTHER_FILES += \
    $$PWD/data/*.qml

TESTDATA += \
    $$PWD/data/tst_*
