//////////////////////////////////////////////////////////////////////////////////////////////////////
// Table: gore                                                                                      //
// columns:                                                                                         //
// 1 id (int) | 2 sessionid (int) | 3 latitude (int) | 4 longitude (int) | 5 altitude (int)         //
// 6 horizontalaccuray (int) | 7 verticalaccuracy (int) | 8 date (int) | 9 time (int)               //
// 10 club (varchar) | 11 course (varchar) | 12 hole (int)                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////
// Table: courses
// columns:
//




//1. Write
//write given data to 'gore' database

function write(sess, lat, lon, alt, horacc, veracc, dat, tim, club, course, hole) {

    console.log('1: Funcs.write(' + sess + ", " + lat + ", " + lon + ", " + alt + ", " + horacc + ", " + veracc + ", " + dat + ", " + tim + ", " + club + ", " + course + ", " + hole + ")")

    //if vertical accuracy is not ok, put a compromise altitude.
    if(veracc=-1) {alt = 100 }

    //data to be saved to table 'gore' :
    //idnumber          id int
    //sessionid         sessionid int
    //gps position      latitude int
    //                  longitude int
    //                  altitude int
    //gps accuracy      horizontalaccuracy int
    //                  verticalaccuracy int
    //date              date int
    //time              time int
    //club              club varchar
    //course            course varchar
    //hole              hole int

    var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS gore(id int, sessionid int, latitude decimal, longitude decimal, altitude int, horizontalaccuracy int, verticalaccuracy int, date int, time int, club varchar, course varchar, hole int)')

                    //get max ID from 'gore' and +1 it if found. if not found, start from 1
                    var readmax = tx.executeSql('SELECT MAX(id) AS maxid FROM gore')
                    var idmax = readmax.rows.item(0).maxid

                    if (idmax === "") {
                        idmax = 1
                    }
                    else {
                        idmax ++
                    }


                    //write data to table
                    try {
                    tx.executeSql('INSERT INTO gore VALUES (?,?,?,?,?,?,?,?,?,?,?,?)', [ idmax, sess, lat, lon, alt, horacc, veracc, dat, tim, club, course, hole ]
                             )
                    }
                    catch(e) {
                        console.log("write (1) error: " + e )
                    }



                             }



                )
}


// 2. get the biggest number of a session and +1 it!
function getnewsession() {
    console.log("2: Funcs.getnewsession()")
    var number
    var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    db.transaction(
                function(rx) {

                    try {
                        rx.executeSql('SELECT MAX(sessionid) AS maxsession FROM gore')
                    }
                    catch(e) {
                        if (e !== "") {
                            number = 1
                        }
                    }


                    if (number != 1) {
                        var sessionmax = rx.executeSql('SELECT MAX(sessionid) AS maxsession FROM gore')
                        number = sessionmax.rows.item(0).maxsession
                        number ++
               }
}
)
    return number
}



// 3. destroy all the data, should this be removed completely?!? you already have a way to delete courses and rounds...
function destroyall() {
    console.log("3: Funcs.destroyall()")
var ff = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
ff.transaction(
            function(dstroy) {
                    try{
                    dstroy.executeSql('DROP TABLE gore')
                    }
                    catch(e){
                        console.log("destroyall (3) drop gore error: " +e)
                    }

                    try {
                        dstroy.executeSql('DROP TABLE clubs')
                    }
                    catch(e) {
                        console.log("destroyall (3) drop clubs error: " + e)
                    }

                    try{

                    dstroy.executeSql('DROP TABLE courses')
                    }
                    catch(e)
                    {
                        console.log("destroyall (3) drop courses error: " + e)
                    }
            }
                )

    populatecourses(true)
}


// 4. populatelist get data from 'gore' and populate it to sectionscroller to ViewPage.qml
function populatelist() {
    console.log("Funcs.populatelist()")
    var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

                        db.transaction(
                                    function(rx) {

                                        //try if database read succeeds, if not, disable sectionscroller
                                        try {
                                            rx.executeSql('SELECT sessionid, course, date, time FROM gore GROUP BY sessionid')
                                        }
                                        catch(e) {
                                            console.log("populatelist (4) error was: " + e)
                                            viewPage.norecords = true //tell to ViewPage.qml that there is no records (hide sectionscroller)

                                            return
                                        }
                                        // if database read succeeded, if rows are less than 1, disable sectionscroller
                                        var populate = rx.executeSql('SELECT sessionid, course, date, time FROM gore GROUP BY sessionid')


                                        if(populate.rows.length < 1) {

                                            viewPage.norecords = true


                                        }

                                        for (var i=0; i<populate.rows.length; i++){


                                        //populate
                                            //DATE AND TIME MUST BE MODIFIED?!?!?!
                                        playbackmodel.append({name: populate.rows.item(i).course,
                                                             date: populate.rows.item(i).date,
                                                             id: populate.rows.item(i).sessionid,
                                                             time: populate.rows.item(i).time  })

                                        }
                                    }
                                        )



}

// 5. writeclubs, write club data
function writeclubs(number, club) {
    console.log("5: Funcs.writeclubs("+ number + ", " + club + ")")


    //data to be saved to table 'clubs':
    //idnumber          idnumber int
    //club              club varchar


    var  cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    cdb.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS clubs(idnumber int, club varchar)')
                    var tmp = tx.executeSql('SELECT club FROM clubs WHERE idnumber=' + number)
                    console.log("rows length: " + tmp.rows.length)
                    if (tmp.rows.length !== 0) {
                        //not empty, must update instead of insert!
                        //console.log("not empty")
                        try {
                            tx.executeSql('UPDATE clubs SET club="' + club + '" WHERE idnumber=' + number)
                        }
                        catch(e) {
                            console.log('writeclubs(5) UPDATE error: ' +e)
                        }

                    }

                    else {
                        //empty, it is ok to insert!
                        console.log("empty")
                    try {

                    tx.executeSql('INSERT INTO clubs VALUES (?,?)', [ number, club ])
                    }
                    catch(e) {
                        console.log('writeclubs (5) INSERT error: ' +e)
                    }
                    }
}
                )
}


//6. readclub, read club data from given number

function readclub(number) {
    console.log("6: Funcs.readclub("+ number + ")")
    var clubsname
    var number2
    //console.log("Club number " + number + " name requested")
    var cdb1 = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    //if number is instead string 'clubamount', function returns clubamount. used in other functions to get amount of rows in database.
    if (number == "clubamount") {
        cdb1.transaction(
                    function(tx) {
                        try {
                            tx.executeSql('SELECT MAX(idnumber) as maxid FROM clubs')
                            }
                        catch(e) {
                            console.log(' readclub (6) error: ' +e )
                            return
                        }
                        var amountclbs = tx.executeSql('SELECT MAX(idnumber) as maxid FROM clubs')
                        number2 = amountclbs.rows.item(0).maxid
                    }
                    )

        console.log(number2)
        return number2

}

        else {
    cdb1.transaction(
                function(tx) {
                        var clubname
                        try {
                            clubname = tx.executeSql('SELECT club FROM clubs WHERE idnumber=' + number)
                        }
                        catch(e) {
                            console.log("readclub (6) read error: " + e)
                            clubsname = "empty"
                            console.log("does it end here?")
                            return clubsname
                        }

                        if (clubname.rows.length !== 0) {

                            //console.log("not empty")

                           /* for (var i = 0; i < 50; i ++) {
                                console.log(clubname.rows.item(i).club)
                            }*/

                            //console.log(clubname.rows.item(0).club)

                            clubsname = clubname.rows.item(0).club
                            console.log(clubsname)
                        }
                        //if rows length = 0, put text 'empty' as a placeholder
                        else {
                            console.log("empty")
                            clubsname = "empty"
                        }

                }
                    )
        //console.log(clubsname)
        return clubsname
    //return clubsname
}
}

// 7. writecourse. write course to database 'courses'
function writecourse(operation, number, coursename, holenumber, par, hcp) {
    console.log("7: Funcs.writecourse(" + operation + ", " + number + ", " + coursename + ", " + holenumber + ", " + par + ", " + hcp + ")")

    //
    var  cdc = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    switch(operation) {

        //operation update called
    case "update":
        console.log("updating par: " + par + " and hcp: " + hcp + " to db")
        console.log("update called")
        cdc.transaction(
                    function(tx) {
                        try {
                            tx.executeSql('UPDATE courses SET par=' + parseFloat(par) + ' WHERE idnumber=' + number)
                            tx.executeSql('UPDATE courses SET hcp=' + parseFloat(hcp) + ' WHERE idnumber=' + number)
                        }
                        catch(e) {
                            console.log("writecourse (7) update error: " + e)
                        }

                    }
                        )
        break

    default:
    console.log("function writecourse called with number " + number + " coursename " + coursename + " holenumber "
                + holenumber + " par " + par + " hcp " + hcp)

    //data to be saved:
    //id number                idnumber int
    //course name              coursename varchar
    //hole number              holenumber int
    //par                      par int
    //handicap                 hcp varchar

        //this really breaks the logic completely!!! this is probably why the stuff is buggy....

        if (number === "") {
            //console.log("no number supplied!")
            var temp
            cdc.transaction(
                        function(tx) {
                            try {
                                tx.executeSql('SELECT MAX(idnumber) AS maxid FROM courses')

                            }

                            catch(e) {
                                console.log("writecourse (7) SELECT MAX error was: " + e)

                                if (e !== "") {
                                    temp = 1
                                }
                            }

                            if (temp != 1) {
                            var read = tx.executeSql('SELECT MAX(idnumber) AS maxid FROM courses')
                            temp = read.rows.item(0).maxid
                            temp ++
                            console.log("temp = " + temp + ", rowslength: " + read.rows.lenght)
                            }
                        }
                            )

            number = temp


        }

        console.log("idnumber: " + number)
    cdc.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE clubs')
                    tx.executeSql('CREATE TABLE IF NOT EXISTS courses(idnumber int, coursename varchar, holenumber int, par int, hcp varchar)')
                        try {



                        tx.executeSql('INSERT INTO courses VALUES (?,?,?,?,?)', [ number, coursename, holenumber, par, hcp ]
                           )
                        }

                        catch(e) {
                            console.log("writecourse (7) INSERT INTO error: " + e )
                        }



}
                )

  break
}
}


//8. readcourse, read course data from 'courses'
function readcourse(action, arg1, arg2, arg3) {
    console.log("8: Funcs.readcourse("+ action + ", " + arg1 + ", " + arg2 + ", " + arg3 + ")")

    var cdb2 = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    switch (action) {

    case "quantity":
        var amount = ""
        cdb2.transaction(
                    function(tx) {
                        var coursemax
                        console.log("starting the try")
                        try {
                            console.log("trying")
                            coursemax = tx.executeSql('SELECT coursename FROM courses GROUP BY coursename')
                            //console.log("rows: " + coursemax.rows.length)
                        }

                        catch(e) {

                            if(e !== "") {
                                amount = 1
                                return amount

                            }
                        }


                        //console.log("no error")
                        amount = coursemax.rows.length
                        if (amount === 0) {
                            amount ++
                        }

                        }
                        )
          return amount


    case "name":
        var coursenametemp = ""
        cdb2.transaction(
                    function(tx) {

                        try {
                            console.log("trying name")
                            tx.executeSql('SELECT coursename FROM courses GROUP BY coursename')
                        }
                        catch(e) {
                            console.log("readcourse (8) name error: " +e)
                            if (e !== "") {
                                console.log("you don't have courses defined. adding placeholder")
                                coursenametemp = "Add course"
                                return coursenametemp

                            }

                        }




                        var courseread = tx.executeSql('SELECT coursename FROM courses GROUP BY coursename')
                        if (courseread.rows.length === 0) {
                            coursenametemp = "Add course"
                            return coursenametemp

                        }

                        var numb = arg1 - 1
                        coursenametemp = courseread.rows.item(numb).coursename
} )

        return coursenametemp

    case "amount":
        console.log("arg1: " + arg1 + ", arg2: " + arg2)
        var amountofholes = ""
        cdb2.transaction(
        function(tx) {
            var amntholes = tx.executeSql('SELECT * FROM courses WHERE coursename="' +arg1 +'"')
               amountofholes = amntholes.rows.length
        }
)
        return amountofholes

    case "id":
        console.log("arg1: " + arg1 + ", arg2: " + arg2)
        var idnmber = ""
        cdb2.transaction(
                    function(tx) {


                        var idnmb = tx.executeSql('SELECT * FROM courses WHERE coursename="' + arg1 + '" AND holenumber=' +arg2)
                        idnmber = idnmb.rows.item(0).idnumber
                        console.log("idnumber: " + idnmber)
                        console.log("idnumber ver 2: " + idnmb.rows.item(0).idnumber)
                        console.log("par: " + idnmb.rows.item(0).par)

                        var test = tx.executeSql('SELECT * FROM courses')

                        for (var i = 0; i < test.rows.length; i++) {
                            console.log("row: " + i + "id: " + test.rows.item(i).idnumber)

                        }

                    }
                        )
        return idnmber


    case "par":
        var par = ""
        cdb2.transaction(
                    function(tx) {
                        var partmp = tx.executeSql('SELECT par FROM courses WHERE coursename="'+arg1+'" AND holenumber='+arg2)
                        par = partmp.rows.item(0).par

                         }
                    )
                    return par
}
}

// 9. populateclubs, populate clubs to selectiondialog
function populateclubs() {
    console.log("9: Funcs.populateclubs()")

    for (var i=1;i<=readclub("clubamount");i++) {
        var clubtemp = readclub(i)
            clubModel.append({name:clubtemp})
            appWindow.clubsinitiated = true

}
}

// 10. populateholes, populate holes to sectionscroller
function populateholes(name) {
    console.log("10: Funcs.populateholes(" + name +")")

    var holes
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                     var read = tx.executeSql('SELECT * FROM courses WHERE coursename="' + name +'"')
                     holes = read.rows.length
                    }
                )

    for (var i = 1; i <= holes; i++ ) {
        holeNumbers.append({value: i})
    }


}

// 11. populatecourses, populate courses to selection dialog
function populatecourses(addedit) {
    console.log("11: Funcs.populatecourses("+ addedit + ")")
    for (var i=1;i<=readcourse("quantity","","","");i++) {
        var coursetemp = readcourse("name",i,"","")
        courseModel.append({name:coursetemp})
        }
    }

// 12. populate hcp, just create numbers from 1 to 30 into it
function populatehcp() {
    for (var i=1; i<= 30; i++) {
        hcpNumbers.append({value:i})
    }
}

// 13. populatedetails, xxxxxxxx
function populatedetails(){
    console.log("13: Funcs.populatedetails()")

    /*
      We need:
      -hole
      -hit #
      -club
      -distance
      (-date + time?)


      */
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    //console.log(getdistance(61, 40, 50, 55))

    cdb.transaction(
                function(tx) {
                    var tmp = tx.executeSql('SELECT * FROM gore WHERE sessionid=' + appWindow.sessionidtemp)
                    var holetemp
                    var hittemp = 1
                    for (var i=0; i < tmp.rows.length; i++) {
                        var two = i + 1
                        var latid1 = tmp.rows.item(i).latitude
                        var longit1 = tmp.rows.item(i).longitude
                        if (i < tmp.rows.length -1) {
                        var latid2 = tmp.rows.item(two).latitude
                        var longit2 = tmp.rows.item(two).longitude
                        }

                        if (holetemp == tmp.rows.item(i).hole) {
                            hittemp ++
                        }

                        else {
                            hittemp = 1
                        }

                        holetemp = tmp.rows.item(i).hole



                        if (tmp.rows.item(i).club != "potted"){
                        detailModel.append({ hole: tmp.rows.item(i).hole,
                                           club: tmp.rows.item(i).club,
                                           distance: getdistance(latid1, longit1, latid2, longit2),
                                           hit: hittemp})
                        }
}
                }
    )

}

// 14. populatemap
function populatemap() {
    console.log("14: Funcs.populatemap()")

    /*
      We need:
      -hole
      (-hit #)
      -club
      -distance
      -position
      (-date + time?)


      */
    console.log("populating map")
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);


    cdb.transaction(
                function(tx) {
                    var tmp = tx.executeSql('SELECT * FROM gore WHERE sessionid=' + appWindow.sessionidtemp)


                    /*
                      THIS IS FOR TESTING ONLY
                    var latid1 = tmp.rows.item(2).latitude
                    var longit1 = tmp.rows.item(2).longitude

                    var creationstring = 'import QtMobility.location 1.1;Coordinate { latitude:'+ latid1 +'; longitude:' +longit1 + ' ;}'
                    var coord = Qt.createQmlObject(creationstring, viewMapPage, "coordinate")

                    map.center = coord

                    //var creationstring2 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapCircle { center: { latitude: ' + latid1 +'; longitude:' + longit1 +'} color:"blue"; radius:10000}'
                    var creationstring2 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapCircle { center: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} color:"blue"; radius:10}'
                    var newcircle = Qt.createQmlObject(creationstring2,viewMapPage, "mapcircle");
                    map.addMapObject(newcircle)
                    */
                    //temporary stuff trying to get polyline working...
                    polyline.removeCoordinate(point1)
                    polyline.removeCoordinate(point2)
                    polyline.removeCoordinate(point3)
                    var holetemp

                    for (var i=0; i < tmp.rows.length; i++) {
                        //console.log("does this work?!?")

                        var two = i + 1

                        if (i == tmp.rows.length -1) {
                            two = i
                        }


                        var latid1 = tmp.rows.item(i).latitude
                        var longit1 = tmp.rows.item(i).longitude
                        var latid2 = tmp.rows.item(two).latitude
                        var longit2 = tmp.rows.item(two).longitude

                        var clubtext = tmp.rows.item(i).club + " - " + Math.round(getdistance(latid1, longit1, latid2, longit2)) + "m"

                        var creationstring = 'import QtMobility.location 1.1;Coordinate { latitude:'+ latid1 +'; longitude:' +longit1 + ' ;}'
                        //console.log("creationstring: " + creationstring)
                        var coord = Qt.createQmlObject(creationstring, viewMapPage, "dynamicCoord"+i)

                        polyline.addCoordinate(coord)

                        //add small balloon to hit position

                        var creationstring5 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapCircle { center: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} color:"white"; radius:5;z:1}'
                        var balloon = Qt.createQmlObject(creationstring5, viewMapPage, "dynamicBalloon"+i)
                        map.addMapObject(balloon)

                        if (tmp.rows.item(i).hole !== holetemp) {

                            var creationstring4 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapImage { coordinate: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} source: "qrc:/images/tee.svg"; offset.x:-30; offset.y:1}'
                            var newteeimage = Qt.createQmlObject(creationstring4,viewMapPage, "dynamicteeImage"+i)
                            map.addMapObject(newteeimage)
                            //draw teeing markers!
                        }

                        holetemp = tmp.rows.item(i).hole

                        if (tmp.rows.item(i).club !== "potted"){
                        var creationstring2 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapText { coordinate: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} color:"blue";offset.x: -50; offset.y: 0; font.pointSize: 16; text: "' + clubtext + '" }'
                        var newtext = Qt.createQmlObject(creationstring2,viewMapPage, "dynamicText"+i)
                        map.addMapObject(newtext)
                        }
                        else {

                            var creationstring3 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapImage { coordinate: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} source: "qrc:/images/flag.svg"; offset.x:-30; offset.y: 2}'
                            var newimage = Qt.createQmlObject(creationstring3,viewMapPage, "dynamicImage"+i)
                            map.addMapObject(newimage)
                            //draw a flag!
                        }

/*
                            //add new circle to map
                            console.log("trying to add a circle")

                            var creationstring2 = 'import QtQuick 1.0; import QtMobility.location 1.2; MapCircle { center: Coordinate{ latitude: ' + latid1 +'; longitude:' + longit1 +'} color:"blue"; radius:25}'
                            //console.log("creationstring: " + creationstring)
                            var newcircle = Qt.createQmlObject(creationstring2,viewMapPage, "dynamicCircle"+i);
                            //var snippetname = "dynamicSnippet" + i
                            map.addMapObject(newcircle)
                            //console.log("circle dynamicSnippet" + i +" added")

                            */
                        if (i==0) {

                            map.center = coord
                        }
                         //Does this work at all?!?

                        //console.log("adding polyline to " + latid1 + ", " + longit1)

                        //polyline.addCoordinate({latitude: latid1, longitude: longit1})

                        //polyline.addCoordinate("dynamic" +i)


                        /*console.log("trying to add a circle")
                        var newcircle = Qt.createQmlObject('import QtQuick 1.0; import QtMobility.location 1.2; MapCircle {;center: Coordinate {; latitude:' + latid1 +';longitude:' +longit1 +'};color:"blue";radius:1000;',viewMapPage, "dynamicSnippet1");
                        viewMapPage.map.addMapObject(newcircle)
                        console.log("circle probably added")

                        */


                        //DOES IT WORK LIKE THIS?!?

                        //console.log("distance: " +getdistance(latid1, longit1, latid2, longit2))
                        //var hitfetch = tx.executeSql('SELECT * FROM gore WHERE hole=')
                        /*detailModel.append({ hole: tmp.rows.item(i).hole,
                                           hit: tmp.rows.item(i).hit,
                                           club: tmp.rows.item(i).club,
                                           distance: getdistance(latid1, longit1, latid2, longit2)})
                        */
                        /*if (tmp.rows.item(i).club != "potted"){
                        detailModel.append({ hole: tmp.rows.item(i).hole,
                                           club: tmp.rows.item(i).club,
                                           distance: getdistance(latid1, longit1, latid2, longit2),
                                           hit: 69})
                        }*/
}
                }
    )
    //detailModel.append({ })

}



//15. getdistance. THIS CAN BE DONE ALSO WITH QML COORDINATE FUNCTIONS, SHOULD THIS BE CHANGED?
function getdistance(lat1, lon1, lat2, lon2) {
    console.log("15: Funcs.getdistance("+ lat1 + ", " + lon1 + "," + lat2 + "," + lon2 +")")
    //thanks for the equations, http://www.movable-type.co.uk/scripts/latlong.html !

    var R = 6371; // km
    var dLat = (lat2-lat1) * Math.PI / 180
    var dLon = (lon2-lon1) * Math.PI / 180
    lat1 = lat1 * Math.PI / 180
    lat2 = lat2 * Math.PI / 180

    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;
    d = d * 1000 //convert to meters!

    //console.log("distance: " + d)
    return d
}




// 16. gethcp
function gethcp(course, numbr){
    console.log("16: Funcs.gethcp(" + course + ", " + numbr + ")")
    var hcpn
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);


    cdb.transaction(
                function(tx) {
                    var hcp = tx.executeSql('SELECT * FROM courses WHERE coursename="' + course + '" AND holenumber=' + numbr)
                    //console.log("hcp = " + hcp.rows.item(0).hcp)
                    hcpn = hcp.rows.item(0).hcp
                    //hcp = 15
                }
    )
    return hcpn
}

// 17. getpar
function getpar(course, numbr) {
    console.log("17: Funcs.getpar(" + course + ", " + numbr + ")")
    var parn
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);


    cdb.transaction(
                function(tx) {
                    //console.log("trying to fetch stuff from course " + course + " and hole: " + numbr)
                    var hcp = tx.executeSql('SELECT * FROM courses WHERE coursename="' + course + '" AND holenumber=' + numbr)
                    //console.log("par = " + hcp.rows.item(0).par)
                    parn = hcp.rows.item(0).par

    }

                )

    return parn

}

// 18. removeround
//this has problems! the list is mixed and some deletions just don't work!
function removeround(id) {
    console.log("18: Funcs.removeround(" + id + ")")
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                    try{
                        console.log("removing round " + id)

                        /*var test = tx.executeSql('SELECT * FROM gore')

                        for (var i = 0; i < test.rows.length; i++ ) {
                            console.log("id: " + test.rows.item(i).id + " club: " + test.rows.item(i).club)
                        }*/


                        var deletestring = 'DELETE FROM gore WHERE sessionid="' + id +'"'
                       // console.log("Deletestring: " + deletestring)
                        tx.executeSql(deletestring)
                        //console.log("Y U NOT WORK?!?")
                    }

                    catch(e) {
                        console.log("Funcs removeround SQL error: " +e)
    }
                    //console.log("here we go")
                    //norecords = true //this doesnt work as intended!
}

                )


}

//19. removecourse
function removecourse(name) {
    console.log("19: Funcs.removecourse(" + name +  ")")

    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                    try{
                        tx.executeSql('DELETE FROM courses WHERE coursename="' + name +'"')
                    }

                    catch(e) {
                        console.log("removecourse (19) error: " +e)
    }
}
                )


}
//20. removeclub
function removeclub(id) {
    console.log("20: Funcs.removeclub(" + id +")")

    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    cdb.transaction(
                function(tx) {
                    try{
                        tx.executeSql('DELETE FROM clubs WHERE idnumber="' + id +'"')
                    }

                    catch(e) {
                        console.log("error: " +e)
    }
}
                )


}

//21. removelastrow, remove last row from 'gore'
function removelastrow() {
    console.log("21: Funcs.removelastrow()")

    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    cdb.transaction(
                function(tx) {
                    try{
                        console.log("trying to remove last row")
                        tx.executeSql('DELETE FROM gore WHERE id= (SELECT MAX(id) FROM gore limit 1)')
                    }

                    catch(e) {
                        console.log("removelastrow error: " +e)
    }
}
                )

}

//22. removelastround, remove everything with biggest 'sessionid' from 'gore'
function removelastround() {
    console.log("22: Funcs.removelastround()")

    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                    try{
                        tx.executeSql('DELETE FROM gore WHERE sessionid = (SELECT MAX(sessionid) FROM gore limit 1)')

                    }

                    catch(e) {
                        console.log("Funcs removelastround SQL error: " +e)
    }
                    }

                )

}
