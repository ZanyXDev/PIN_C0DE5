import QtQuick 2.15

Item {
    id: root
    property int numpadKey: -1
    signal clicked(int numpad_key_value)

    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: root.clicked(root.numpadKey)
    }
}
