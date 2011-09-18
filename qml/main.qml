import QtQuick 1.1
import com.meego 1.0
import "../functions.js" as Funcs


//icon: from http://www.flickr.com/photos/shimazu/5108692875/sizes/m/in/photostream/

//ab

PageStackWindow {
    id: appWindow

    property string course
    property string courseholes
    property bool clubsinitiated
    clubsinitiated: {false}
    property bool coursesinitiated
    coursesinitiated: {false}
    property bool holesinitiated
    holesinitiated: {false}
    initialPage: mainPage
    showStatusBar: false
    property int sessionidtemp

    MainPage {id: mainPage}



    //

    function courseedit() {
    coursesinitiated = false
    onClicked: appWindow.pageStack.push(Qt.resolvedUrl("EditCourses.qml"))
}
    function clubedit() {
    clubsinitiated = false
    onClicked: appWindow.pageStack.push(Qt.resolvedUrl("EditClubs.qml"))
    }


    ToolBarLayout {
        id: viewtools
        visible: false


        ToolIcon { iconId: "toolbar-back"; onClicked: appWindow.pageStack.pop(mainPage, null, false); }

        TabButton {
            id: roundbutton
            height: parent.height

            width: 120
            text: "By round"
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewPage.qml"))
        }

        TabButton {
            id: mapbutton
            height: parent.height
            width: 120
            text: "On map"
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewMapPage.qml"))
        }

        TabButton {
            id: clubbutton
            height: parent.height
            width: 120
            text: "By clubs"
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewbyclubsPage.qml"))

        }

    }

    ToolBarLayout {
        id: commonTools
        visible: true

        //ToolButtonRow {
           // id: toolrow
           // width: parent.width
            //anchors.right: parent===undefined ? undefined : parent.right
            //anchors.top:  parent==undefined ? undefined : parent.top
        TabButton {
            text: "View trackings"
            height: parent.height
            width: 400
            //iconSource: "toolbar-mediacontrol-play"
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewPage.qml"))

        }
        /*TabButton {
            text: "Home"
           height: parent.height
           width: parent.width / 3

            //pressed: true
            //iconSource: "toolbar-back"
            onClicked: appWindow.pageStack.pop(mainPage, null, false)

        }*/
        ToolIcon { platformIconId: "toolbar-view-menu";
             //anchors.right: parent===undefined ? undefined : parent.right
             onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()


        }

    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: "Edit clubs"
                //onClicked: appWindow.pageStack.push(Qt.resolvedUrl("EditClubs.qml"))
                onClicked: clubedit()
            }
            MenuItem {
                text: "Edit courses"
                onClicked: courseedit()
                //onClicked: appWindow.pageStack.push(Qt.resolvedUrl("EditCourses.qml"))
            }
            MenuItem {
                text: "Delete all data!"
                onClicked: Funcs.destroyall()
            }

    }
}
}

