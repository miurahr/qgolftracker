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

    function populatetumbler() {


        for (var i = 1; i < 15; i++){
        clubnumber.append({value:i})
            //console.log("tumbleradd " + i)
    }
    }

   /* function tumblerchanged() {
        console.log("thumbler chachanged")

    }*/


    function populateclubs() {

        clublisttext.text = ""

        for (var i = 1; i < 15; i++){
            clublisttext.text +=  i + ": " + Funcs.readclub(i) + "\n"
    }
    }

    function save() {

        clubname.closeSoftwareInputPanel()

        if(clubname.text == "empty") {
           // console.log("empty, not saving anything!")
            Funcs.removeclub((clbNmbrs.selectedIndex + 1))
        }

        else {

        console.log("saving club number " + (clbNmbrs.selectedIndex + 1) + " and name: " + clubname.text)

        Funcs.writeclubs((clbNmbrs.selectedIndex +1) , clubname.text)

        }
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
        text: "Club editing dialog"
    }

    Text {
        anchors.top: title.bottom
        anchors.topMargin: 10
        font.pointSize: 16
        text: "If you want to delete club, \n enter name 'empty' and save"
    }

    Item {
        id: tumblerstuff
        width: 150
        height: 200
        anchors.left: parent.left
        //anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 200
          Tumbler {
           id: clubtumbler
           columns: [clbNmbrs]
           //onChanged: tumblerchanged() YAY, NOT EVEN NEEDED!!!
          }

    }

    TextInput {
        id: clubname
        width: parent.width - 200
        height: 100
        anchors.top: tumblerstuff.top
        anchors.topMargin: 50
        anchors.left: tumblerstuff.right
        font.pointSize: 30
        onAccepted:clubname.closeSoftwareInputPanel()
        //text: "Name of the course"
        //onFocusChanged: coursename.closeSoftwareInputPanel
        selectByMouse: true
        cursorVisible: true


        text: Funcs.readclub(clbNmbrs.selectedIndex +1)
    }



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



  Row {
anchors.bottom:  parent.bottom
anchors.horizontalCenter: parent.horizontalCenter
width: parent.width
    Button {
            width: parent.width/2
            text: "Save"
            onClicked: save()
        }

        Button {
            width: parent.width/2
            text: "Exit"
            onClicked:  cancel()
        }
    }
}
