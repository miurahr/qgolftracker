import QtQuick 1.0
import com.meego 1.0
import Qt 4.7
import com.nokia.extras 1.0
import "../functions.js" as Funcs

Page {
    id: eclubs
    orientationLock: PageOrientation.LockPortrait
    Component.onCompleted: init()


    function init() {

        populatetumbler()
        populateclubs()

    }

    function textclicked() {
        if (!clubname.activeFocus) {
        clubname.openSoftwareInputPanel()
        clubname.selectAll()
        }
        else {
            clubname.closeSoftwareInputPanel()
            clubname.focus = false
        }
        }



    function textok() {
        clubname.closeSoftwareInputPanel()
        userchanged()
    }

    function populatetumbler() {


        for (var i = 1; i < 15; i++){
        clubnumber.append({value:i})
            //console.log("tumbleradd " + i)
    }
    }

   function userchanged() {
        //property type name: valueconsole.log("thumbler chachanged")

        //ENABLE SAVE BUTTON AGAIN!
        savebutton.enabled = true

    }


    function populateclubs() {

        Funcs.reorderclubs()

        clublistpart1.text = ""
        clublistpart2.text = ""

        for (var o = 1; o < 8; o++){
            clublistpart1.text +=  o + ": " + Funcs.readclub(o) + "\n"
    }

        for (var p = 8; p < 15; p++){
            clublistpart2.text +=  p + ": " + Funcs.readclub(p) + "\n"
    }
    }

    function save() {
        savebutton.enabled = false
        clubname.closeSoftwareInputPanel()

        /*if(clubname.text == "empty") {
           // console.log("empty, not saving anything!")
            Funcs.removeclub((clbNmbrs.selectedIndex + 1))
        }*/

        //else {

        console.log("saving club number " + (clbNmbrs.selectedIndex + 1) + " and name: " + clubname.text)

        Funcs.writeclubs((clbNmbrs.selectedIndex +1) , clubname.text)

        //}

        populateclubs()

    }

    function cancel() {
        console.log("club editing cancelled")
        clubname.closeSoftwareInputPanel()
    appWindow.pageStack.pop(mainPage, null, false)
    }

    ListModel {
        id:clubnumber
        }

    TumblerColumn {
        id: clbNmbrs
        selectedIndex: 0
        items: clubnumber
    }

    Text {
        id: title
        font.pointSize: 32
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        text: "Edit clubs"
    }

    /*Text {
        anchors.top: title.bottom
        anchors.topMargin: 10
        font.pointSize: 16
        text: "If you want to delete club, \n enter name 'empty' and save"
    }*/

    Item {
        id: tumblerstuff
        width: 150
        height: 200
        anchors.left: parent.left
        //anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 50
          Tumbler {
           id: clubtumbler
           columns: [clbNmbrs]
           //onChanged: userchanged()
          }

    }
    Rectangle {
        id: textentry
        color:"black"
        width: parent.width - tumblerstuff.width
        height: 200
        anchors.top: tumblerstuff.top
        anchors.left: tumblerstuff.right

    TextInput {
        id: clubname
        anchors.top: parent.top
        height: 50
        width: 300
        anchors.topMargin: 75

        font.pointSize: 30
        onAccepted:textok()
        //text: "Name of the course"
        onFocusChanged: {
            if (!clubname.activeFocus) {
                clubname.selectAll()
            }
            else {
            clubname.closeSoftwareInputPanel()
            }
        }
        selectByMouse: true
        cursorVisible: true
        //onChanged: userchanged()
        //onDataChanged: userchanged()
        //onAccepted: userchanged()

        color:"white"


        text: Funcs.readclub(clbNmbrs.selectedIndex +1)

        /*MouseArea {
            anchors.fill: parent
            onClicked: textclicked()
            onPressAndHold: clubname.closeSoftwareInputPanel()
        }*/
    }
    }

    Button {
        id: deleteclub
        width: parent.width
        height: 100
        text: "Delete club"
        anchors.top: textentry.bottom
        anchors.topMargin: 50
        onClicked: {Funcs.deleteclub(clbNmbrs.selectedIndex++);populateclubs()}

    }

    Text {
        id: clublistpart1
        width: parent.width / 2
        height: 250
        font.pointSize: 22
        anchors.left: parent.left
        anchors.top: deleteclub.bottom
        anchors.topMargin: 30
    }

    Text {
        id: clublistpart2
        font.pointSize: 22
        width: clublistpart1.width
        height: clublistpart1.height
        anchors.left: clublistpart1.right
        anchors.top: clublistpart1.top

    }
/*
    Flickable {
        id: clublist

        //here will be complete club list as text
        anchors.top: tumblerstuff.bottom
        anchors.topMargin: 20

        width: parent.width
        height: 250
        //height: parent.height
        contentHeight: 350
        contentWidth:  200

        Text{
            id: clublisttext
            anchors.fill: parent
            font.pointSize: 22
            //text: "here will be list of all clubs etc"
        }
    }
*/


  Row {
anchors.bottom:  parent.bottom
anchors.horizontalCenter: parent.horizontalCenter
width: parent.width
    Button {
            id: savebutton
            width: parent.width/2
            text: "Save"
            onClicked: save()
            enabled: false
        }

        Button {
            id: cancelbutton
            width: parent.width/2
            text: "Exit"
            onClicked:  cancel()
        }
    }
}
