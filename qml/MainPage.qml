import QtQuick 1.1
import com.meego 1.0
//import com.nokia.meego 1.0
import com.nokia.extras 1.0
import Qt 4.7

//import QtComponents 1.0
//import QtMobility.location 1.1

import "../functions.js" as Funcs

///
Page {
    orientationLock: PageOrientation.LockPortrait
    id: mainPage
    tools: commonTools
    //var item1 = "Placeholder!"
    //read club data
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


    function reinitmodel() {

        courseModel.clear()
        mainPage.populated = false

    }

    function updatecourse() {
        console.log("updatecourse called")
    //item1 = Funcs.readclub(1)
        //Funcs.readcourse("clear","","","")
        if (!populated) {
            console.log("not populated")
            populated = true
            Funcs.populatecourses(true)
        }

        courseselection.open()
        appWindow.coursesinitiated = true
        //kikkihiiri()
}

    function enterrecmode() {
        if (!appWindow.coursesinitiated) {
            //console.log("There was an error opening course database, FCK!")
            nocourseselected.show()
        }

        else{

        //console.log("selected index: " + courseselection.model.get(courseselection.selectedIndex).name)

        appWindow.course = courseselection.model.get(courseselection.selectedIndex).name
        appWindow.courseholes = Funcs.readcourse("amount", courseselection.model.get(courseselection.selectedIndex).name,"","")
        commonTools.visible = false
        appWindow.pageStack.push(Qt.resolvedUrl("RecPage.qml"))
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
        anchors.top: parent.top
        anchors.topMargin: 300
        timerEnabled: true
        timerShowTime: 5000
        text: "You must select a course first!"

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
        //anchors.top:  parent.top
        //anchors.topMargin: 50
        //anchors.
        anchors.leftMargin: 25
        spacing: 50
        //height: parent.height - 200

        /*Text {
            //width: 350
            width: parent.width
            //anchors.horizontalCenter: settingsarea.horizontalCenter
            height: 100
            font.pointSize: 50
            text: "qGolfTracker"

        }*/
        Image{
            source: "qrc:/images/logo.svg"
            width: 400
            height: 100
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
//appWindow.clubsinitiated ? clubselection.model.get(clubselection.selectedIndex).name : "Select club"
          onClicked: updatecourse()

      }

}

    Button {
        id: startButton
        text: "Start!"
        width: parent.width - 50
        //anchors.left : parent.left + 25
        anchors.left:  parent.left
        anchors.leftMargin: 25
        //anchors.centerIn: mainPage.Center
        height: parent.height / 4
        //anchors.topMargin: 100
        //anchors.top:settingsarea.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 6
        onClicked: enterrecmode()
    }


    }
//}
