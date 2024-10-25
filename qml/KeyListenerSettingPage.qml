
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import ten.util.CacheManager

Item {
    property var showKeyObject: null // 显示按键的窗口
    property color backgroundColor: "#80808080" // 背景颜色
    property color keyColor: "#80C0C0C0" // 按键颜色
    property color textColor: "black" // 字体颜色
    property int stayTime: 3000 // 按键停留时间
    property int locationIndex: 6 // 按键位置
    property string theme: "dark" // 主题

    id: root
    
    // 属性修改信号
    onBackgroundColorChanged: setProgressBar("backgroundColor", backgroundColor)
    onKeyColorChanged: setProgressBar("keyColor", keyColor)
    onTextColorChanged: setProgressBar("textColor", textColor)
    onStayTimeChanged: setProgressBar("stayTime", stayTime)
    onLocationIndexChanged: setProgressBar("locationIndex", locationIndex)

    function setProgressBar(key, value){
        cacheManager.changeCache(key, value)
        root.setShowKeyObjectStyle()
    }

    function setShowKeyObjectStyle(){
        if (root.showKeyObject !== null)
            root.showKeyObject.setStyle(root.backgroundColor, root.keyColor, root.textColor, root.stayTime, root.locationIndex)
    }

    CacheManager{
        id: cacheManager
        Component.onCompleted: {
            var settingCache = cacheManager.loadCache('keyListenerSetting.json')
            root.backgroundColor = settingCache['backgroundColor']
            root.keyColor =  settingCache['keyColor']
            root.textColor = settingCache['textColor']
            root.stayTime = settingCache['stayTime']
            root.locationIndex = settingCache['locationIndex']
        }
    }

    Column{
        spacing: 20

        Row{ // 开关 位置 重置
            spacing: 10

            Rectangle{ // 按键预览及启动关闭
                property bool isOpen: false

                id: startRect
                width: 120
                height: 120
                radius: 30
                color: root.backgroundColor

                Rectangle{
                    width: 96
                    height: 96
                    radius: 30
                    anchors.centerIn: parent
                    color: root.keyColor

                    Text {
                        text: startRect.isOpen ? "关闭" : "打开"
                        anchors.centerIn: parent
                        color: root.textColor
                        font.pixelSize: 24
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (startRect.isOpen){
                            root.showKeyObject.destroy()
                            root.showKeyObject = null
                        }else{
                            var component = Qt.createComponent("qrc:/qml/ShowPressedKey.qml");
                            var object = component.createObject();
                            root.showKeyObject = object
                            root.setShowKeyObjectStyle()
                            object.show()
                        }
                        startRect.isOpen = !startRect.isOpen
                    }
                }
            }

            GridView{ // 位置
                id: locationGrid
                width: 120
                height: 120
                cellWidth: 40
                cellHeight: 40
                interactive: false // 禁止滑动
                currentIndex: root.locationIndex

                model: ListModel{
                    ListElement{content: "↖"}
                    ListElement{content: "↑"}
                    ListElement{content: "↗"}
                    ListElement{content: "←"}
                    ListElement{content: "·"}
                    ListElement{content: "→"}
                    ListElement{content: "↙"}
                    ListElement{content: "↓"}
                    ListElement{content: "↘"}
                }

                delegate: Rectangle{
                    width: 40
                    height: 40
                    radius: 15
                    color: "#80808080"

                    Text {
                        text: content
                        anchors.centerIn: parent
                        color: root.theme === "dark" ? "white" : "black"
                        font.pixelSize: 15
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            locationGrid.currentIndex = index
                            root.locationIndex = index
                            root.setShowKeyObjectStyle()
                        }
                    }
                }

                highlight: Rectangle{
                    width: 40
                    height: 40
                    radius: 15
                    color: "#C0C0C0"
                }
            }

            Button{ // 重置
                anchors.bottom: parent.bottom
                width: 50
                height: 25
                text: "reset"
                background: Rectangle{
                    color: "red"
                    border.color: Qt.lighter(color)
                    radius: height / 2
                }
                onClicked: {
                    root.backgroundColor = "#80808080"
                    root.keyColor = "#80C0C0C0"
                    root.textColor = "black"
                    root.stayTime = 3000
                    locationGrid.currentIndex = 6
                    root.locationIndex = 6
                }
            }
        }

        Row{ // 背景
            spacing: 10

            Text {
                font.pixelSize: 30
                color: root.theme === "dark" ? "white" : "black"
                text: "背景"
            }

            Button{
                width: 40
                height: 40
                background: Rectangle{
                    id: backgroundColorRect
                    radius: 10
                    color: root.backgroundColor
                    border.color: root.theme === "dark" ? "white" : "black"
                }
                onClicked: root.backgroundColor = backgroundColorRect.color
            }

            Rectangle{
                width: 200
                height: 40
                radius: height / 2
                color: "transparent"
                border.color: root.theme === "dark" ? "white" : "black"

                TextInput{
                    anchors.fill: parent
                    font.pixelSize: height * 0.5
                    font.family: "华文彩云"
                    color: root.theme === "dark" ? "white" : "black"
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    clip: true
                    text: root.backgroundColor
                    onTextChanged: backgroundColorRect.color = text
                }
            }
        }

        Row{ // 按钮
            spacing: 10

            Text {
                font.pixelSize: 30
                color: root.theme === "dark" ? "white" : "black"
                text: "按钮"
            }

            Button{
                width: 40
                height: 40
                background: Rectangle{
                    id: keyColorRect
                    radius: 10
                    color: root.keyColor
                    border.color: root.theme === "dark" ? "white" : "black"
                }
                onClicked: root.keyColor = keyColorRect.color
            }

            Rectangle{
                width: 200
                height: 40
                radius: height / 2
                color: "transparent"
                border.color: root.theme === "dark" ? "white" : "black"

                TextInput{
                    anchors.fill: parent
                    font.pixelSize: height * 0.5
                    font.family: "华文彩云"
                    color: root.theme === "dark" ? "white" : "black"
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    clip: true
                    text: root.keyColor
                    onTextChanged: keyColorRect.color = text
                }
            }
        }

        Row{ // 文字
            spacing: 10

            Text {
                font.pixelSize: 30
                color: root.theme === "dark" ? "white" : "black"
                text: "文字"
            }

            Button{
                width: 40
                height: 40
                background: Rectangle{
                    id: textColorRect
                    radius: 10
                    color: root.textColor
                    border.color: root.theme === "dark" ? "white" : "black"
                }
                onClicked: root.textColor = textColorRect.color
            }

            Rectangle{
                width: 200
                height: 40
                radius: height / 2
                color: "transparent"
                border.color: root.theme === "dark" ? "white" : "black"

                TextInput{
                    anchors.fill: parent
                    font.pixelSize: height * 0.5
                    font.family: "华文彩云"
                    color: root.theme === "dark" ? "white" : "black"
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    clip: true
                    text: root.textColor
                    onTextChanged: textColorRect.color = text
                }
            }
        }

        Row{ // 时间
            spacing: 10

            Text {
                font.pixelSize: 30
                color: root.theme === "dark" ? "white" : "black"
                text: "时间"
            }

            Slider{
                id: timeSlider
                width: 300
                height: 40
                from: 1000
                to: 5000
                stepSize: 1000
                snapMode: Slider.SnapAlways
                value: root.stayTime
                onValueChanged: root.stayTime = value

                background: Rectangle {
                    width: timeSlider.availableWidth
                    height: 40
                    radius: 5
                    color: "gray"
                    border.color: "black"

                    Rectangle {
                        width: timeSlider.visualPosition * parent.width
                        height: parent.height
                        color: "white"
                        border.color: "black"
                        radius: 5
                    }
                }

                handle: Rectangle {
                    x: timeSlider.visualPosition * (timeSlider.availableWidth - width)
                    width: 40
                    height: 40
                    radius: 5
                    color: timeSlider.pressed ? "#D0D0D0" : "white"
                    border.color: "black"

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 10
                        color: "black"
                        text: timeSlider.value / 1000 + "s"
                    }
                }
            }
        }
    }
}
