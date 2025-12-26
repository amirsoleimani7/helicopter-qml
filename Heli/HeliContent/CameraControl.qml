import QtQuick 2.15

Item {
    // Assign the target camera
    property alias targetCamera: controller.targetCamera

    // Define min/max zoom
    property real minZoom: 1200
    property real maxZoom: 3000

    // Original camera position in spherical coordinates (calculated from x:-1008, y:838, z:1328)
    readonly property real originalRadius: 1865.7
    readonly property real originalAzimuth: -0.65    // Computed using Math.atan2(-1008, 1328)
    readonly property real originalElevation: 0.466  // Computed using Math.asin(838/1865.7)

    // Camera control properties
    property real azimuth: originalAzimuth
    property real elevation: originalElevation
    property real radius: originalRadius

    MouseArea {
        id: controller
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        property var targetCamera: null
        property real lastX: 0
        property real lastY: 0

        onPressed: {
            lastX = mouse.x
            lastY = mouse.y
        }

        onPositionChanged: {
            if (pressed && targetCamera) {
                var deltaX = mouse.x - lastX
                var deltaY = mouse.y - lastY

                azimuth += deltaX * 0.005
                elevation -= deltaY * 0.005

                // Clamp elevation to prevent flipping
                elevation = Math.max(-Math.PI/2 + 0.1, Math.min(Math.PI/2 - 0.1, elevation))
                updateCamera()

                lastX = mouse.x
                lastY = mouse.y
            }
        }

        onWheel: {
            if (targetCamera) {
                var newRadius = radius - wheel.angleDelta.y
                radius = Math.max(minZoom, Math.min(newRadius, maxZoom))
                updateCamera()
            }
        }

        onReleased: {
            // Reset to original position when released
            azimuth = originalAzimuth
            elevation = originalElevation
            radius = originalRadius
            updateCamera()
        }

        function updateCamera() {
            if (!targetCamera) return;

            // Convert spherical coordinates to Cartesian
            var newX = radius * Math.cos(elevation) * Math.sin(azimuth)
            var newY = radius * Math.sin(elevation)
            var newZ = radius * Math.cos(elevation) * Math.cos(azimuth)

            targetCamera.x = newX
            targetCamera.y = newY
            targetCamera.z = newZ

            // Keep camera oriented toward origin
            targetCamera.lookAt(Qt.vector3d(0, 0, 0))
        }
    }
}



