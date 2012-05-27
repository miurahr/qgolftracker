qGolfTracker

Application for logging data while playing golf/frisbeegolf.

Announce note:
so, it is time to reveal what I have been working on to justify my upkeep with N950.
it is called qGolfTracker and it tracks coordinates and other data into local db
so you can track your game (I hope it works also with frisbeegolf!) better than
with any solution I've come up with...

The app is really simple... well, the elements are really simple and easy
but making everything to work together is a huge pain in the a**...
The first version is buggy, any feedback is appreciated.
Couple issues: you must edit clubs (from the small toolbar menu)
before you start tracking. will add notification and pop up the club editing
qml page at some point but not just yet.

http://store.ovi.com/content/225045


Modification note:

Original version utilize nokia map on N950/N9 Meego Harmattan device.
It is strait approach but OpenSreetMap is better for OSS than proprietary map.

Now it use a plugin to use OSM and help user to see details of golf holes on the map.

Open Street Map and Google Maps™ plugins for Qt Mobility Location API
http://xf.iksaif.net/dev/qtm-geoservices-extras.html

This may work on recent Qt-enabled device such as Windows 8 Phone and Android.

Todo:

 - Add map display mode when recording, that guide player about hole.
 - Add wiki style golf course edition. Share definitions.
 - Utilize osm hole properties. OSM has tags for golf course.
 - Add score show mode not list on view page.
