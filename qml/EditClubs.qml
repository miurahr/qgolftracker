import QtQuick 1.0
//import com.meego 1.0
import com.nokia.meego 1.0
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
	}

    }

   function userchanged() {

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

	//console.log("saving club number " + (clbNmbrs.selectedIndex + 1) + " and name: " + clubname.text)

        Funcs.writeclubs((clbNmbrs.selectedIndex +1) , clubname.text)

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


    Item {
        id: tumblerstuff
        width: 150
        height: 200
        anchors.left: parent.left
	anchors.top: parent.top
        anchors.topMargin: 50
          Tumbler {
           id: clubtumbler
           columns: [clbNmbrs]
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
	    color:"white"
	    text: Funcs.readclub(clbNmbrs.selectedIndex +1)
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
