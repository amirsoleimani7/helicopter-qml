import QtQuick 2.15
import QtQuick.Controls 2.15
import Heli 1.0

Item {
    id: infoControl

    // These properties are set from your main.ui.qml file:
    property Item targetButton: null    // Your Switch
    property Item targetRectangle: null // The rectangle to animate

    // Define the two states based on the switch’s (targetButton) checked value.
    // When checked (open) we slide the rectangle to the left.
    // When not checked (closed) we slide the rectangle to the right.
    states: [
        State {
            name: "open"
            when: targetButton && targetButton.checked
            PropertyChanges {
                target: targetRectangle
                // Assuming targetRectangle’s parent is the container,
                // its “open” position is parent.width minus its own width.
                x: targetRectangle.parent.width - targetRectangle.width
            }
        },
        State {
            name: "closed"
            when: targetButton && !targetButton.checked
            PropertyChanges {
                target: targetRectangle
                // For closing, position the rectangle offscreen to the right.
                x: targetRectangle.parent.width
            }
        }
    ]

    // Transition to animate any changes to x (i.e. sliding in or out)
    transitions: Transition {
        NumberAnimation {
            properties: "x"
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }
}
