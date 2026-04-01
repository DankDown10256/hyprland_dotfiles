import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Item {
    id: root

    // On récupère le premier lecteur disponible via MPRIS
    readonly property var player: Mpris.players.length > 0 ? Mpris.players[0] : null

    RowLayout {
        anchors.fill: parent
        spacing: 15

        // Pochette de l'album
        Rectangle {
            Layout.preferredWidth: 76
            Layout.preferredHeight: 76
            radius: 8
            color: "#313244"
            clip: true

            Image {
                anchors.fill: parent
                source: (root.player && root.player.artUrl) ? root.player.artUrl : ""
                fillMode: Image.PreserveAspectCrop
                
                // Image par défaut si pas de pochette
                Rectangle {
                    anchors.fill: parent
                    color: "#45475a"
                    visible: parent.status !== Image.Ready
                    Text {
                        anchors.centerIn: parent
                        text: "♪"
                        color: "#bac2de"
                        font.pointSize: 20
                    }
                }
            }
        }

        // Infos textuelles (Titre / Artiste)
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Text {
                Layout.fillWidth: true
                text: root.player ? root.player.title : "Aucune musique"
                color: "#cdd6f4"
                font.bold: true
                font.pointSize: 12
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: root.player ? root.player.artist : "Inactif"
                color: "#a6adc8"
                font.pointSize: 10
                elide: Text.ElideRight
            }

            // Barre de progression
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
                Layout.topMargin: 5
                color: "#313244"
                radius: 2

                Rectangle {
                    width: parent.width * (root.player ? 0.4 : 0)
                    height: parent.height
                    color: "#f5c2e7"
                    radius: 2
                }
            }
        }

        // Boutons de contrôle simplifiés
        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignVCenter

            // Précédent
            MouseArea {
                implicitWidth: 30
                implicitHeight: 30
                Text { anchors.centerIn: parent; text: "⏮"; color: "#cdd6f4"; font.pointSize: 12 }
                onClicked: if (root.player) root.player.previous()
            }

            // Play / Pause
            MouseArea {
                implicitWidth: 30
                implicitHeight: 30
                Text { 
                    anchors.centerIn: parent
                    text: root.player && root.player.playbackStatus === Mpris.Playing ? "⏸" : "▶"
                    color: "#cdd6f4"
                    font.pointSize: 16 
                }
                onClicked: {
                    if (root.player) {
                        if (root.player.playbackStatus === Mpris.Playing) {
                            root.player.pause();
                        } else {
                            root.player.play();
                        }
                    }
                }
            }

            // Suivant
            MouseArea {
                implicitWidth: 30
                implicitHeight: 30
                Text { anchors.centerIn: parent; text: "⏭"; color: "#cdd6f4"; font.pointSize: 12 }
                onClicked: if (root.player) root.player.next()
            }
        }
    }
}
