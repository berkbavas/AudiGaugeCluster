import QtQuick 2.0

import "../Util"

Rectangle {
    property double outerRadius
    property double angle

    id: root
    width: 2 * outerRadius
    height: 2 * outerRadius
    radius: outerRadius
    color: "#171717"

    GoodInnerShadow {
        source: root
        color: "#99000000"
        spread: 0.35
        radius: 0.5 * outerRadius
    }

    Canvas {
        id: outerRing
        anchors.fill: root
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
        anchors.fill: root
        rotation: angle - 87
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            ctx.beginPath()
            ctx.arc(outerRadius, outerRadius, 0.5 * outerRadius, 0, 2 * Math.PI)
            ctx.closePath()
            ctx.fillStyle = "#171717"
            ctx.fill()

            ctx.lineWidth = 1 / 90 * outerRadius
            ctx.strokeStyle = "#ffffff"

            ctx.beginPath()
            let r = 0.5 * outerRadius - 1.00 * 1.5 / 90 * outerRadius
            ctx.arc(outerRadius, outerRadius, r, 0, 2 * Math.PI - 0.1)
            ctx.stroke()
        }
    }

    Canvas {
        anchors.fill: root
        rotation: angle - 87
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            ctx.lineWidth = 1 / 90 * outerRadius
            ctx.strokeStyle = "#ffffff"

            ctx.beginPath()
            let r = 0.5 * outerRadius - 1.00 * 1.5 / 90 * outerRadius
            ctx.arc(outerRadius + r, outerRadius - 0.05 * r, 0.05 * r, 0.5 * Math.PI, 1.5 * Math.PI)
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
