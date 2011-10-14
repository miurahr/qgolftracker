import QtQuick 1.0
import com.meego 1.0
import "../functions.js" as Funcs



Page {

    // 1. INITING THE CURRENT PAGE, CREATING VARIABLES ETC

    id: viewPage
    property bool norecords
    property int indextemp
    norecords:{ "false"}
    tools: viewtools
    width: parent.width
    height: parent.height

    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: update()


    // 2. FUNCTIONS


    // 2.1 UPDATE EVERYTHING NEEDED AS SOON AAS PAGE HAS BEEN LOADED

    function update() {
        roundbutton.enabled = false
        clubbutton.enabled = true
        //mapbutton.enabled = true


        Funcs.populatelist()


    }
    // OPEN DEL DIALOG
    function open_deldialog(ind) {
        indextemp = ind
        deldialog.open()


    }

    function delround() {
        indextemp++
        Funcs.removeround(indextemp)
        //clear entries½!!!
        playbackmodel.clear()
        update()
    }


    //  2.2 OPEN TAPPED ITEM FROM LISTVIEW
    function open(indx, mode) {
        /*if (norecords) {
            console.log("nothing")
        }*/
        //else {
        appWindow.sessionidtemp = playbackmodel.get(indx).id
        opendialog.open()
        //}

    }
    // 2.3 OPEN TAPPED ITEM IN MAP (MAP BUTTON IN DIALOG PRESSED)
    function inmap() {
        //loading.visible = true
        //loading.running = true
        opendialog.accept()
        appWindow.pageStack.push(Qt.resolvedUrl("ViewMapPage.qml"))
        opendialog.accept()
    }

    // 2.4 OPEN TAPPED ITEM IN LISTVIEW (LIST BUTTON IN DIALOG PRESSED)

    function aslist() {
        appWindow.pageStack.push(Qt.resolvedUrl("DetailsPage.qml"))
        opendialog.accept()
    }



    // 3. QML COMPONENTS


    Rectangle {
        id: background
        z: 0
        width: parent.width
        height: parent.height

        Text {
            font.pointSize: 20
            text: "No entries found"
        }
    }


    // 3.1 DIALOG TO SELECT HOW ONE WANTS TO VIEW SELECTED ROUND, OPENS FROM 2.1

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
                id: mapbutton
                text: "Open in map"
                //onClicked:{loading.visible = true;loading.running=true}
                //onClicked: {loading.visible = true;inmap()}
                onClicked: inmap()
            }

            Button {
                text: "Open as list"
                onClicked: {aslist(); loading.visible = true}
            }
            }
            BusyIndicator {
                anchors.left: mapbutton.left
                anchors.leftMargin: 50
                anchors.top: mapbutton.top
                id: loading
                z:1
                platformStyle: BusyIndicatorStyle { size: "large" }
                running:  false
                visible: false

                           }





}


    }


    // 3.2 ARE YOU SURE DIALOG FOR ROUND DELETING

    QueryDialog {
        id: deldialog
        acceptButtonText: "OK"
        message: "This will erase selected round"
        rejectButtonText: "Cancel"
        titleText: "Are you sure?"
        onAccepted: delround()
        //onAccepted: console.log("Deleting entry #" + (indextemp))
        //onRejected: console.log("abort aborted")
}


    // 3.3 CONSTRUCT THE LIST OF ENTRIES
    Item {
        anchors.fill: parent

        ListModel {
            id: playbackmodel

        }

        // TITLE CREATION

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


        // ITEM CREATION


        Component {
            id: delegatestuff

            Item {
                id: wrapper
                height: 100
                width: parent.width


                //experimental: add button to delete selected entry...
                Button {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    width: 100
                    height: 100
                  visible:!norecords
                  text: "Delete"
                  onClicked: open_deldialog(index)
                }

                Column {

                    Rectangle {
                        width: 300
                        height: 80
                    Text {
                        anchors.top: parent.top
                        font.pointSize: 20
                        text: "Date: " + date
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        font.pointSize: 30
                        text: name
                    }
                    MouseArea {
                        anchors.fill:  parent
                        onClicked: open(index)
                    }
                    }
                }



            }





        }


        // 3.4 CONSTRUCT THE LIST WITH SECTIONS
        ListView {
            id: list
            anchors.fill:  parent
            model: playbackmodel
            focus: true
            section.property: "id"
            section.delegate: delegatetitle
            visible: !norecords
            //visible: false

            delegate: delegatestuff


        }


        SectionScroller {
            listView: list
        }


    }



}
