import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2

import Common 1.0

QQC2.ApplicationWindow {
    id: appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation
    readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
    readonly property real winScale: Math.min(width / 1280.0, height / 720.0)
    property bool appInitialized: false
    // ----- Signal declarations
    signal screenOrientationUpdated(int screenOrientation)

    // ----- Size information
    width: 320 * DevicePixelRatio
    height: 480 * DevicePixelRatio
    // ----- Then comes the other properties. There's no predefined order to these.
    visible: true
    visibility: (isMobile) ? Window.FullScreen : Window.Windowed
    flags: Qt.Dialog
    title: qsTr(" ")
    Screen.orientationUpdateMask: Qt.PortraitOrientation | Qt.LandscapeOrientation
                                  | Qt.InvertedPortraitOrientation | Qt.InvertedLandscapeOrientation

    // ----- Then attached properties and attached signal handlers.

    // ----- Signal handlers
    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation)
    }
    onClosing: {

    } //appCore.uninitialize()
    onAppInForegroundChanged: {
        if (appInForeground) {
            if (!appInitialized) {
                appInitialized = true
            }
        } else {
            if (isDebugMode)
                console.log("onAppInForegroundChanged-> [appInForeground:"
                            + appInForeground + ", appInitialized:" + appInitialized + "]")
        }
    }

    background: Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // ----- Visual children
    PinButton {
        id: testButton
        width: 64
        height: 64
        numpadKey: 5
    }
    // ----- JavaScript functions
}
