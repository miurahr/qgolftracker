import QtQuick 1.0
//import QtQuick 1.1
import com.meego 1.0
//import Qt 4.7
//import QtMobility.location 1.1
import "../functions.js" as Functions
//import "../functions.js" as Functions
Page {


    id: viewPage
    tools: viewtools
    width: parent.width
    height: parent.height

    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: update()

    function open(indx, mode) {

        appWindow.sessionidtemp = playbackmodel.get(indx).id
        opendialog.open()


    }

    function inmap() {
        appWindow.pageStack.push(Qt.resolvedUrl("ViewMapPage.qml"))
        opendialog.accept()
    }

    function aslist() {
        appWindow.pageStack.push(Qt.resolvedUrl("DetailsPage.qml"))
        opendialog.accept()
    }


    Dialog {
        id: opendialog
        //onAccepted: createcourse(coursename.text, hleamount.value)
        //onRejected: cancelled()
        content: Item {
            id: dialogitem
            //height: parent.height - 150
            height: 300
            width: parent.width
            anchors.topMargin: 200
            Column {
                spacing: 10


            Text {
                font.pointSize: 20
                text: "Select how you want to view stats"
            }

            Button {
                text: "Open in map"
                onClicked: inmap()
            }

            Button {
                text: "Open as list"
                onClicked: aslist()
            }

            }
            /*
            TextInput {
                id: coursename
                color: "White"
                height: 150
                width: 400
                font.pointSize: 20
                onAccepted:coursename.closeSoftwareInputPanel
                text: "Name of the course"
                //onFocusChanged: coursename.closeSoftwareInputPanel
                selectByMouse: true
                cursorVisible: true
                //coursename.
            }
            //}
            Text {
                id: explan
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                //width: parent.width
                height: 25
                color: "White"
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                font.pointSize: 15
                text: "Amount of holes :" + hleamount.value
            }
            Slider {
                id: hleamount
                //anchors.top:  explan.bottom
                //anchors.topMargin: 10
                height: 50
                width: parent.width -150
                //anchors.centerIn: parent.horizontalCenter
                //anchors.top: explan.bottom
                //anchors.bottomMargin: 50
                minimumValue: 9
                maximumValue:  36
                stepSize: 9
                valueIndicatorVisible: true

            }*/


}
        //}


    }


    Item {
        anchors.fill: parent

        ListModel {
            id: playbackmodel

        }


        Component {
            id: delegatetitle

            Item {
            width: parent.width
            height: 50
            Rectangle {
             width: parent.width
             height: parent.height
             color: "gray"


            Text {
                font.pointSize: 32
                color: "white"
                text: section

            }
            }
            }
        }

        Component {
            id: delegatestuff

            Item {
                id: wrapper
                height: 100
                width: parent.width



                Column {
                    Text {
                        font.pointSize: 20
                        text: "Date: " + date
                    }
                    /*Text {
                        font.pointSize: 20
                        text: time
                    }*/

                    Text {
                        font.pointSize: 30
                        text: "Course: " + name

                    MouseArea {
                        anchors.fill:  parent
                        onClicked: open(index)
}
                    }
                }



            }





        }

        ListView {
            id: list
            anchors.fill:  parent
            model: playbackmodel
            focus: true
            //onCurrentIndexChanged: open()

            section.property: "id"
            section.delegate: delegatetitle

            delegate: delegatestuff


        }


        SectionScroller {
            listView: list
        }


    }


    function update() {
        roundbutton.enabled = false
        clubbutton.enabled = true
        //mapbutton.enabled = true


        Functions.read(3)


    }
}
