import QtQuick 1.0
//import QtQuick 1.1
//import com.meego 1.0
import com.nokia.meego 1.0
//import com.nokia.qmlcanvas 1.0
//import Qt 4.7
//import QtMobility.location 1.1
import "../functions.js" as Funcs
//import "../functions.js" as Functions
Page {
    id: viewbyclubsPage
    tools: viewtools
    width: parent.width
    height: parent.height

    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: update()

    function fetchdata() {
        stats.visible = true


        Funcs.getstatsbyclub(clubname.text)
        //fetch data etc here
    }

    function update() {
        roundbutton.enabled = true
        clubbutton.enabled = false
        //mapbutton.enabled = true

        Funcs.populatestatclubs()


    }

    /*Text{
        font.pointSize: 50
        text: "To be \nimplemented!"
        visible: true
    }*/


    Button {
        id: clubselectionButton2
        width: parent.width-40
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 20
        visible: true
        text: appWindow.clubstatinitiated ? clubstatselection.model.get(clubstatselection.selectedIndex).name : "Select club"


        onClicked: {appWindow.clubstatinitiated = true;clubstatselection.open()}

    }

    SelectionDialog {
        id: clubstatselection
        titleText: "Select club"
        selectedIndex: 0
          model: ListModel {
               id: clubstatModel


        }
        onAccepted: fetchdata()
}


    Column {
        id: stats
        visible: false
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: clubselectionButton2.bottom
        anchors.topMargin: 50
        spacing: 25

        Text {
            //anchors.top: parent.top
            //anchors.left: parent.left
            font.pointSize: 40
            text: "Stats by club:"
        }

        Text {
            id: clubname
            font.pointSize: 40
            text: appWindow.clubstatinitiated ? clubstatselection.model.get(clubstatselection.selectedIndex).name : ""
        }

        Row {
            Text {
                id: amountofhits
                text: "123"
                font.pointSize: 20
            }

            Text {
                text: " hits with selected club"
                font.pointSize: 20
            }
        }

        Row {

            Text {
                text: "Average distance:"
                font.pointSize: 20
            }

            Text {
                id: averagedistance
                text: "123"
                font.pointSize: 20
            }
        }

        Row {
            Text {
                text: "Minimum distance:"
                font.pointSize: 20
            }
            Text {
                id: minimumdistance
                text: "123"
                font.pointSize: 20
            }
        }

        Row {
            Text {
                text: "Maximum distance:"
                font.pointSize: 20
            }
            Text {
                id:maximumdistance
                text: "123"
                font.pointSize: 20
            }
        }
    }



    //this should draw rectangles (?!?!) to create a bar graph?
}
