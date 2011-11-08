import QtQuick 1.1
//import com.meego 1.0
import com.nokia.meego 1.0
import Qt 4.7
import QtMobility.location 1.2
import com.nokia.extras 1.0

import "../functions.js" as Funcs




Page {
    id: recPage
    tools: commonTools
    property int hole:  1
    property int hit: 1
    property int pardiff:  0
    property string undotemp
    property string session
    property string lastholehits
    property bool undoused
    property string undolastrow
    undoused: {"false"}

    orientationLock: PageOrientation.LockPortrait

    //init clubs
    Component.onCompleted: pageloaded()


    function abort() {
        Funcs.removelastround()
        returntomain()
    }

    function pageloaded() {
        Funcs.populateclubs()
        //Funcs.getnewsession()

        recPage.session = Funcs.getnewsession()
        //console.log("session from funcs : " + Funcs.getnewsession())
        //session = 1
        //console.log("Session: " + recPage.session)
    }

    function returntomain() {

        commonTools.visible = true
        appWindow.clubsinitiated = false
        appWindow.pageStack.pop(mainPage, null, false)
    }

    function undo() {
        //console.log("This will be undoed: " + undotemp)
        undoused = true
        //this can be either pot or hit or pocket
        if (undotemp === "pot") {
            hole --
            hit = lastholehits ++


            if (hole < 10) {
            stats1.text = undolastrow
            }
            else {
            stats2.text = undolastrow
            }




            //THIS SHOULD ALSO REMOVE THE LINE FROM THE STATS!
        }
        if (undotemp === "hit") {
            hit --
            //decrease hit
        }

        if (undotemp === "pocket") {

            hole --
            hit = lastholehits ++


            if (hole < 10) {
            stats1.text = undolastrow
            }
            else {
            stats2.text = undolastrow
            }
        }


        Funcs.removelastrow()
        // delete last row from db!
    }


    function ballpocketed(hits) {
        undoused = false


        savedata("pocketed")

//        hit = Funcs.readcourse("par", appWindow.course, hole)
//        hit =+ 3
//      here should be dialog querying hits one wants to scoresheet
        hit = hits
        hit ++

        ballpotted(false) //false because we don't want to have 2 entries: pocketed + potted
        undotemp = "pocket"

    }

    //club selection dialog

    function updateclub() {
        clubselection.open()
}

    function ballpotted(save) {
        //console.log("amount of hits: " + hit)
        undoused = false
        var hittemp = hit - 1
        hit--
        lastholehits = hit
        console.log("lastholehits: " + lastholehits)
        //console.log("amount of hits now: " + hit)
        pardiff = pardiff + (-1 * (Funcs.readcourse("par",appWindow.course, hole) - hit))
        if (save) {
        savedata("potted")
        }
        if (hole < 10) {
            undolastrow = stats1.text
            stats1.text += "Hole " + hole + ": " + hittemp + " (par: " + Funcs.readcourse("par", appWindow.course, hole) +") \t"+pardiff+"<br>"
        }
        else {
            undolastrow = stats2.text
            stats2.text += "Hole " + hole + ": " + hittemp + " (par: " + Funcs.readcourse("par", appWindow.course, hole) +") \t"+pardiff+"<br>"
        }

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
        undoused = false
        //writing.running = true
        //writing.visible = true


        if (!appWindow.clubsinitiated) {
            notification.show()
        }

        else {
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
        //writing.running = false
        //writing.visible = false
    }
    }

   /* BusyIndicator {
        id: writing
        running: false
        visible: false
        z: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        platformStyle: BusyIndicatorStyle { size: "large" }
    }*/

    Dialog {
        id: pocketdialog
        onAccepted: ballpocketed(hitamount.value)
        //onRejected: cancelled()
        content: Item {
            id: dialogitem
            //height: parent.height - 150
            height: 300
            width: parent.width
            anchors.topMargin: 200

            Column{
                spacing: 10
                Text {
                    id: title
                    font.pointSize: 30
                    color: "White"
                    text: "Confirmation"
                }

            Text {
                id: explanation
                color: "White"
                font.pointSize: 15
                text: "You cannot pocket ball <br>while playing hit game, <br>when playing point game, <br>amount of hits must be<br>personal par + 2 (=0 points)"
            }

            Text {
                id: explan
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                //width: parent.width
                height: 25
                color: "White"
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                font.pointSize: 25
                text: "Hits :" + hitamount.value
            }
            Slider {
                id: hitamount
                //anchors.top:  explan.bottom
                //anchors.topMargin: 10
                height: 50
                width: 300
                //anchors.centerIn: parent.horizontalCenter
                //anchors.top: explan.bottom
                //anchors.bottomMargin: 50
                minimumValue: 5
                maximumValue:  10
                stepSize: 1
                valueIndicatorVisible: true

            }

            }
}
        //}

        buttons: ButtonRow {

            width: parent.width

            Button {
                text: "Ok"
                onClicked: pocketdialog.accept()
            }
            Button {
                text: "Cancel"
                onClicked: pocketdialog.close()

            }
        }
    }



    Rectangle {
        z:-1
        id: gpsnotokbottom
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: 50
        color: "red"
        //visible: !gpsswitch.checked
        /*Text {
           text: "waiting for fix
        }*/
    }


    Rectangle {
        z:0
        id: gpsnotok
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: 50
        color: "red"
        visible: !gpsswitch.checked
        /*Text {
           text: "waiting for fix
        }*/
    }

    Rectangle {
        z:-1
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: 50
        id: gpsok
        color: "green"
        visible: positionSource.position.latitudeValid
        Text {
            font.pointSize: 16
            anchors.top: parent.top
            //anchors.topMargin: 50
            anchors.right: parent.right
            width: 100
            text: "Accuracy: \n" + Math.round(positionSource.position.horizontalAccuracy) + " m"
        }
    }

    QueryDialog {
        id: rusuredialog
        acceptButtonText: "OK"
        message: "This will erase all the progress if you press ok"
        rejectButtonText: "Cancel"
        titleText: "Are you sure?"
        onAccepted: abort()
        onRejected: console.log("abort aborted")

    }


    QueryDialog {
        id: undodialog
        acceptButtonText: "OK"
        message: "Are you sure you want to undo last action?"
        rejectButtonText: "Cancel"
        titleText: "Undo?"
        onAccepted: undo()
        //onRejected: do not undo!

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
         Rectangle {
            anchors.top: sdtitle.bottom
            anchors.topMargin: 50
            anchors.left: recPage.left
            anchors.right: recPage.right

            //anchors.left:

            x: 10
            color: "black"
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 300
            Text {
                id: front9
                font.pointSize: 12
                anchors.left: parent.left
                anchors.top: parent.top
                width: 200
                height: parent.height
             color:"White"

             text: stats1.text

         }
            Text {
                font.pointSize: 12
                anchors.left: front9.right
                anchors.top: parent.top
                width: 200
                height: parent.height
                text: stats2.text
                color:"White"
            }
        }



        buttons: Button {
            //anchors.top : textpart.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "OK"
            onClicked: summarydialog.accept()

        }
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
/*
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
*/


    InfoBanner {
        id: notification
        timerEnabled: true
        timerShowTime: 5000
        text: "Select club first!"
    }


    Row {
        id: gpsstatusswitchrow
        anchors.top: parent.top
        anchors.left:  parent.left
        width:  parent.width
        height: 50
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

    /*Flow {
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
        // Switch for power saving: toggle gps on/off*/

        Column {
            id: info
            width: parent.width
            anchors.top: gpsstatusswitchrow.bottom
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.topMargin: 10

        Text {
            font.pointSize: 32
            width: parent.width
            height: 50
            //anchors.top: parent.top
            text: "Course: " + course
        }

        Text {
            font.pointSize: 32
            width: 400
            height: 50
            text: "Hole #" + hole
        }

        Text {
            font.pointSize: 32
            width: 400
            height: 50
            text: "Hit #" + hit
        }

        }

        Button {
            id: clubselectionButton
            width: parent.width-40
            height: 50
            anchors.top: info.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 20

            text: appWindow.clubsinitiated ? clubselection.model.get(clubselection.selectedIndex).name : "Select club"
                      //gpsswitch.checked ? "GPS ON" : "GPS OFF"

            onClicked: updateclub()

        }

Row {
    id: buttongroup
    anchors.top: clubselectionButton.bottom
    anchors.topMargin: 30
    anchors.left: info.left
    width: parent.width

    Button {
        id: savebutton
        text: "Hit"
        //width: clubselectionButton.width
        width: 300
        height: 100
        visible: true
        enabled: positionSource.position.latitudeValid
        onClicked: savedata()

    }
    Button {
        id: holedonebutton
        //width: clubselectionButton.width
        height: 100
        width: clubselectionButton.width - savebutton.width
        text: "Potted"
        enabled: positionSource.position.latitudeValid
        onClicked: ballpotted(true)
        //hit count +1, hole +1 etc...
    }
}

Row {
    id: cancelbuttons
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    anchors.left: info.left
    Button {
        id: pocketbutton
        width: clubselectionButton.width / 3
        height: 50
        text: "Pocket ball"
        onClicked: pocketdialog.open()
    }

    Button {
        id: undobutton
        width: clubselectionButton.width/3
        height: 50
        text: "UNDO"
        enabled: !undoused
        onClicked:  undodialog.open()
        //hit count -1, remove last row etc?
    }

    Button {
        id: abortbutton
        //color: red
        width: clubselectionButton.width/3
        height: 50
        text: "ABORT!"
        onClicked: rusuredialog.open()


        //abort the whole stuff, SHOULD THIS REMOVE EVERYTHING?!?? now it leaves sql entries already written intact...
    }
}
    /*Row {

        anchors.bottom: cancelbuttons.top
        anchors.top: buttongroup.bottom
        anchors.topMargin: 30
        anchors.bottomMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: clubselectionButton.width*/

     Text {
         id: stats1
         width: clubselectionButton.width/2
         height: 500
         anchors.bottom: cancelbuttons.top
         anchors.top: buttongroup.bottom
         anchors.topMargin: 30
         anchors.bottomMargin: 30
         anchors.left: clubselectionButton.left
         //anchors.left: parent.left
         font.pointSize: 15
         //wrapMode:Wrap
         textFormat: Text.RichText
         text: "<b>Front 9:</b><br>"

     }

     Text {
         id: stats2
         width: clubselectionButton.width/2
         //width: 200
         //height: 200
         anchors.bottom: cancelbuttons.top
         anchors.top: buttongroup.bottom
         anchors.topMargin: 30
         anchors.bottomMargin: 30
         anchors.left: stats1.right
         font.pointSize: 15
         //anchors.left: stats1.right
         //wrapMode:Wrap
         text: "<b>Back 9:</b><br>"

}

     }









