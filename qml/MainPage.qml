import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import Qt 4.7

import "../functions.js" as Funcs


Page {
    orientationLock: PageOrientation.LockPortrait
    id: mainPage
    tools: commonTools
    property bool populated
    populated: {false}

    //background

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        z:0
        color: "white"
    }


    Component.onCompleted: checkclubs()



    function checkclubs() {
        console.log("readclub(clubamount) = " + Funcs.readclub("clubamount"))
        if (Funcs.readclub("clubamount")===0) {
            console.log("no clubs defined")
            startButton.enabled = false
            clubsnotdefined.visible = true
        }

    }



    function reinitmodel() {

        courseModel.clear()
        mainPage.populated = false

    }

    function updatecourse() {
        console.log("updatecourse called")

        if (!populated) {
            console.log("not populated")
            populated = true
            Funcs.populatecourses(true)
        }

        courseselection.open()
        appWindow.coursesinitiated = true

}

    function enterrecmode() {
        if (!appWindow.coursesinitiated) {
            nocourseselected.show()
        }

        if (Funcs.readclub("clubamount")===0) {
            noclubs.show()
            startButton.enabled = false
            clubsnotdefined.visible = true
        }


        else{

            if (Funcs.readclub("clubamount") < 1) {
                appWindow.pageStack.push(Qt.resolvedUrl("EditClubs.qml"))
            }

            else {

        //console.log("selected index: " + courseselection.model.get(courseselection.selectedIndex).name)

        appWindow.course = courseselection.model.get(courseselection.selectedIndex).name
        appWindow.courseholes = Funcs.readcourse("amount", courseselection.model.get(courseselection.selectedIndex).name,"","")
        commonTools.visible = false
        appWindow.pageStack.push(Qt.resolvedUrl("RecPage.qml"))
}
        }
    }

    function checkforedit() {
        //console.log("checking if user wants to edit courses")
        if (appWindow.course = courseselection.model.get(courseselection.selectedIndex).name == "Add course") {
           // console.log("now there should be edit page that pops open")
            appWindow.coursesinitiated = false
            appWindow.pageStack.push(Qt.resolvedUrl("EditCourses.qml"))
        }
            else {
            //console.log("false alarm")

    }
    }


    InfoBanner {
        id: nocourseselected
        z:2
        anchors.top: parent.top
        anchors.topMargin: 300
        timerEnabled: true
        timerShowTime: 5000
        text: "You must select a course first!"

    }

    InfoBanner {
        id: noclubs
        z:2
        anchors.top: parent.top
        anchors.topMargin: 350
        timerEnabled: true
        timerShowTime: 5000
        text: "You have no clubs defined!"

    }

    SelectionDialog {
        id: courseselection
        titleText: "Select course"
        selectedIndex: 0
        onAccepted: checkforedit()
        model: ListModel {

            id:courseModel

        }
    }



    Flow {

        id: settingsarea
        anchors.fill: parent
	anchors.leftMargin: 25
        spacing: 50
	Image{
            source: "qrc:/images/logo.svg"
            width: 400
            height: 100
            smooth: true
        }

        Text {
            //width: 400
            font.pointSize: 32
            text: "Course:"
        }

      Button {
          id: courseselectionButton
          width: 400
          text: appWindow.coursesinitiated ? courseselection.model.get(courseselection.selectedIndex).name : "Select course"

          onClicked: updatecourse()

      }

}


    Button {
        id: startButton
	text: "Start tracking"
        width: parent.width - 50
	anchors.left:  parent.left
	anchors.leftMargin: 25
	height: parent.height / 4
	anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 6
        onClicked: enterrecmode()
    }

    Rectangle {
        id: clubsnotdefined
        width: parent.width -50
        anchors.left: startButton.left
        anchors.bottom: startButton.top
        anchors.bottomMargin: 25
        height: 120
        visible: false

                Text {
                    id: explanation
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pointSize: 16
                    color: "Red"
                    text: "You have no clubs defined, you must have <br> at least one before you can start!"
                }

                Button {
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height - explanation.height
                    text: "Edit clubs"
                    onClicked: {appWindow.pageStack.push(Qt.resolvedUrl("EditClubs.qml")); clubsnotdefined.visible=false; startButton.enabled = true}
                }


    }


}

