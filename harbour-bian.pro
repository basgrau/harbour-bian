# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-bian

CONFIG += sailfishapp

SOURCES += src/harbour-bian.cpp

OTHER_FILES += qml/harbour-bian.qml \
    rpm/harbour-bian.changes.in \
    rpm/harbour-bian.spec \
    rpm/harbour-bian.yaml \
    translations/*.ts \
    harbour-bian.desktop \
    qml/cover/Cover.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/CanvasModule.js \
    qml/pages/DBModule.js \
    qml/pages/MainPage.qml \
    qml/pages/WeightCanvas.qml \
    qml/pages/GlucoseCanvas.qml \
    qml/pages/AddWeightPage.qml \
    qml/pages/AddGlucosePage.qml \
    qml/pages/CanvasElement.qml \
    qml/pages/AddValueDialog.qml \
    qml/pages/MainPage.qml \
    qml/jbQuick/Charts/QChart.js \
    qml/jbQuick/Charts/QChart.qml \
    qml/pages/ChartElement.qml \
    qml/date.format.js \
    qml/pages/SharedInfo.js \
    LICENSE.txt

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-bian-de.ts
