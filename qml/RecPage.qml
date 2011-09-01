import QtQuick 1.1
import com.meego 1.0
import Qt 4.7
import QtMobility.location 1.1

import "../functions.js" as Funcs




Page {
    id: recPage
    tools: commonTools
    property int hole:  1
    property int hit: 1
    property int pardiff:  0
    property string undotemp:  ""
    property string session


    //init clubs
    Component.onCompleted: pageloaded()

    function pageloaded() {
        Funcs.populateclubs()
        //Funcs.getnewsession()

        recPage.session = Funcs.getnewsession()
        //console.log("session from funcs : " + Funcs.getnewsession())
        //session = 1
        console.log("Session: " + recPage.session)
    }

    function returntomain() {

        commonTools.visible = true
        appWindow.clubsinitiated = false
        appWindow.pageStack.pop(mainPage, null, false)
    }




    QueryDialog {
        id: rusuredialog
        acceptButtonText: "OK"
        message: "This will erase all the progress if you press ok"
        rejectButtonText: "Cancel"
        titleText: "Are you sure?"
        onAccepted: returntomain()
        onRejected: console.log("abort aborted")

    }

    Dialog {
        id: summarydialog
        onAccepted: returntomain()
        onRejected: returntomain()
        title:
            Text {
            id: sdtitle
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 40
            height:100
            color:"White"
            text: "Summary:"
        }


        content:
         Text {
             font.pointSize: 20

             anchors.horizontalCenter: parent.horizontalCenter
             color:"White"
             height: 300
             text: stats.text

         }


        buttons: Button {
            //anchors.top : textpart.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "OK"
            onClicked: summarydialog.accept()

        }
}


    //club selection dialog

    function updateclub() {
        clubselection.open()
}

    SelectionDialog {
        id: clubselection
        titleText: "Select club"
        selectedIndex: 0
          model: ListModel {
               id: clubModel


        }
}

    //init GPS etc



    PositionSource {
        id: positionSource
        updateInterval: 1000
        //active: false
        active: gpsswitch.checked
    }

    function printableMethod(method) {
        if (method == PositionSource.SatellitePositioningMethod)
            return "Satellite";
        else if (method == PositionSource.NoPositioningMethod)
            return "Not available";
        else if (method == PositionSouce.NonSatellitePositioningMethod)
            return "Non-satellite";
        else if (method == PositionSource.AllPositioningMethods)
            return "All/multiple"
        return "source error";
    }

    function ballpotted() {
        hit--
        pardiff = pardiff + (-1 * (Funcs.readcourse("par",appWindow.course, hole) - hit))
        savedata("potted")

        stats.text += "Hole " + hole + ": " + hit + " (par: " + Funcs.readcourse("par", appWindow.course, hole) +") \t"+pardiff+"\n"

        if (hole < appWindow.courseholes) {


        hit = 1
        hole +=1
        undotemp = "pot"
        }
        else {

            summarydialog.open()
        }
    }

    function savedata(overrideclub) {


        // write (lat,lon,alt,horacc,veracc,date,time,club,course,hole) {

        //data to be saved:
        //idnumber          id int
        //sessionid         sessionid int
        //gps position      latitude int
        //                  longitude int
        //                  altitude int
        //gps accuracy      horizontalaccuracy int
        //                  verticalaccuracy int
        //date              date int
        //time              time int
        //club              club varchar
        //course            course varchar
        //hole              hole int
        var session = Funcs.getnewsession()
        var latitude = positionSource.position.coordinate.latitude
        var longitude = positionSource.position.coordinate.longitude
        var altitude = positionSource.position.coordinate.altitude
        var horizontalaccuracy = positionSource.position.horizontalAccuracy
        var verticalaccuracy = positionSource.position.verticalAccuracy
        var date = Qt.formatDate(new Date(), "ddMMyy")
        var time = Qt.formatTime(new Date(), "hhmm")
        var club
        if (overrideclub == "potted"){
            club = overrideclub
        }
        else {
            club = clubselection.model.get(clubselection.selectedIndex).name
        }


        //Funcs.write(latitude, longitude, altitude, horizontalaccuracy, verticalaccuracy, date, time, club, course, hole)
        Funcs.write(recPage.session, latitude, longitude, altitude, horizontalaccuracy, verticalaccuracy, date, time, club, course, hole)
        //console.log("wrote session: " + session + " latitude:" + latitude +", longitude: " + longitude +", altitude: " + altitude +", horizontalacc: " + horizontalaccuracy +", verticalacc: " + verticalaccuracy +", date: " + date +", time: " + time + ", club: " + club + ", course: " + course + ", hole: " + hole)
        //console.log("Will write " +club + " " + course + " " + hole + " etc to db")
        hit +=1
        undotemp = "hit"
    }


    Row {
        id: gpsstatusswitchrow
        anchors.top: parent.top
        anchors.left:  parent.left
        width:  parent.width
        anchors.leftMargin: parent.width / 4

        Text {
            id:switchtext
            //anchors.left: parent.left
            font.pointSize: 32
            text: gpsswitch.checked ? "GPS ON" : "GPS OFF"

        }


        Switch {
            id: gpsswitch
            width: 100
            checked: true
            //anchors.left: switchtext.right
            //anchors.leftMargin: 50


         }
    }

    Flow {
        //LeftToRight: true
        width: mainPage.width
        id: buttonarea
        anchors.fill: parent
        //anchors.top:  positiondata.bottom
        anchors.topMargin: 50
        anchors.leftMargin: 25
        //anchors.left:  parent.left
        spacing: 20
        //Comboboxes for selecting stuff
        // Switch for power saving: toggle gps on/off
        Text {
            font.pointSize: 32
            width: parent.width
            text: "Course: " + course
        }

        Text {
            font.pointSize: 32
            width: 400
            text: "Hole #" + hole
        }

        Text {
            font.pointSize: 32
            width: 400
            text: "Hit #" + hit
        }


        Button {
            id: clubselectionButton
            width: 300
            text: appWindow.clubsinitiated ? clubselection.model.get(clubselection.selectedIndex).name : "Select club"
                      //gpsswitch.checked ? "GPS ON" : "GPS OFF"

            onClicked: updateclub()

        }



    Button {
        id: savebutton
        text: "Hit"
        width: 400
        visible: true
        onClicked: savedata()
        //This button saves coordinates, not implemented (yet)
    }
    Button {
        id: holedonebutton
        width: 400
        text: "Ball in the hole"
        onClicked: ballpotted()
        //hit count +1, hole +1 etc...
    }
    Button {
        id: undobutton
        width: 150
        text: "UNDO"
        onClicked:  console.log("This will be undoed: " + undotemp)
        //hit count -1, remove last row etc?
    }

    Button {
        id: abortbutton
        //color: red
        width: 150
        text: "ABORT!"
        onClicked: rusuredialog.open()


        //abort the whole stuff, SHOULD THIS REMOVE EVERYTHING?!?? now it leaves sql entries already written intact...
    }


     Text {
         id: stats
         width: appWindow.width
         font.pointSize: 16
         //wrapMode:Wrap
         text: ""

     }

    }




    }


