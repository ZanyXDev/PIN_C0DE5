import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.0
import QtMultimedia 5.15

Item {
    id: root
    property int numpadKey: -1
    property bool isActive: root.enabled && ma.containsMouse
    property double dp: 1.0


    /**
     * @var Qt::MouseButtons acceptedButtons
     * This property holds the mouse buttons that the mouse area reacts to.
     * See <a href="https://doc.qt.io/qt-5/qml-qtquick-mousearea.html#acceptedButtons-prop">Qt documentation</a>.
     */
    property alias acceptedButtons: ma.acceptedButtons


    /**
     * @var MouseArea ara
     * Mouse area element covering the button.
     */
    property alias mouseArea: ma


    /** This property Enables accessibility of QML items.
      * See <a href="https://doc.qt.io/qt-5/qml-qtquick-accessible.html">Qt documentation</a>.
     */
    Accessible.role: Accessible.Button
    Accessible.name: btnText.text
    Accessible.onPressAction: root.clicked(null)

    enabled: true

    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: root
        horizontalOffset: 3 * dp
        verticalOffset: 4 * dp
        radius: 5 * dp
        samples: 11
        color: "grey"
        opacity: 0.75
    }

    signal clicked(int numpadKeyId)
    signal hoverChanged

    onNumpadKeyChanged: {
        if ((numpadKey < 0 || numpadKey > 9) && (numpadKey != -1)) {
            numpadKey = -1
        }
    }
    state: ma.pressed ? "buttonDown" : "buttonUp"
    states: [
        State {
            name: "buttonDown"
            PropertyChanges {
                target: root
                scale: 0.7
            }
            PropertyChanges {
                target: root
                layer.enabled: false
            }
            PropertyChanges {
                target: btnText
                color: "green"
            }
        },
        State {
            name: "buttonUp"
            PropertyChanges {
                target: root
                scale: 1.0
            }
            PropertyChanges {
                target: root
                layer.enabled: true
            }
            PropertyChanges {
                target: btnText
                color: "lightgreen"
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: scale
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 2 * dp
        radius: 10 * dp
        smooth: true
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "grey"
            }
            GradientStop {
                position: 1.0
                color: "black"
            }
        }

        Text {
            id: btnText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            text: root.numpadKey
            font.family: "Helvetica"
            font.pointSize: 22
            font.bold: true
            smooth: true
            anchors.centerIn: parent
            color: "lightgreen"
        }
    }

    SoundEffect {
        id: playSound
        source: "soundeffect.wav"
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: isActive ? Qt.PointingHandCursor : Qt.ArrowCursor
        onPressed: {
            playSound.play()
        }

        onClicked: {
            root.clicked(numpadKey)
        }
        onHoveredChanged: {
            root.hoverChanged()
        }
    }
}
