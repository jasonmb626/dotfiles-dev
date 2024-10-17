#In Gnome, if Alacritty isn't honorning your GTK theme this should fix it
sudo sed -i -r 's^([[:alpha:]]*)Exec=.*^\1Exec=/home/jason/git/commandline_utilities/start_alacrity.sh^' /usr/share/applications/Alacritty.desktop
xdg-desktop-menu forceupdate
