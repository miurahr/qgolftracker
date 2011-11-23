import QtQuick 1.1
import com.nokia.meego 1.0
import "../functions.js" as Funcs

PageStackWindow {
    id: appWindow

    property string course
    property string courseholes
    property bool clubsinitiated
    clubsinitiated: {false}
    property bool clubstatinitiated
    clubstatinitiated: {false}
    property bool coursesinitiated
    coursesinitiated: {false}
    property bool holesinitiated
    holesinitiated: {false}
    initialPage: mainPage
    showStatusBar: false
    property int sessionidtemp

    MainPage {id: mainPage}



    function courseedit() {
	coursesinitiated = false
	appWindow.pageStack.push(Qt.resolvedUrl("EditCourses.qml"))
    }

    function clubedit() {
	clubsinitiated = false
	onClicked: appWindow.pageStack.push(Qt.resolvedUrl("EditClubs.qml"))
    }

    function openaboutscreen() {
        appWindow.pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
    }

    function openhelp() {
	appWindow.pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
    }


    ToolBarLayout {
        id: viewtools
        visible: false


	ToolIcon {
	    iconId: "toolbar-back"
	    onClicked: {appWindow.clubstatinitiated = false; appWindow.pageStack.pop(mainPage, null, false); }
	}

        TabButton {
            id: roundbutton
            height: parent.height

            width: 120
            text: "By round"
	    onClicked: {appWindow.clubstatinitiated = false; appWindow.pageStack.push(Qt.resolvedUrl("ViewPage.qml"))}
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
        id: viewtools2
        visible: false


        ToolIcon { iconId: "toolbar-back"; onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewPage.qml")); }

    }

    ToolBarLayout {
        id: commonTools
        visible: true


        TabButton {
            text: "View trackings"
            height: parent.height
            width: 400
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("ViewPage.qml"))

        }

        ToolIcon { platformIconId: "toolbar-view-menu";
             onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()


        }

    }
    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: "Edit clubs"
                onClicked: clubedit()
            }
            MenuItem {
                text: "Edit courses"
                onClicked: courseedit()

            }

	    MenuItem {
		text: "Help"
		onClicked: openhelp()
	    }

            MenuItem {
                text: "About"
                onClicked: openaboutscreen()
            }
    }
}
}

