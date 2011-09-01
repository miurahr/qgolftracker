import QtQuick 1.0
import com.meego 1.0
import com.nokia.extras 1.0

import Qt 4.7
import "../functions.js" as Funcs

Page {
    id: editcoursespage
    orientationLock: PageOrientation.LockPortrait

    property int oldhole

    Component.onCompleted: firstinit()


    function savedata() {
        var coursename = courseeditselection.model.get(courseeditselection.selectedIndex).name
        var holenumber = holeNmbrs.selectedIndex
        holenumber ++
        var number = Funcs.readcourse("id", coursename, holenumber)
        var par = parNmbrs.selectedIndex
        par += 3
        var hcp = hcpNmbrs.selectedIndex
        hcp ++

        console.log("writing id: " + number + " coursename: " + coursename + ", holenumber: " + holenumber + ", par: " + par + ", hcp: " + hcp + " to table!")
        Funcs.writecourse("update", number, coursename, holenumber, par, hcp)
        savebutton.visible= false

    }


    function opendialog() {

        oldhole = 1

        //open dialog
        appWindow.coursesinitiated = true
        courseeditselection.open()
    }

    function thumblerchanged() {
        //reload thumbler data!

        //console.log(holeNmbrs.selectedIndex)
        var name = courseeditselection.model.get(courseeditselection.selectedIndex).name
        var hole = holeNmbrs.selectedIndex
        hole ++

        if (hole !== oldhole) {

        //get par
        var par = Funcs.getpar(name, hole)

        //get hcp
        var hcp = Funcs.gethcp(name, hole)

        //correct hcp to correspond selectedindex. 0=1, 1=2 etc
        hcp --

        //set thumbler according to holes par and hcp
        parNmbrs.selectedIndex = par
        hcpNmbrs.selectedIndex = hcp

        //show savebutton
        savebutton.visible = true

        }
        //only par or hcp changed, do nothing except remember the latest holenumber
        oldhole = hole
    }

    function del() {

        //delete course

        appWindow.coursesinitiated = false
    Funcs.removecourse(courseeditselection.model.get(courseeditselection.selectedIndex).name)
        savebutton.visible = false
        repopulatecourses()

    }

    function firstinit() {

        Funcs.populatehcp()
        Funcs.populatecourses(false)
        populateholes()
        oldhole = 0



    }

    function populateholes(){

        holeNumbers.clear()
        Funcs.populateholes(courseeditselection.model.get(courseeditselection.selectedIndex).name)
    }

    function repopulatecourses() {
        //delete stuff
        courseModel.clear()


        mainPage.reinitmodel()

        //populate again
        Funcs.populatecourses(false)


    }

    function courseselected() {

        if (courseeditselection.model.get(courseeditselection.selectedIndex).name == "Add course") {
            //open the dialog
            addcoursedialog.open()
        }

        tumblerwidget.visible = true

        //what has been populated by now?!?
        //thumber except holes!!

        populateholes()

        appWindow.coursesinitiated = true


        //repopulate()
        //populateholes()



}


    function createcourse(name, amtofholes) {
        appWindow.coursesinitiated = false

        console.log("will add course with name " + name + " and amnt of holes: " + amtofholes)
        for (var i=1; i < amtofholes + 1; i++ ) {
            Funcs.writecourse("","", name, i, 4,10)


            //Funcs.writecourse()
        }
        repopulatecourses()
    }


    function cancelled(){
        coursename.closeSoftwareInputPanel()
        addcoursedialog.close()
    }

    function accepted() {
        coursename.closeSoftwareInputPanel()
        addcoursedialog.accept()
    }

    Dialog {
        id: addcoursedialog
        onAccepted: createcourse(coursename.text, hleamount.value)
        onRejected: cancelled()
        content: Item {
            id: dialogitem
            //height: parent.height - 150
            height: 300
            width: parent.width
            anchors.topMargin: 200

            Column{
                spacing: 10


            TextInput {
                id: coursename
                color: "White"
                height: 150
                width: 400
                font.pointSize: 20
                onAccepted:coursename.closeSoftwareInputPanel
                text: "Name of the course"
                //onFocusChanged: coursename.closeSoftwareInputPanel
                selectByMouse: true
                cursorVisible: true
                //coursename.
            }
            //}
            Text {
                id: explan
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                //width: parent.width
                height: 25
                color: "White"
                //anchors.top: coursename.bottom
                //anchors.topMargin: 50
                font.pointSize: 15
                text: "Amount of holes :" + hleamount.value
            }
            Slider {
                id: hleamount
                //anchors.top:  explan.bottom
                //anchors.topMargin: 10
                height: 50
                width: parent.width -150
                //anchors.centerIn: parent.horizontalCenter
                //anchors.top: explan.bottom
                //anchors.bottomMargin: 50
                minimumValue: 9
                maximumValue:  36
                stepSize: 9
                valueIndicatorVisible: true

            }

            }
}
        //}

        buttons: ButtonRow {

            width: parent.width

            Button {
                text: "Ok"
                onClicked: accepted()
            }
            Button {
                text: "Cancel"
                onClicked: cancelled()




        }


    }
    }

    ListModel {
        id: holeNumbers

    }
    TumblerColumn {
        id: holeNmbrs
        selectedIndex: 1
        items: holeNumbers

    }

    ListModel {
        id:parNumbers
        ListElement{ value: 3 }
        ListElement{ value: 4 }
        ListElement{ value: 5 }
    }
    TumblerColumn {
        id: parNmbrs
        selectedIndex: 1
        items: parNumbers
    }

    ListModel {
        id:hcpNumbers

    }

        TumblerColumn {
            id: hcpNmbrs
            selectedIndex: 1
            items: hcpNumbers
        }

    SelectionDialog {
        id: holeeditselection
        titleText: "Select hole"
        selectedIndex: 0
        onAccepted: updateholedata()
        model:  ListModel {
            id:holeModel
        }
    }

    SelectionDialog {
        id: courseeditselection
        titleText: "Select course"
        selectedIndex: 0
        onAccepted: courseselected()
        model: ListModel {

            id:courseModel

        }
    }



        Button {
            id: courseeditselectionButton
            width: parent.width
            height: 75
            anchors.top: parent.top
            anchors.left: parent.left
            text: appWindow.coursesinitiated ? courseeditselection.model.get(courseeditselection.selectedIndex).name : "Select course"
            onClicked: opendialog()


        }
        Item {
            id: tumblerwidget
            anchors.top: courseeditselectionButton.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            height: 300
            width: parent.width
            visible: false

        Tumbler {
            id: edittumbler
            //anchors.top: courseeditselectionButton.bottom
            //anchors.centerIn: parent.centerIn
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.left: parent.left
            //height: 100
            //width: 400
            columns: [holeNmbrs, parNmbrs, hcpNmbrs]
            //columns: [holenumber, par, hcp]
            onChanged: thumblerchanged()

        }
}
        Text {
            id: alldata
            font.pointSize: 20
            anchors.top: tumblerwidget.bottom
            anchors.left: parent.left
            width: parent.width
            //height: 400
            text: "JOU!"
            visible: false
        }

        Button {
            id: savebutton
            text: "Save"
            anchors.bottom: exitbutton.top
            anchors.left:  parent.left
            width: parent.width
            visible: false
            height: 75
            onClicked: savedata()
            //onClicked: console.log("now there should be save function somewhere..")
        }

        Button {
            id: exitbutton
            text: "Exit"
            anchors.bottom:  parent.bottom
            anchors.left: parent.left
            width: parent.width
            height: 75
            onClicked: appWindow.pageStack.pop(mainPage, null, false)
            //onClicked: console.log("now the main page open please!")
        }

        Button {
            id: eraser
            width: parent.width

            height: 75
            anchors.bottom: savebutton.top
            anchors.bottomMargin: 50
            text: "Delete course"
            onClicked: del()

        }
        Button {
            id: newcourse
            height: 75
            anchors.bottom: eraser.top
            anchors.bottomMargin: 50
            text: "Add new course"
            onClicked: addcoursedialog.open()


        }


}

