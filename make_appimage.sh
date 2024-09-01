#!/bin/bash
APPDIR=AppImageBuild
AppName=whatever
# if appimagetool-x86_64 does not exist
if [ ! -f appimagetool-x86_64.AppImage ]; then
    wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x appimagetool-x86_64.AppImage
fi

mkdir -p ${APPDIR}/usr/bin
cp sometext.txt ${APPDIR}/usr/bin
cp hello.py ${APPDIR}/usr/bin
chmod +x ${APPDIR}/usr/bin/hello.py

# wget if file does not exist
if [ ! -f ${APPDIR}/app.png ]; then
    wget -O ${APPDIR}/app.png https://upload.wikimedia.org/wikipedia/commons/9/9b/Love-game-logo-256x256.png
fi

cat <<EOF > ${APPDIR}/${AppName}.desktop
[Desktop Entry]
Name=${AppName}
Exec=doesNotMatterLol
Icon=app
Type=Application
Categories=Utility;
EOF

# Create an AppRun file
cat <<EOF > ${APPDIR}/AppRun
#!/bin/bash
HERE=\$(dirname "\$(readlink -f "\${0}")")
exec python3 "\$HERE/usr/bin/hello.py" "\$@"
EOF
chmod +x ${APPDIR}/AppRun

ARCH=x86_64 ./appimagetool-x86_64.AppImage ${APPDIR}
#move to build dir
mkdir build
mv ${AppName}-x86_64.AppImage build/${AppName}.AppImage
