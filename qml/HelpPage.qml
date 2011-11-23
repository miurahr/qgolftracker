import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    orientationLock: PageOrientation.LockPortrait
    id: helpPage
    tools: viewtools

    Component.onCompleted: { roundbutton.visible = false; clubbutton.visible = false}

    Column {
	spacing: 50

	Image{
	    source: "qrc:/images/logo.svg"
	    width: 400
	    height: 100
	    smooth: true
	}
	Text {
	    id: title
	    font.pointSize: 40
	    text: "qGolfTracker help"
	}

	Text {
	    id: version
	    font.pointSize: 20
	    text: "Here will be some help text"
	}

	/*Text {
	    id: information
	    font.pointSize: 15
	    width: parent.width
	    text: "Written by: Timo Pelkonen (peltsip@gmail.com) <br><br>All source code available at:<br>https://www.gitorious.org/qgolftracker<br><br>I take no responsibility for anything (legal part)<br><br>You have installed the package from your free will,<br> I hope you enjoy it!"

	}*/
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
    }
}
