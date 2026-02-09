import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
Item {
  id: root
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: Screen.height * 0.032
  property var inputHeightPower: Screen.height * 0.048
  property var inputWidth: Screen.width * 0.16
  /* ───────────────── Login Background ───────────────── */
  Rectangle {
    id: loginBackground
    anchors.centerIn: loginPanel
    height: inputHeight * 5.3
    width: inputWidth * 1.2
    radius: 5
    visible: config.LoginBackground == "true"
    color: config.mantle
  }
  /* ───────────────── Power Buttons (Bottom Center) ───────────────── */
  Row {
    spacing: 8
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
      margins: 12
    }
    z: 5
    PowerButton { }
    RebootButton { }
    SleepButton { }
  }
  /* ───────────────── Session Panel (Right) ───────────────── */
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      right: parent.right
      margins: 12
    }
    z: 5
    SessionPanel {
      id: sessionPanel
    }
  }
  /* ───────────────── Login Panel (Center) ───────────────── */
  Column {
    id: loginPanel
    spacing: 8
    width: inputWidth
    z: 5
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: inputHeight
      width: parent.width
    }
    PasswordField {
      id: passwordField
      height: inputHeight
      width: parent.width
      onAccepted: loginButton.clicked()
    }
    Button {
      id: loginButton
      height: inputHeight
      width: parent.width
      enabled: user !== "" && password !== ""
      hoverEnabled: true
      contentItem: Text {
        id: buttonText
        text: "Login"
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.crust
        font {
          family: config.Font
          pointSize: config.FontSize
          bold: true
        }
      }
      background: Rectangle {
        id: buttonBackground
        radius: 3
        color: config.sapphire
      }
      states: [
        State {
          name: "hovered"
          when: loginButton.hovered || loginButton.down
          PropertyChanges {
            target: buttonBackground
            color: config.teal
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 250
        }
      }
      onClicked: {
        sddm.login(user, password, session)
      }
    }
  }
  /* ───────────────── Login Failure Handling ───────────────── */
  Connections {
    target: sddm
    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
