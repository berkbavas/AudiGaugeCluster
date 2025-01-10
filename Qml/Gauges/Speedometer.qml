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
            width: 2.5 / 90 * outerRadius
            height: 8.0 / 90 * outerRadius
            antialiasing: true
        }

        minorTickmark: Rectangle {
            color: "#ffffff"
            y: 2 / 90 * outerRadius
            width:  styleData.value % 10 === 0 ? 1.5 / 90 * outerRadius : 1.0 / 90 * outerRadius
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
            color: "#ff0000"
        }

        background: Rectangle {
            id: background
            width: 2 * outerRadius
            height: 2 * outerRadius
            radius: outerRadius
            color: "#171717"

            GoodInnerShadow {
                source: background
                color: "#99000000"
                spread: 0.35
                radius: 0.5 * outerRadius
            }

            Canvas {
                id: outerRing
                anchors.fill: background
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.strokeStyle = "#ffffff"
                    ctx.lineWidth = 2.0 / 90 * outerRadius

                    ctx.beginPath()
                    ctx.arc(outerRadius, outerRadius, outerRadius - 1.00 * 2.0 / 90 * outerRadius, 0, 2 * Math.PI)
                    ctx.stroke()
                }
            }

            Canvas {
                id: innerRing
                anchors.fill: background
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.beginPath();
                    ctx.arc(outerRadius, outerRadius, 0.5 * outerRadius, 0, 2 * Math.PI);
                    ctx.fillStyle = "#171717"
                    ctx.fill();

                    ctx.lineWidth = 1 / 90 * outerRadius
                    ctx.strokeStyle = "#ffffff"

                    ctx.beginPath()
                    ctx.arc(outerRadius, outerRadius,  0.5 * outerRadius - 1.00 * 1.5 / 90 * outerRadius, 0, 2 * Math.PI)
                    ctx.stroke()
                }
            }

            GoodInnerShadow {
                source: innerRing
                color: "#99000000"
                spread: 0.5
                radius: 0.5 * outerRadius
            }
        }
    }

}
