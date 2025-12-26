import QtQuick
import Heli
import QtQuick.VirtualKeyboard

Window {
    id: window
    visible: true
    title: "Heli"
    visibility: Window.FullScreen
    flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint

    Shortcut {
        sequence: "Escape"
        onActivated: {
            if (window.visibility === Window.FullScreen) {
                window.visibility = Window.Windowed
                window.width = Screen.width * 1
                window.height = Screen.height * 0.98
                window.x = (Screen.width - window.width) / 2
                window.y = (Screen.height - window.height) / 2
                window.minimumWidth = window.width
                window.maximumWidth = window.width
                window.minimumHeight = window.height
                window.maximumHeight = window.height
            } else {
                // Switch back to fullscreen
                window.visibility = Window.FullScreen
            }
        }
    }

    Screen01 {
        id: mainScreen
        anchors.fill: parent
    }

    InputPanel {
        id: inputPanel
        property bool showKeyboard: active
        y: showKeyboard ? parent.height - height : parent.height
        Behavior on y {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Constants.width / 10
        anchors.rightMargin: Constants.width / 10
    }

}
