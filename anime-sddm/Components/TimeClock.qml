import QtQuick 2.15
import SddmComponents 2.0

Clock {
  id: time
  color: config.text
  timeFont.family: config.Font
  dateFont.family: config.Font
  timeFont.pointSize: 130
  dateFont.pointSize: 60
  z: 5
  anchors {
    horizontalCenter: parent.horizontalCenter
    verticalCenter: parent.verticalCenter
    verticalCenterOffset: -300
  }
}
