// interaction.js

function startRotation(camera, mouse, initialX, initialY, initialRotationX, initialRotationY) {
    camera.initialX = initialX;
    camera.initialY = initialY;
    camera.initialRotationX = initialRotationX;
    camera.initialRotationY = initialRotationY;

    camera.onPositionChanged = function() {
        if (mouseArea.containsMouse) {
            camera.eulerRotation.x = camera.initialRotationX - (mouse.y - camera.initialY) * 0.5;
            camera.eulerRotation.y = camera.initialRotationY - (mouse.x - camera.initialX) * 0.5;
        }
    }
}

function startZoom(camera, mouse, initialZoom) {
    camera.initialZoom = initialZoom;

    camera.onWheel = function() {
        camera.position.z = camera.initialZoom + (mouse.wheelDeltaY * 5);
    }
}
