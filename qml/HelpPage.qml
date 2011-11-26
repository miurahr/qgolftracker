import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    orientationLock: PageOrientation.LockPortrait
    id: helpPage
    tools: viewtools

    Component.onCompleted: { roundbutton.visible = false; clubbutton.visible = false}

    Flickable {
	id: helparea
	anchors.top: parent.top
	anchors.left: parent.left
	anchors.leftMargin: 10
	width: parent.width
	height: parent.height
	contentHeight: 3050
	contentWidth: parent.width



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
		id: title1
		font.pointSize: 24
		text: "Main screen"
	    }

	    Text {
		id: explanation1
		font.pointSize: 16
		width: 420
		wrapMode: Text.WordWrap
		text: "In main screen you can start tracking, review past trackings or access settings. <br> "
	    }


	    Text {
		id: title2
		font.pointSize: 24
		text: "Tracking"
	    }

	    Text {
		id: explanation2
		font.pointSize: 16
		width: 420
		wrapMode: Text.WordWrap
		text: "Before you can start tracking, you'll have to have 1) course and 2) clubs defined. When " +
		      "you have club(s) and course(s) defined, you can start tracking just by choosing the " +
		      "course and pressing 'Start tracking' -button <br><br>" +
		      "In tracking screen, you choose the club you will use/have used and press 'Hit' -button " +
		      "at the hitting position. When you have potted the ball, you must press the" +
		      "'Potted' -button when positioned next to the hole!<br>" +
		      "The position is saved at the location where you have pushed the button.<br><br>" +
		      "You can also undo last operation, pocket the ball (in point game only) or abort tracking completely.<br>" +
		      "Aborting will remove everything tracked within the session!"

	    }


	    Text {
		id: title3
		font.pointSize: 24
		text: "Editing clubs and/or courses"
	    }

	    Text {
		id: explanation3
		font.pointSize: 16
		width: 420
		wrapMode: Text.WordWrap
		text: "You can access club- and course editing views from the toolbar of main view. <br>" +
		      "In club editing view there is a tumbler with what you can choose the corrent number " +
		      "of the club and next to it is a text field. You must press enter after entering the club name in "+
		      "order to be able to save the club. You can also delete a club. Remember to save changes!<br>" +
		      "You can verify the list of the clubs from the list below. It contains the values stored in the database." +
		      "Note: the clubs will be rearranged if there are blank numbers with nothing assigned! <br><br>" +
		      "In course editing view you can either choose an existing course or add a new course. " +
		      "Once you have selected an existing course, you'll be able to either delete it completely or " +
		      "edit course. <br>" +
		      "When you want to add a new course, a dialog appears and you must input the name of the course and " +
		      "amount of the holes (9/18) in the course. You can have the same course set up twice as long as " +
		      "the names are different. Add for example f9 (front 9) to the end. <br>" +
		      "The first tumbler is hole number, second one is par of the hole and third one is HPC. " +
		      "When switching the hole, the par and HCP tumblers will rearrange into the values saved to the " +
		      "hole earlier. After selecting the hole, you can select par and HCP. <br>" +
		      "Remember to save before switching hole!"

	    }




	    Text {
		id: title4
		font.pointSize: 24
		text: "Viewing trackings"
	    }

	    Text {
		id: explanation4
		font.pointSize: 16
		width: 420
		wrapMode: Text.WordWrap
		text: "You can start viewing the trackings by tapping the 'View trackings' menu item in the bottom of the main screen. <br> " +
		      "Then you can view trackings either by round (opened by default) or by club. You can select the desired <br>" +
		      "mode from menu items in the bottom of the screen. <br><br>" +
		      "When viewing by round, you have list of rounds on screen.<br>" +
		      "You can choose the round and you get a dialog asking if you want to view the round either in map or as detailed list. <br>" +
		      "When viewing in map, you can navigate map by dragging the screen and zoom in/out with buttons in the top <br> " +
		      "of the screen. <br>" +
		      "When viewing by list, you get detailed list of hits, sectioned by the hole.<br><br>"+

		      " Tip: drag the right edge of screen up/down if you have long list of trackings/hits in order to scroll them through faster. <br>" +
		      "Be careful not to trigger swipe actions though!<br><br>" +
		      "When viewing by clubs, you'll only need to select the club you want and stats for the club are generated. For now stats are following:" +
		      "amount of hits, shortest hit length, longest hit length and average hit length"

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
}
