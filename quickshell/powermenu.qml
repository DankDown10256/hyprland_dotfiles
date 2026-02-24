import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// Power menu style Gruvbox

PanelWindow {
    id: win
    WlrLayershell.namespace: "power-menu"

    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"

    focusable: true
    Component.onCompleted: win.requestActivate()

    WlrLayershell.exclusiveZone: -1
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrLayerKeyboardFocus.Exclusive

    // Theme + Images
    property bool isDarkMode: true
    property url imgDark: Qt.resolvedUrl("/home/lucas/current_wallpaper/background.jpg")
    property url imgLight: Qt.resolvedUrl("/home/lucas/current_wallpaper/background.jpg")

    Process {
        id: themeCheck
        command: ["cat", "/home/snes/.cache/quickshell/theme_mode"]
        running: true
        stdout: StdioCollector {
            onTextChanged: {
                const mode = text.trim()
                win.isDarkMode = (mode !== "light")
                themeCheck.running = false
            }
        }
    }

    QtObject {
        id: theme
        // --- PALETTE GRUVBOX ---
        property color card: win.isDarkMode ? "#282828" : "#fbf1c7"       // bg0 / fg0
        property color tile: win.isDarkMode ? "#3c3836" : "#ebdbb2"       // bg1 / fg1
        property color tileHover: win.isDarkMode ? "#504945" : "#d5c4a1"  // bg2 / fg2
        property color text: win.isDarkMode ? "#ebdbb2" : "#3c3836"       // fg / bg
        property color accent: win.isDarkMode ? '#b8bb26' : "#79740e"     // Green
        property color danger: win.isDarkMode ? "#fb4934" : "#9d0006"     // Red
        property color activeText: win.isDarkMode ? "#282828" : "#fbf1c7" // Contrast text
        property color border: win.isDarkMode ? "#665c54" : "#bdae93"     // bg4 / fg4
        property url activeImg: win.isDarkMode ? win.imgDark : win.imgLight
    }

    // Uptime/user
    Process {
        id: sysInfo
        command: ["bash", "-c", "whoami; uptime -p | sed 's/up //'"]
        running: true
        stdout: SplitParser {
            onRead: (data) => {
                const d = data.trim()
                if (d === "") return
                if (/^\d/.test(d)) uptime.text = d
                else userName.text = "@" + d
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: win.isDarkMode ? "#CC1d2021" : "#CCf9f5d7" // Background dim (bg0_h)

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.pendingCmd !== "") {
                    root.pendingCmd = ""
                    root.confirmIndex = 1
                    root.forceActiveFocus()
                } else {
                    Qt.quit()
                }
            }
        }
    }

    FocusScope {
        id: root
        width: 400
        height: 300
        
        x: Math.round((parent.width - width) / 2)
        y: Math.round(((parent.height - height) / 2) + ((1 - Math.min(1, intro)) * 60))
        
        focus: true

        property real intro: 0
        property real introBlur: 18

        SequentialAnimation {
            running: true
            ParallelAnimation {
                PropertyAnimation {
                    target: root
                    property: "intro"
                    from: 0
                    to: 1
                    duration: 260
                    easing.type: Easing.OutExpo
                }
                PropertyAnimation {
                    target: root
                    property: "introBlur"
                    from: 18
                    to: 0
                    duration: 260
                    easing.type: Easing.OutCubic
                }
            }
            PropertyAnimation {
                target: root
                property: "intro"
                from: 1
                to: 1.06
                duration: 90
                easing.type: Easing.OutQuad
            }
            PropertyAnimation {
                target: root
                property: "intro"
                from: 1.06
                to: 1
                duration: 140
                easing.type: Easing.OutCubic
            }
            ScriptAction { script: root.forceActiveFocus() }
        }

        opacity: Math.min(1, intro)
        scale: 0.88 + (0.12 * Math.min(1, intro))

        Keys.enabled: true
        Keys.priority: Keys.BeforeItem
        activeFocusOnTab: true

        Component.onCompleted: {
            root.forceActiveFocus()
            Qt.callLater(() => root.forceActiveFocus())
        }

        property int currentIndex: 0
        property int confirmIndex: 1 
        property string pendingCmd: ""
        property string pendingLabel: ""

        property var buttonsModel: [
            { label: "Lock",     icon: "", cmd: "lock" },
            { label: "Suspend",  icon: "", cmd: "suspend" },
            { label: "Logout",   icon: "", cmd: "logout" },
            { label: "Reboot",   icon: "", cmd: "reboot" },
            { label: "Shutdown", icon: "", cmd: "shutdown" }
        ]

        Keys.onPressed: (e) => {
            const isActivate = (e.key === Qt.Key_Return || e.key === Qt.Key_Enter || e.key === Qt.Key_Space)

            if (e.key === Qt.Key_Escape) {
                if (root.pendingCmd !== "") {
                    root.pendingCmd = ""
                    root.confirmIndex = 1
                    root.forceActiveFocus()
                } else {
                    Qt.quit()
                }
                e.accepted = true
                return
            }

            if (root.pendingCmd !== "") {
                if (e.key === Qt.Key_Left || e.key === Qt.Key_Right || e.key === Qt.Key_Tab) {
                    root.confirmIndex = (root.confirmIndex === 0) ? 1 : 0
                    e.accepted = true
                    return
                }
                if (isActivate) {
                    if (root.confirmIndex === 1) run(root.pendingCmd)
                    else {
                        root.pendingCmd = ""
                        root.confirmIndex = 1
                        root.forceActiveFocus()
                    }
                    e.accepted = true
                    return
                }
                e.accepted = true
                return
            }

            if (e.key === Qt.Key_Left || (e.key === Qt.Key_Tab && (e.modifiers & Qt.ShiftModifier))) {
                move(-1); e.accepted = true; return
            }
            if (e.key === Qt.Key_Right || e.key === Qt.Key_Tab) {
                move(1); e.accepted = true; return
            }
            if (e.key === Qt.Key_Up) {
                move(-1); e.accepted = true; return
            }
            if (e.key === Qt.Key_Down) {
                move(1); e.accepted = true; return
            }

            if (isActivate) {
                initiateAction(buttonsModel[currentIndex].cmd, buttonsModel[currentIndex].label)
                e.accepted = true
                return
            }
        }

        function move(delta) {
            const count = buttonsModel.length
            let next = currentIndex + delta
            if (next < 0) next = count - 1
            if (next >= count) next = 0
            currentIndex = next
        }

        function initiateAction(cmd, label) {
            pendingCmd = cmd
            pendingLabel = label
            confirmIndex = 1
            root.forceActiveFocus()
        }

        function getConfirmText() {
            if (pendingCmd === "shutdown") return "Power Off?"
            if (pendingCmd === "reboot") return "Reboot System?"
            if (pendingCmd === "logout") return "Log Out?"
            if (pendingCmd === "lock") return "Lock Screen?"
            if (pendingCmd === "suspend") return "Suspend?"
            return "Are you sure?"
        }

        function isDestructive() {
            return (pendingCmd === "shutdown" || pendingCmd === "reboot")
        }

        function run(cmd) {
            if (cmd === "lock") Quickshell.execDetached(["hyprlock"])
            if (cmd === "suspend") Quickshell.execDetached(["systemctl", "suspend"])
            if (cmd === "logout") Quickshell.execDetached(["hyprctl", "dispatch", "exit"])
            if (cmd === "reboot") Quickshell.execDetached(["systemctl", "reboot"])
            if (cmd === "shutdown") Quickshell.execDetached(["systemctl", "poweroff"])
            Qt.quit()
        }

        Rectangle {
            id: bgMask
            anchors.fill: parent
            radius: 20
            visible: false
        }

        Item {
            anchors.fill: parent
            layer.enabled: true
            layer.effect: OpacityMask { maskSource: bgMask }

            Rectangle {
                anchors.fill: parent
                color: theme.card
            }

            Image {
                width: parent.width
                height: 150
                anchors.top: parent.top
                source: theme.activeImg
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }

        Item {
            anchors.fill: parent
            z: 1 

            MouseArea {
                anchors.fill: parent
                hoverEnabled: false
                onPressed: (mouse) => mouse.accepted = true
                onClicked: (mouse) => mouse.accepted = true
            }

            ColumnLayout {
                anchors.top: parent.top
                anchors.topMargin: 158 
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2

                Text {
                    text: "@" + userName.text.replace("@", "")
                    font.family: "Inter"
                    font.pixelSize: 15
                    font.bold: true
                    color: theme.accent
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    id: uptime
                    text: "..."
                    font.family: "Inter"
                    font.pixelSize: 12
                    color: theme.text
                    opacity: 0.7
                    Layout.alignment: Qt.AlignHCenter
                }

                Text { id: userName; visible: false; text: "User" }
            }

            Item {
                anchors.fill: parent
                opacity: root.pendingCmd === "" ? 1 : 0
                visible: opacity > 0
                Behavior on opacity { NumberAnimation { duration: 120 } }

                RowLayout {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 12

                    Repeater {
                        model: root.buttonsModel
                        Rectangle {
                            Layout.preferredWidth: 65
                            Layout.preferredHeight: 70
                            radius: 12

                            property bool isActive: index === root.currentIndex
                            property bool isHovered: hoverHandler.hovered

                            color: {
                                if (isActive) return theme.accent
                                if (isHovered) return theme.tileHover
                                return theme.tile
                            }

                            scale: (isActive || isHovered) ? 1.05 : 1.0
                            Behavior on color { ColorAnimation { duration: 100 } }
                            Behavior on scale { NumberAnimation { duration: 100 } }

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 4
                                Text {
                                    text: modelData.icon
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 22
                                    color: (parent.parent.isActive || parent.parent.isHovered) ? theme.activeText : theme.text
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                Text {
                                    text: modelData.label
                                    font.family: "Inter"
                                    font.weight: 600
                                    font.pixelSize: 10
                                    color: (parent.parent.isActive || parent.parent.isHovered) ? theme.activeText : theme.text
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }
                            HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }
                            TapHandler {
                                onTapped: {
                                    root.currentIndex = index
                                    root.initiateAction(modelData.cmd, modelData.label)
                                }
                            }
                        }
                    }
                }
            }

            Item {
                anchors.fill: parent
                opacity: root.pendingCmd !== "" ? 1 : 0
                visible: opacity > 0
                Behavior on opacity { NumberAnimation { duration: 120 } }

                ColumnLayout {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 15

                    Text {
                        text: root.getConfirmText()
                        font.family: "Inter"
                        font.pixelSize: 18
                        font.weight: 700
                        color: theme.text
                        Layout.alignment: Qt.AlignHCenter
                    }

                    RowLayout {
                        spacing: 15
                        Rectangle {
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 40
                            radius: 10
                            property bool isHovered: cancelHover.hovered
                            color: (root.confirmIndex === 0 || isHovered) ? theme.tileHover : theme.tile
                            border.width: 1
                            border.color: (root.confirmIndex === 0 || isHovered) ? theme.text : "transparent"
                            Text {
                                anchors.centerIn: parent
                                text: "No"
                                font.family: "Inter"
                                font.weight: 600
                                color: theme.text
                            }
                            HoverHandler { id: cancelHover; cursorShape: Qt.PointingHandCursor }
                            TapHandler {
                                onTapped: {
                                    root.pendingCmd = ""
                                    root.confirmIndex = 1
                                    root.forceActiveFocus()
                                }
                            }
                        }
                        Rectangle {
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 40
                            radius: 10
                            property bool isHovered: confirmHover.hovered
                            color: (root.confirmIndex === 1 || isHovered)
                                ? (root.isDestructive() ? theme.danger : theme.accent)
                                : theme.tile
                            Text {
                                anchors.centerIn: parent
                                text: "Yes"
                                font.family: "Inter"
                                font.weight: 700
                                color: (root.confirmIndex === 1 || isHovered) ? theme.activeText : theme.text
                            }
                            HoverHandler { id: confirmHover; cursorShape: Qt.PointingHandCursor }
                            TapHandler { onTapped: root.run(root.pendingCmd) }
                        }
                    }
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            z: 2
            radius: bgMask.radius
            color: "transparent"
            border.width: 1
            border.color: theme.border
            antialiasing: true
            enabled: false
        }
    }
}
