import QtQuick 2.15

Item {
    id: root
    property int numpadKey: -1
    width: 50
    height: 35

    signal clicked(int numpadKeyId)

    onNumpadKeyChanged: {
        if ((numpadKey < 0 || numpadKey > 9) && (numpadKey != -1)) {
            numpadKey = -1
        }
    }
    Rectangle {
        id: textContainer
        anchors.fill: parent
        color: "red"
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: {
            console.log("PINButton clicked")
            root.clicked(numpadKey)
        }
    }
}
