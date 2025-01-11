import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import "Gauges"

Window {
    id: window
    width: 1280
    height: 720
    visible: true
    color: "#101010"

    property double scaling: Math.min(window.height / 1280, window.width / 720)

    FontLoader {
        source: "qrc:/Resources/Fonts/Teko-Regular.ttf"
    }

    Item {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        Row {
            anchors.centerIn: parent
            spacing: 160

            Tachometer {
                value: drivingData.throttle
                width: 500
                height: 500
            }

            Speedometer {
                value: drivingData.speed
                width: 500
                height: 500
            }
        }
    }
}
