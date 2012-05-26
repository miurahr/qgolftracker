import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    orientationLock: PageOrientation.LockPortrait
    id: aboutPage
    tools: viewtools

    Component.onCompleted: { roundbutton.visible = false; clubbutton.visible = false}

    Column {
        spacing: 50

        Image{
            source: "qrc:/images/logo.svg"
            width: 400
            height: 100
            smooth: true
        }
        Text {
            id: title
            font.pointSize: 50
            text: "qGolfTracker"
        }

        Text {
            id: version
            font.pointSize: 20
        text: "Version: 1.0.0-m2"
        }

        Text {
            id: information
            font.pointSize: 15
            width: parent.width
            text: "Modified by: Hiroshi Miura (miurahr@linux.com)<br>Original: Timo Pelkonen (peltsip@gmail.com) <br><br>You can reach a source at:<br>https://github.com/miurahr/qgolftracker"

        }


    }
}
