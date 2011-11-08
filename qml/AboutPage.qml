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
            text: "Version: 0.5.0"
        }

        Text {
            id: information
            font.pointSize: 15
            width: parent.width
            text: "Written by: Timo Pelkonen (peltsip@gmail.com) <br><br>All source code available at:<br>https://www.gitorious.org/qgolftracker<br><br>I take no responsibility for anything (legal part)<br><br>You have installed the package from your free will,<br> I hope you enjoy it!"

        }


    }
}
