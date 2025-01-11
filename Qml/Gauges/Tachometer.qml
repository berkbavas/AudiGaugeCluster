import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import ".."
import "../Util"

CircularGauge {
    id: root
    minimumValue: 0
    maximumValue: 8000
    stepSize: 0.01

    style: CircularGaugeStyle {
        id: style
        minimumValueAngle: -140
        maximumValueAngle: 140
        tickmarkStepSize: 1000
        labelStepSize: 1000
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
            width: styleData.value % 500 === 0 ? 1.5 / 90 * outerRadius : 1.0 / 90 * outerRadius
            height: styleData.value % 500 === 0 ? 6.0 / 90 * outerRadius : 4.0 / 90 * outerRadius
            antialiasing: true
        }

        tickmarkLabel: Text {
            font.family: "Teko"
            font.pixelSize: Math.max(6, outerRadius * 0.25)
            text: styleData.value / 1000
            antialiasing: true
            color: "#ffffff"
            font.weight: Font.Black
        }

        foreground: Item {
            id: foreground
            width: 2 * outerRadius
            height: 2 * outerRadius

            Text {
                id: gear
                anchors.centerIn: foreground
                font.family: "Teko"
                font.pixelSize: Math.max(6, outerRadius * 0.375)
                text: "N"
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
            id: background
            outerRadius: style.outerRadius
            angle: valueToAngle(root.value)

            Canvas {
                id: critical
                anchors.fill: background
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.lineWidth = 12.5 / 90 * outerRadius
                    ctx.beginPath()
                    ctx.arc(outerRadius,
                            outerRadius,
                            outerRadius - 0.5 * ctx.lineWidth -  2.0 / 90 * outerRadius,
                            degreesToRadians(valueToAngle(6750) - 90),
                            degreesToRadians(valueToAngle(8000) - 90))
                    ctx.strokeStyle = "#d32300"
                    ctx.stroke()
                }
            }

            Text {
                id: textTop
                anchors.bottom: background.bottom
                anchors.bottomMargin: outerRadius * 0.3
                anchors.horizontalCenter: background.horizontalCenter
                font.family: "Teko"
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: "DYNAMIC"
                antialiasing: true
                color: "#d32300"
                font.weight: Font.Black
            }

            Text {
                id: textBottom
                anchors.bottom: textTop.bottom
                anchors.bottomMargin: -outerRadius * 0.125
                anchors.horizontalCenter: background.horizontalCenter
                font.family: "Teko"
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: "1/min x 1000"
                antialiasing: true
                color: "#ffffff"
                font.weight: Font.Black
            }
        }
    }

    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180)
    }
}
