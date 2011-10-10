# Add more folders to ship with the application, here


splashscreen.files = ./images/splash.png
splashscreen.path = /opt/qgolftracker/images/
INSTALLS += splashscreen


#folder_images.source = images
#folder_images.target = .

#DEPLOYMENTFOLDERS += folder_images


# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT+= declarative
symbian:TARGET.UID3 = 0xE667832B

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp



OTHER_FILES += \
    qml/MainPage.qml \
    qml/main.qml \
    qgolftracker.desktop \
    qgolftracker.svg \
    qgolftracker.png \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    functions.js \
    qml/ViewPage.qml \
    qml/RecPage.qml \
    qml/EditCourses.qml \
    qml/EditClubs.qml \
    qml/DetailsPage.qml \
    qml/ViewbyclubsPage.qml \
    qml/ViewMapPage.qml \
    images/logo.svg \
    images/flag.svg \
    images/tee.svg \
    images/splash.png

RESOURCES += \
    res.qrc

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic










