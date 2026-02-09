import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects 1.0
import "Components"

Item {
  id: root
  height: Screen.height
  width: Screen.width
  Rectangle {
    id: background
    anchors.fill: parent
    height: parent.height
    width: parent.width
    z: 0
    color: config.base
  }
  Image {
    id: backgroundImage
    anchors.fill: parent
    height: parent.height
    width: parent.width
    fillMode: Image.PreserveAspectCrop
    visible: config.CustomBackground == "true" ? true : false
    z: 1
    source: config.Background
    asynchronous: false
    cache: true
    mipmap: true
    clip: true
    layer.enabled: true
    layer.effect: FastBlur {
      radius: 64
    }
  }
  Item {
    id: mainPanel
    z: 3
    anchors {
      fill: parent
      margins: 50
    }
    TimeClock {
      id: time
      visible: config.ClockEnabled == "true" ? true : false
    }
    LoginPanel {
      id: loginPanel
      anchors.fill: parent
    }
  }
}