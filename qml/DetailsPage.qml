import QtQuick 1.0

import com.meego 1.0
//import Qt 4.7

import "../functions.js" as Funcs


Page {
    id: detailspage
    orientationLock: PageOrientation.LockPortrait
    tools: viewtools

    Component.onCompleted: Funcs.populatedetails()




    Item {
        anchors.fill: parent

        ListModel {
            id: detailModel

        }


        Component {
            id: delegatestuff2

            Item {
                id: wrapper
                height: 100

                Column {
                    Row {
                    Text {
                        font.pointSize: 25
                        text: "Hole: "+ hole + " , hit: "

                    }

                    Text {
                        font.pointSize: 25
                        text: hit
                    }
                    }
                    Row {
                    Text {
                        font.pointSize: 25
                        text: "Club: " + club + " , distance: "
                    }
                    Text {
                        font.pointSize: 25
                        text: distance + "m"
                    }
                    }
                }




            }





        }

        ListView {
            id: list2
            anchors.fill:  parent
            model: detailModel
            focus: true
            section.property: "hole"

            delegate: delegatestuff2

        }


        SectionScroller {
            listView: list2
        }


    }




    }


