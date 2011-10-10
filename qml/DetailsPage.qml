import QtQuick 1.0

import com.meego 1.0

import "../functions.js" as Funcs


Page {
    id: detailspage
    orientationLock: PageOrientation.LockPortrait
    tools: viewtools2

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
                        text: Math.round(distance) + "m"
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
            section.delegate: holedelegate

            delegate: delegatestuff2

        }

        Component {
            id: holedelegate
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


        SectionScroller {
            listView: list2
        }


    }




    }


