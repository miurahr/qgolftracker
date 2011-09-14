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

    function open(indx) {

        appWindow.sessionidtemp = playbackmodel.get(indx).id
        appWindow.pageStack.push(Qt.resolvedUrl("DetailsPage.qml"))

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


        Functions.read(3)


    }
}
