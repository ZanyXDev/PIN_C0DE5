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
    name: "Pin Button"

    Component {
        id: keyEnums
        KeyEnums {}
    }
    Component {
        id: button
        PinButton {}
    }

    Component {
        id: signalSpy
        SignalSpy {}
    }

    function initTestCase() {
        var control = createTemporaryObject(keyEnums, testCase)
        verify(control)
    }

    function cleanupTestCase() {}

    function test_create_data() {
        return [{
                    "tag": "Without set numpadKey",
                    "result": -1
                }, {
                    "tag": "set numpadKey  < 0",
                    "numpadKey": -1,
                    "result": -1
                }, {
                    "tag": "set numpadKey >9 ",
                    "numpadKey": 10,
                    "result": -1
                }, {
                    "tag": "set numpadKey = 0",
                    "numpadKey": 0,
                    "result": 0
                }]
    }

    function test_create(data) {
        var control = createTemporaryObject(button, testCase, {
                                                "numpadKey": data.numpadKey
                                            })
        verify(control)
        compare(control.numpadKey, data.result)
    }

    function test_signalClicked_data() {
        return [{
                    "tag": "set numpadKey = undefined, signal clicked( -1 )",
                    "result": -1
                }, {
                    "tag": "set numpadKey = -1, signal clicked( -1 )",
                    "result": -1
                }, {
                    "tag": "set numpadKey = >9, signal clicked( -1 )",
                    "result": -1
                }, {
                    "tag": "set numpadKey = 0, signal clicked( 0 )",
                    "result": 0
                }]
    }

    function test_signalClicked(data) {
        // Create PinButton with  property  numpadKey: data.numpadKey
        var control = createTemporaryObject(button, testCase, {
                                                "numpadKey": data.numpadKey
                                            })
        verify(control)

        // Setup SignalSpy object
        var clickSpy = createTemporaryObject(signalSpy, testCase, {
                                                 "target": control,
                                                 "signalName": "clicked"
                                             })
        verify(clickSpy.valid)

        // Check mouse click on the button
        compare(clickSpy.count, 0)
        mouseClick(control, Qt.LeftButton, Qt.NoModifier)
        compare(clickSpy.count, 1)


        /**
           * This property holds a list of emitted signal arguments. Each emission of the signal
           * will append one item to the list, containing the arguments of the signal.
           * When connecting to a new target or new signalName or calling the clear() method,
           *  the signalArguments will be reset to empty.
           */
        compare(clickSpy.signalArguments[0][0], data.result)
    }
}
