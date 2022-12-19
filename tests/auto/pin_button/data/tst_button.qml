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
        PinButton {}
    }

    function initTestCase() {}

    function cleanupTestCase() {}

    function test_case1() {
        compare(1 + 1, 2, "sanity check")
        verify(true)
    }

    function test_text() {
        var control = createTemporaryObject(button, testCase)
        verify(control)

        compare(control.text, "")
        control.text = "Button"
        compare(control.text, "Button")
        control.text = ""
        compare(control.text, "")
    }

}
