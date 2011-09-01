import QtQuick 1.0
//import QtQuick 1.1
import com.meego 1.0
//import Qt 4.7
//import QtMobility.location 1.1
import "../functions.js" as Functions
//import "../functions.js" as Functions
Page {
    id: viewPage
    tools: commonTools
    width: parent.width
    height: parent.height

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
            id: delegatestuff

            Item {
                id: wrapper
                height: 100

                Column {
                    Text {
                        font.pointSize: 20
                        text: date
                    }
                    Text {
                        font.pointSize: 20
                        text: time
                    }

                    Text {
                        font.pointSize: 40
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
            //onCurrentIndexChanged: open()

            section.property: "id"

            delegate: delegatestuff
             //   Rectangle {
                //Button {
                //font.pointSize: 20
                //text: name
                //onClicked:console.log(playbackmodel.objectName)
           //}
            /*    Text {
                    font.pointSize: 50
                    text: date + "\n" + name
               // }

            }*/

        }


        SectionScroller {
            listView: list
        }


    }


    function update() {
        //console.log("Update called from functions.js!")

        Functions.read(3)

        //only for debugging!
        //Functions.read(4)

        //Functions.read("3")
        //a += Functions.read()
        //a += Functions.read()
        //console.log(a)
        //textArea.text = a
    }
}
