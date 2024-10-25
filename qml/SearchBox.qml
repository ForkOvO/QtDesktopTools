
import QtQuick

Item {
    property string theme: "dark"
    property bool isFolded: true
    
    id: root
    width: isFolded ? 50 : 500
    height: isFolded ? 50 : (50 + suggestionList.model.count * 50)
    clip: true

    onWidthChanged: if (width === 50) searchInput.focus = false // 折叠后取消编辑

    Behavior on width {
        NumberAnimation {
            duration: 500
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 500
        }
    }

    MouseArea{ // 进入区域展开侧边栏 离开折叠
        anchors.fill: parent
        hoverEnabled: true // 鼠标悬停
        propagateComposedEvents: true // 事件传播
        onEntered: root.isFolded = false
    }

    Image { // 搜索按钮
        id: searchBtn
        width: 50
        height: 50
        anchors.right: parent.right
        source: root.theme === "dark" ? "qrc:/res/search.png" : "qrc:/res/search_black.png"

        MouseArea{
            anchors.fill: parent
            onClicked: Qt.openUrlExternally("https://cn.bing.com/search?q=" + searchInput.text)
        }
    }

    Rectangle{ // 输入框
        height: 50
        anchors.left: parent.left
        anchors.right: searchBtn.left
        color: "transparent"
        border.color: root.theme === "dark" ? "#ffffff" : "#000000"
        clip: true

        TextInput{
            id: searchInput
            anchors.fill: parent
            verticalAlignment: Qt.AlignVCenter
            font.pixelSize: height * 0.5
            color: root.theme === "dark" ? "#ffffff" : "#000000"
            clip: true
            anchors.margins: 5
            // 按下回车键搜索
            Keys.onEnterPressed: Qt.openUrlExternally("https://cn.bing.com/search?q=" + searchInput.text)
            Keys.onReturnPressed: Qt.openUrlExternally("https://cn.bing.com/search?q=" + searchInput.text)

            onTextChanged: { // 输入框内容改变时获取关键字建议
                suggestionList.model.clear() // 清空建议列表
                if (searchInput.text.length === 0) return
                let xhr = new XMLHttpRequest()
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                        var data = xhr.responseText
                        // console.log(data)
                        var list = data.match(/".*?"/g) // 匹配所有双引号中的内容
                        // console.log(list)
                        for (var i = 1; i < list.length; i++) { // 跳过第一个元素 问题本身
                            suggestionList.model.append({modelData: list[i].substring(1, list[i].length - 1)}) // 去掉双引号
                        }
                    }
                }
                xhr.open("GET", "https://suggestion.baidu.com/su?p=3&ie=UTF-8&cb=&wd=" + searchInput.text)
                xhr.send()
            }
        }
    }

    ListView { // 关键字建议列表
        id: suggestionList
        y: 50
        width: root.width
        height: suggestionList.model.count * 50
        model: ListModel{}
        delegate: Rectangle{
            width: suggestionList.width
            height: 50
            color: root.theme === "dark" ? "#20ffffff" : "#20000000"
            clip: true
            Text{
                x: 5
                anchors.verticalCenter: parent.verticalCenter
                text: modelData
                font.pixelSize: height * 0.8
                color: root.theme === "dark" ? "#ffffff" : "#000000"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: suggestionList.currentIndex = index
                onClicked: Qt.openUrlExternally("https://cn.bing.com/search?q=" + modelData)
            }
        }
        highlight: Rectangle {
            color: root.theme === "dark" ? "#20ffffff" : "#20000000"
        }
    }
}