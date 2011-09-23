import QtQuick 1.0
import com.meego 1.0
import "../functions.js" as Functions



Page {
    id: viewPage
    property bool norecords
    norecords:{ "false"}
    tools: viewtools
    width: parent.width
    height: parent.height

    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: update()

    function open(indx, mode) {
        if (norecords) {
            console.log("nothing")
        }
        else {
        appWindow.sessionidtemp = playbackmodel.get(indx).id
        opendialog.open()
        }

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
                color:"white"
                text: "How you want to view stats?"
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



}


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

                    Text {
                        font.pointSize: 30
                        text: name

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
