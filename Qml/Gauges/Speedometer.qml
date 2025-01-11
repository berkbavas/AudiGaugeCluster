import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import ".."
import "../Util"

CircularGauge {
    id: root
    minimumValue: 0
    maximumValue: 160
    stepSize: 0.01

    style: CircularGaugeStyle {
        id: style
        minimumValueAngle: -140
        maximumValueAngle: 140
        tickmarkStepSize: 20
        labelStepSize: 20
        minorTickmarkCount: 3
        labelInset: 24 / 90 * outerRadius

        tickmark: Rectangle {
            color: "#ffffff"
            y: 2 / 90 * outerRadius
            width: 2 / 90 * outerRadius
            height: 7 / 90 * outerRadius
            antialiasing: true
        }

        minorTickmark: Rectangle {
            color: "#ffffff"
            y: 2 / 90 * outerRadius
            width: styleData.value % 10 === 0 ? 1.5 / 90 * outerRadius : 1.0 / 90 * outerRadius
            height: styleData.value % 10 === 0 ? 6.0 / 90 * outerRadius : 4.0 / 90 * outerRadius
            antialiasing: true
        }

        tickmarkLabel: Text {
            font.family: "Teko"
            font.pixelSize: Math.max(6, outerRadius * 0.175)
            text: styleData.value
            antialiasing: true
            color: "#ffffff"
            font.weight: Font.Black
        }

        foreground: Item {
            id: foreground
            width: 2 * outerRadius
            height: 2 * outerRadius

            Text {
                id: speed
                anchors.centerIn: foreground
                font.family: "Teko"
                font.pixelSize: Math.max(6, outerRadius * 0.375)
                text: Math.round(root.value)
                antialiasing: true
                color: "#ffffff"
                font.weight: Font.Black
            }

            Text {
                id: mph
                anchors.top: speed.bottom
                anchors.topMargin: -0.1 * outerRadius
                anchors.horizontalCenter: foreground.horizontalCenter
                font.family: "Teko"
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: "MPH"
                antialiasing: true
                color: "#ffffff"
                font.weight: Font.Black
            }
        }

        needle: Rectangle {
            y: -0.5 * outerRadius + 0.025 * outerRadius
            width: 2.5 / 90 * outerRadius
            height: 0.5 * outerRadius
            antialiasing: true
            radius: 3
            color: "#ff0000"
        }

        background: Background {
            outerRadius: style.outerRadius
            angle: valueToAngle(root.value)
        }
    }
}
