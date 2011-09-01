import QtQuick 1.0
import com.meego 1.0
import Qt 4.7
import "../functions.js" as Funcs

Page {
    id: eclubs
    orientationLock: PageOrientation.LockPortrait

    function save() {
        if (club1.text != "") {
            console.log("yous houdl write club 1")
            Funcs.writeclubs(1, club1.text)
        }
        else {
            console.log("club1 is empty, you should remove it!")
        }

        if (club2.text != "") {
            console.log("yous houdl write club 2")
            Funcs.writeclubs(2, club2.text)
        }
        else {
            console.log("club2 is empty, you should remove it!")
        }

        if (club3.text != "") {
            console.log("yous houdl write club 3")
            Funcs.writeclubs(3, club3.text)
        }
        else {
            console.log("club3 is empty, you should remove it!")
        }

        if (club4.text != "") {
            console.log("yous houdl write club 4")
            Funcs.writeclubs(4, club4.text)
        }
        else {
            console.log("club4 is empty, you should remove it!")
        }

        if (club5.text != "") {
            console.log("yous houdl write club 5")
            Funcs.writeclubs(5, club5.text)
        }
        else {
            console.log("club5 is empty, you should remove it!")
        }

        if (club6.text != "") {
            console.log("yous houdl write club 6")
            Funcs.writeclubs(6, club6.text)
        }
        else {
            console.log("club6 is empty, you should remove it!")
        }

        if (club7.text != "") {
            console.log("yous houdl write club 7")
            Funcs.writeclubs(7, club7.text)
        }
        else {
            console.log("club7 is empty, you should remove it!")
        }

        if (club8.text != "") {
            console.log("yous houdl write club 8")
            Funcs.writeclubs(8, club8.text)
        }
        else {
            console.log("club8 is empty, you should remove it!")
        }

        if (club9.text != "") {
            console.log("yous houdl write club 9")
            Funcs.writeclubs(9, club9.text)
        }
        else {
            console.log("club9 is empty, you should remove it!")
        }

        if (club10.text != "") {
            console.log("yous houdl write club 10")
            Funcs.writeclubs(10, club10.text)
        }
        else {
            console.log("club10 is empty, you should remove it!")
        }

        if (club11.text != "") {
            console.log("yous houdl write club 11")
            Funcs.writeclubs(11, club11.text)
        }
        else {
            console.log("club11 is empty, you should remove it!")
        }

        if (club12.text != "") {
            console.log("yous houdl write club 12")
            Funcs.writeclubs(12, club12.text)
        }
        else {
            console.log("club12 is empty, you should remove it!")
        }

        if (club13.text != "") {
            console.log("yous houdl write club 13")
            Funcs.writeclubs(13, club13.text)
        }
        else {
            console.log("club13 is empty, you should remove it!")
        }

        if (club14.text != "") {
            console.log("yous houdl write club 14")
            Funcs.writeclubs(14, club14.text)
        }
        else {
            console.log("club14 is empty, you should remove it!")
        }

    }

    function cancel() {
        console.log("club editing cancelled")
    appWindow.pageStack.pop(mainPage, null, false)
    }

Flickable {
    id: flickablething

    width: parent.width
    height: parent.height
    contentHeight: 900
    contentWidth:  500

    Rectangle {
        width: 450
        height: 850


    Grid {
        //columns: 4
        id: settingsflow
        columns: 2
        spacing: 10
        width: parent.width
        height: parent.height - 150
        anchors.fill: parent
        //1
        Text {
            id: title1
            font.pointSize: 30
            height: 50
            width: 50
            text: "1: "
        }

        TextInput {
            id: club1
            font.pointSize: 30
            height: 50
            width: 390
            onAccepted: club1.closeSoftwareInputPanel();
            //width: 350
            //width: 300 + 50 * 850 / parent.width
            //400 when page width = 450
            //350 when page width = 850
            //width:  150
            text: Funcs.readclub(1)
        }
        //OK!
       /* Rectangle {
            width: 50
            height: 50
        }*/

            //2
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title2
                text: "2: "
            }

            TextInput {
                id: club2
                font.pointSize: 30
                height: 50
                width: 390
                //width: 350
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(2)
                onAccepted: club2.closeSoftwareInputPanel();
            }


            //3
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title3
                text: "3: "
            }

            TextInput {
                id: club3
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(3)
                onAccepted: club3.closeSoftwareInputPanel();
            }

            //4
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title4
                text: "4: "
            }

            TextInput {
                id: club4
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(4)
                onAccepted: club4.closeSoftwareInputPanel();
            }
            //OK!

            //5
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title5
                text: "5: "
            }

            TextInput {
                id: club5
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(5)
                onAccepted: club5.closeSoftwareInputPanel();
            }
            //OK

            //6
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title6
                text: "6: "
            }

            TextInput {
                id: club6
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(6)
                onAccepted: club6.closeSoftwareInputPanel();
            }
            //OK
            //7
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title7
                text: "7: "
            }

            TextInput {
                id: club7
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(7)
                onAccepted: club7.closeSoftwareInputPanel();
            }
            //OK

            //8

            Text {
                font.pointSize: 30
                height: 50
                id: title8
                width: 30
                text: "8: "
            }

            TextInput {
                id: club8
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(8)
                onAccepted: club8.closeSoftwareInputPanel();
            }
            //OK!

            //9
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title9
                text: "9: "
            }

            TextInput {
                id: club9
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(9)
                onAccepted: club9.closeSoftwareInputPanel();
            }
            //OK

            //OK
            //10
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title10
                text: "10: "
            }

            TextInput {
                id: club10
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(10)
                onAccepted: club10.closeSoftwareInputPanel();
            }
            //OK


            //11
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title11
                text: "11: "
            }

            TextInput {
                id: club11
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(11)
                onAccepted: club11.closeSoftwareInputPanel();
            }
            //OK

            //12
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title12
                text: "12: "
            }

            TextInput {
                id: club12
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(12)
                onAccepted: club12.closeSoftwareInputPanel();
            }
            //OK

            //13
            Text {
                font.pointSize: 30
                height: 50
                width: 50
                id: title13
                text: "13: "
            }

            TextInput {
                id: club13
                font.pointSize: 30
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(13)
                onAccepted: club13.closeSoftwareInputPanel();
            }
            //OK

            //14
            Text {
                //width: parent.width / 8
                font.pointSize: 30
                height: 50
                width: 50
                id: title14
                text: "14: "
            }

            TextInput {
                id: club14
                font.pointSize: 30
                //width: parent.width * 3 / 8
                height: 50
                width: 390
                //width: 300 + 50 * 850 / parent.width
                text: Funcs.readclub(14)
                onAccepted: club14.closeSoftwareInputPanel();
            }

/*
            Rectangle {
                width: 50
                height: 50
            }*/
            //OK
/*


*/
}
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
