import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import "../functions.js" as Funcs

Page {
    id: viewMapPage
    tools: viewtools2
    width: parent.width
    height: parent.height

    property string holetemp

    orientationLock: PageOrientation.LockPortrait

    Component.onCompleted: delaytimer.start()



    function update() {

        Funcs.populatemap("polyline")
        map.addMapObject(polyline)
        delaytimer2.start()
        //start timer 2
    }

    function update2() {
        Funcs.populatemap("teemarker")

        delaytimer3.start()

        //start timer 3
    }

    function update3() {

        Funcs.populatemap("balloons")
        delaytimer4.start()

    }

    function update4() {

        Funcs.populatemap("flag")
//do something

        delaytimer5.start()

    }

    function update5() {
        Funcs.populatemap("text")
        //do something
        busyrectangle.visible = false
        loading.visible = false
        loading.running = false
    }


    Rectangle {
        id: busyrectangle
        z:1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 100
        radius: 30
        visible: true
        color: "White"


    BusyIndicator {
        //anchors.centerIn: parent.center
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        id: loading
        z:1
        platformStyle: BusyIndicatorStyle { size: "large" }
        running:  true
        visible: true

                   }
    }

    Timer {
        id: delaytimer
        running: false
        repeat: false
        interval: 1000      //wait 1 secs before adding stuff to map
        onTriggered: update()
    }

    Timer {
        id: delaytimer2
        running: false
        repeat: false
        interval: 1000      //wait 1 secs before adding more stuff to map
        onTriggered: update2()
    }

    Timer {
        id: delaytimer3
        running: false
        repeat: false
        interval: 1000      //wait 1 secs before adding more stuff to map
        onTriggered: update3()
    }

    Timer {
        id: delaytimer4
        running: false
        repeat: false
        interval: 1000      //wait 1 secs before adding more stuff to map
        onTriggered: update4()
    }

    Timer {
        id: delaytimer5
        running: false
        repeat: false
        interval: 1000      //wait 1 secs before adding more stuff to map
        onTriggered: update5()
    }


    Button {
        id: zoomoutbutton
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 50
        z: 2
        width: 80
        height: 80
        text: "-"

        onClicked: map.zoomLevel --

    }

    Button {
        id: zoominbutton
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: zoomoutbutton.top
        z: 2
        width: 80
        height: 80
        text: "+"
        onClicked: map.zoomLevel ++
    }




    Item {
        anchors.fill: parent
        width: parent.width
        height: parent.height
        focus: true


    Map {
        id: map
        z: 1
        plugin: Plugin { name: "nokia"}
        anchors.fill: parent
        size.width: parent.width
        size.height: parent.height
        zoomLevel: 17
        center: Coordinate {
            latitude: 60
            longitude: 40
        }

        connectivityMode: Map.HybridMode

        mapType: Map.SatelliteMapDay




    MapMouseArea {
                property int lastX : -1
                property int lastY : -1

                onPressed : {
                    lastX = mouse.x
                    lastY = mouse.y
                }
                onReleased : {
                    lastX = -1
                    lastY = -1
                }
                onPositionChanged: {
                    //console.log("position changed!")
                    if (mouse.button == Qt.LeftButton) {
                        if ((lastX != -1) && (lastY != -1)) {
                            var dx = mouse.x - lastX
                            var dy = mouse.y - lastY
                            map.pan(-dx, -dy)
                        }
                        lastX = mouse.x
                        lastY = mouse.y
                    }
                }
                onDoubleClicked: {
                    map.center = mouse.coordinate
                    map.zoomLevel += 1
                    lastX = -1
                    lastY = -1
                }
            }

    }


}

    MapCircle {
        id: circle1
        center: Coordinate {
            latitude: 60.1
            longitude: 40.1
        }
        color: "blue"
        radius: 1000.0
}




    MapPolyline  {
        id: polyline
        border { color: "red"; width: 5 }
        visible: true
        Coordinate {
                id: point1
                latitude: 60.1
                longitude: 40.1
            }
            Coordinate {
                id: point2
                latitude: -28.34
                longitude: 153.45
            }
            Coordinate {
                id: point3
                latitude: -28.33
                longitude: 153.4
            }

        //now just use the script file to insert coordinates such as:
        // viewMapPage.polyline.addCoordinate( Coordinate )
        //yeah!

    }

    /*MapImage {
        coordinate: Coordinate{ latitude: 62.2513061; longitude:25.70465563 } source: "./flag.png"
    }*/


}
