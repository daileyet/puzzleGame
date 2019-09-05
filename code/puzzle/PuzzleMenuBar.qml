import QtQuick 2.0
import QtQuick.Controls 2.5
MenuBar {
    Menu {
        title: qsTr("Action")
        Action { text: qsTr("Load") }
        Action { text: qsTr("Start") }
        MenuSeparator { }
        Action { text: qsTr("Quit") }
    }

    Menu{
        title: qsTr("Languange")
        Action {
            text: qsTr("Chinese");
            checkable:true;
            checked:true;
        }
        Action {
            text: qsTr("English") ;
            checkable: true;
        }
    }

}
