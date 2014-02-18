import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 1.1

import robotology.yarp.scope 1.0
import robotology.yarp.view 1.0
import "qrc:/YarpScope/"
import "qrc:/YarpView/"

ApplicationWindow {
    id: window
    width: 360
    height: 360

    /*************************************************/
    menuBar: YarpScopeMenu{
        id: menu
    }

    toolBar: YarpScopeToolBar{
        id: toolBar
    }

    statusBar: YarpViewStatusBar{
        id: statusBar
    }

    Rectangle{
        id: mainContainer
        anchors.fill: parent

        VideoSurface{
            id: vSurface
            objectName: "YarpVideoSurface"
            x: 0
            y: 0
            width: mainContainer.width/2
            height: mainContainer.height
            dataArea: statusBar
            //menuHeight: menuH
        }

        QtYARPScopePlugin{
            x: mainContainer.width/2
            y: 0
            width: mainContainer.width/2
            height: mainContainer.height

            id: graph
            objectName: "YarpScope1"
        }


    }


    /*************************************************/

    function parseParameters(params){
        var ret = graph.parseParameters(params)

        vSurface.parseParameters(params)
        return ret
    }


    /**************************************************/

    Connections{
        target: vSurface
        onSetName:{
            statusBar.setName(name)
        }
    }

    Connections{
        target: toolBar
        onPlayPressed:{
            graph.playPressed(pressed)
        }
        onClear:{
            graph.clear()
        }
        onRescale:{
            graph.rescale()
        }
        onChangeInterval:{
            graph.changeInterval(interval)
        }
    }

    Connections{
        target: menu
        onPlayPressed:{
            graph.playPressed(pressed)
        }
        onClear:{
            graph.clear()
        }
        onRescale:{
            graph.rescale()
        }

        onAbout:{
            aboutDlg.visibility = Window.Windowed
        }
    }


    Connections{
        target: graph
        onIntervalLoaded:{
            toolBar.refreshInterval(interval)
        }
        onSetWindowPosition:{
            window.x = x
            window.y = y
        }
        onSetWindowSize:{
            window.width = w
            window.height = h
        }
    }

}