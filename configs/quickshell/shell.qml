import QtQuick
import QtQuick.Controls
import Quickshell

ShellRoot {
    PanelWindow {
        id: window
        visible: true
        
        // On ancre le widget en haut et on le centre horizontalement
        anchors {
            top: true 
        }
        
        // On lui donne une marge pour le placer pile sous ta Waybar
        margins {
            top: 50 // Ajuste ce chiffre selon la hauteur de ta Waybar !
        }

        // On définit la taille exacte de notre widget
        implicitWidth: 400
        implicitHeight: 100

        // Fond transparent pour laisser place aux bords arrondis du Rectangle
        color: "transparent"

        // Le conteneur du lecteur (style rectangulaire arrondi)
        Rectangle {
            anchors.fill: parent
            radius: 15
            color: "#CC1E1E2E" // Fond Catppuccin transparent
            border.color: "#313244"
            border.width: 1

            // On importe notre composant de musique
            MusicPlayer {
                anchors.fill: parent
                anchors.margins: 12
            }
        }
    }
}
