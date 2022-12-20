import QtQuick 2.15
import QtTest 1.15
import QtQuick.Controls 2.15

import Common 1.0

TestCase {
    id: testCase
    width: 200
    height: 200
    visible: true
    when: windowShown
    name: "Button"

    Component {
        id: button
        PinButton {
            id: testPINButton
        }
    }

    Component {
        id: signalSpy
        SignalSpy {}
    }

    function initTestCase() {}

    function cleanupTestCase() {}

    function test_signalClicked() {
        var control = createTemporaryObject(button, testCase)
        verify(control)

        var clickSpy = signalSpy.createObject(control, {
                                                  "target": control,
                                                  "signalName": "clicked"
                                              })
        verify(clickSpy.valid)
    }
}
