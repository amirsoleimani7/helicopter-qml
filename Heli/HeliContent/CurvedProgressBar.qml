// CurvedProgressBar.qml
import QtQuick
import QtQuick.Controls
import QtQuick3D
import QtQuick3D.Effects
import Heli
import Generated.QtQuick3D.MD_902_Explorer
import QtQuick3D.Helpers 6.7
import QtQuick.Particles 2.0
import QtQuick3D.SpatialAudio
import QtQuick3D.Particles3D 6.7
import QtQuick.Shapes 1.15

Item {
    id: control
    // Customizable properties
    property real value: 0.0        // Normalized (0.0 to 1.0)
    property color backgroundColor: "#e0e0e0"
    property color progressColor: "#2196F3"  // This will be bound later to a gradient expression.
    property real strokeWidth: 20
    property real startAngle: 135   // in degrees
    property real totalSweep: 270   // in degrees

    implicitWidth: 200
    implicitHeight: 200

    Shape {
        anchors.fill: parent
        // Background track
        ShapePath {
            strokeColor: control.backgroundColor
            strokeWidth: control.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: control.width / 2
                centerY: control.height / 2
                radiusX: Math.min(control.width, control.height) / 2 - control.strokeWidth / 2
                radiusY: radiusX
                startAngle: control.startAngle
                sweepAngle: control.totalSweep
            }
        }
        // Progress track
        ShapePath {
            strokeColor: control.progressColor
            strokeWidth: control.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: control.width / 2
                centerY: control.height / 2
                radiusX: Math.min(control.width, control.height) / 2 - control.strokeWidth / 2
                radiusY: radiusX
                startAngle: control.startAngle
                sweepAngle: control.totalSweep * control.value
            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
