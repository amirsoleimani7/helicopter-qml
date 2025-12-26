import QtQuick 2.15

Item {
    id: settingsControl
    property Item targetButton: null
    property Item targetRectangle: null

    // Sync position with visibility when not animating
    Binding {
        target: targetRectangle
        property: "x"
        value: targetRectangle ? (targetRectangle.visible ? 0 : -targetRectangle.width) : 0
        when: targetRectangle && !openAnimation.running && !closeAnimation.running
    }

    MouseArea {
        id: toggleArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        preventStealing: true
        onClicked: {
            var newVisible = !targetRectangle.visible;
            if (newVisible) {
                targetRectangle.visible = true;
                openAnimation.start();
            } else {
                closeAnimation.start();
            }
            if (targetButton && targetButton.contentItem)
                targetButton.contentItem.color = newVisible ? "red" : "white";
        }
    }

    //opening animation
    NumberAnimation {
        id: openAnimation
        target: targetRectangle
        property: "x"
        from: -targetRectangle.width
        to: 0
        duration: 250
        easing.type: Easing.InOutQuad
    }

    //closing animation
    NumberAnimation {
        id: closeAnimation
        target: targetRectangle
        property: "x"
        from: 0
        to: -targetRectangle.width
        duration: 250
        easing.type: Easing.InOutQuad
        onStopped: {
            if (targetRectangle)
                targetRectangle.visible = false;
        }
    }

    Item {
        id: __materialLibrary__
    }
}

