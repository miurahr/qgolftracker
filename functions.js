function write(sess, lat, lon, alt, horacc, veracc, dat, tim, club, course, hole) {


    //alt1 = String(alt)
    if(veracc=-1) {alt = 100 }
    //console.log("function write called with " + lat  + " " + lon + " " + alt + " " + horacc + " " +veracc + " " + dat + " " +tim + " " + club + " " + course + " " +hole)

    //data to be saved:
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
                    //tx.executeSql('DROP TABLE gore')

                    tx.executeSql('CREATE TABLE IF NOT EXISTS gore(id int, sessionid int, latitude decimal, longitude decimal, altitude int, horizontalaccuracy int, verticalaccuracy int, date int, time int, club varchar, course varchar, hole int)')

                    var readmax = tx.executeSql('SELECT MAX(id) AS maxid FROM gore')
                    var idmax = readmax.rows.item(0).maxid

                    if (idmax === "") {
                       // console.log("no previous entries!")
                        idmax = 1
                    }
                    else {
                       // console.log("previous entries, " +idmax)
                        idmax ++
                    }



                    try {
                    tx.executeSql('INSERT INTO gore VALUES (?,?,?,?,?,?,?,?,?,?,?,?)', [ idmax, sess, lat, lon, alt, horacc, veracc, dat, tim, club, course, hole ]
                             )
                    }
                    catch(e) {
                        console.log("feedback from write: " + e )
                    }



                             }



                )
}


// get the biggest number of a session and +1 it!
function getnewsession() {
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

                     //   else {

                    if (number != 1) {
                    //console.log("there are older entries!")
                    var sessionmax = rx.executeSql('SELECT MAX(sessionid) AS maxsession FROM gore')
                        //console.log("sessionmax: " + sessionmax)
                        number = sessionmax.rows.item(0).maxsession
                        number ++
                        //console.log("number: " + number)
                        //console.log("rowlenght: " + sessionmax.rows.length)
               }
}





)
//console.log("number is: " + number)
    return number
}




function destroyall() {
var ff = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
ff.transaction(
            function(dstroy) {
                    try{
                    dstroy.executeSql('DROP TABLE gore')
                    }
                    catch(e){
                        console.log("error: " +e)
                    }

                    try{

                    dstroy.executeSql('DROP TABLE courses')
                    }
                    catch(e)
                    {
                        console.log("error: " + e)
                    }
            }
                )

    populatecourses(true)
}

function read(what) {
    var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
var r = ""
                    switch (what) {

                    case 1:
                        //is this now obsolete?!?
                        console.log("someone wants to know distance!");
                        /*var a = 1
                        var b = 100
                        var c = "supermaila"
                        var alldata = a + ", " + b + ", " + c
                        console.log("all the data: " +alldata)
                        return alldata*/
//var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
                        db.transaction(
                                    function(rx) {
                                        var read = rx.executeSql('SELECT * FROM gore')
                                        //console.log("database read")
                                        //var r = ""
                                        for (var i=0; i < read.rows.length; i++) {
                                            r += read.rows.item(i).idnumber + ", "
                                            //console.log(r)
                                            r += read.rows.item(i).latitude + ", "
                                            //console.log(r)
                                            r += read.rows.item(i).longitude + ", "
                                            //console.log(r)
                                            r += read.rows.item(i).altitude + ", "
                                            //console.log(r)
                                            r += read.rows.item(i).club + "|"
                                            //console.log(r)
                                        }
                                        console.log("r is: " +r)
                                        //return r
                                        }

                                        )
                        console.log("r is: " +r)
                        textArea.text = r
                        return r

                        break

                    case 2:
                        //is this obsolete?!?!?
                        console.log("you want to have it all, don't you!")
                        var everything = ""
                        //var  db = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
                        db.transaction(
                         function(rx) {
                         var read = rx.executeSql('SELECT * FROM gore')
                                        everything += read.rows.toString()
                                                                 }

                                                                )
                        console.log(everything)
                        textArea.text = everything


                        //return r


                        break

                    case 3:
                        //populate sectionscroller
                        console.log("populating sectionscroller")
                        var date = Qt.formatDate(new Date(), "ddMMyy")
                        var time = Qt.formatTime(new Date(), "hhmm")

                        db.transaction(
                                    function(rx) {


                                        try {
                                            rx.executeSql('SELECT sessionid, course, date, time FROM gore GROUP BY sessionid')
                                        }
                                        catch(e) {
                                            console.log("error was: " + e)


                                            /*playbackmodel.append({name: "No records found",
                                                                     date: date,
                                                                     id:1,
                                                                     time: time})*/
                                            viewPage.norecords = true

                                            return
                                        }

                                        var populate = rx.executeSql('SELECT sessionid, course, date, time FROM gore GROUP BY sessionid')


                                        if(populate.rows.length < 1) {
                                                /*playbackmodel.append({name: "No records found",
                                                                         date: date,
                                                                         id:1,
                                                                         time: time})*/

                                            viewPage.norecords = true


                                        }

                                        for (var i=0; i<populate.rows.length; i++){



                                        playbackmodel.append({name: populate.rows.item(i).course,
                                                             date: populate.rows.item(i).date,
                                                             id: populate.rows.item(i).sessionid,
                                                             time: populate.rows.item(i).time  })

                                        }
                                    }
                                        )


                        break
                    case 4:
                        db.transaction(
                        function(tx) {

                            var checkup = tx.executeSql('SELECT * FROM gore')

                        var r = ""

                        for (var i=0; i < checkup.rows.length; i++) {
                            r += "read id: " + checkup.rows.item(i).id + ", session: " + checkup.rows.item(i).session
                            r += ", latitude: " + checkup.rows.item(i).latitude + ", longitude: " + checkup.rows.item(i).longitude
                            r += ", altitude: " +checkup.rows.item(i).altitude + ", horiz. acc: " + checkup.rows.item(i).horizontalaccuracy
                            r += ", vertical acc." + checkup.rows.item(i).verticalaccuracy + ", date: " + checkup.rows.item(i).date
                            r += ", time: " + checkup.rows.item(i).time + ", club: " + checkup.rows.item(i).club
                            r += ", course: " + checkup.rows.item(i).course + ", hole: " + checkup.rows.item(i).hole + "\n"
                        }
                        console.log(r)
                        }
                                    )
                        break
                    default:
                        console.log("What should I read?!?")
                        return "Errpor!!"
                    }


}

function writeclubs(number, club) {

    //

    //console.log("function writeclubs called with number " + number + " and club " + club)

    //data to be saved:
    //idnumber          idnumber int
    //club              club varchar


    var  cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    cdb.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE clubs')
                    tx.executeSql('CREATE TABLE IF NOT EXISTS clubs(idnumber int, club varchar)')

                    tx.executeSql('INSERT INTO clubs VALUES (?,?)', [ number, club ]
                             )

}
                )




}

function readclub(number) {
    var clubsname = ""
    var number2 = 0
    //console.log("Club number " + number + " name requested")
    var cdb1 = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    if (number == "clubamount") {
        cdb1.transaction(
                    function(tx) {
                    var amountclbs = tx.executeSql('SELECT MAX(idnumber) as maxid FROM clubs')

                        number2 = amountclbs.rows.item(0).maxid


                    }
                    )

        //console.log("fuck")
        //console.log("number is: " + number2)

        return number2
            console.log("no such club")
            return ""
}

        else {
    cdb1.transaction(
                function(tx) {

                        //var all = tx.executeSql('SELECT club FROM clubs')
                        //console.log("amount: " + all.rows.length)

                        var clubname = tx.executeSql('SELECT club FROM clubs WHERE idnumber=' + number)

                    //var clubname = tx.executeSql('SELECT club FROM clubs WHERE idnumber=' + number)
                    //var clubsname = ""
                        //console.log("length: " + clubname.rows.length)
                        //console.log("nimi: " + clubname.rows.item(0).club)

                        if (clubname.rows.length != 0) {
                        clubsname += clubname.rows.item(0).club
                        }

                        else {
                        clubsname += "empty"
                        }
                }
                    )
    //console.log("Clubsname is before return: " + clubsname)
    return clubsname
}
}




function writecourse(operation, number, coursename, holenumber, par, hcp) {

    //
    var  cdc = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);

    switch(operation) {

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
                            console.log("output was: " + e)
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

        if (number === "") {
            //console.log("no number supplied!")
            var temp
            cdc.transaction(
                        function(tx) {
                            try {
                                tx.executeSql('SELECT MAX(idnumber) AS maxid FROM courses')

                            }

                            catch(e) {
                                console.log("error was: " + e)

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


                            /*var fckinshit = tx.executeSql('SELECT * FROM courses')

                            for (var i = 0; i < fckinshit.rows.length; i++) {
                                console.log("id: " + fckinshit.rows.item(i).idnumber + "\n")

                            }*/
                        }
                            )

            number = temp


        }
        /*if (number === "") {
            number = 1
        }*/

        console.log("idnumber: " + number)
    cdc.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE clubs')
                    tx.executeSql('CREATE TABLE IF NOT EXISTS courses(idnumber int, coursename varchar, holenumber int, par int, hcp varchar)')
                        tx.executeSql('INSERT INTO courses VALUES (?,?,?,?,?)', [ number, coursename, holenumber, par, hcp ]
                             )

}
                )


  break
}
}

function readcourse(action, arg1, arg2, arg3) {

    //what the hell do I need to know?!
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

                            //this not works at all!
                            console.log("catch started with e= " +e)
                            if(e !== "") {
                                amount = 1
                                console.log("you have no holes defined")
                                return amount

                            }
                        }


                        console.log("no error")
                        amount = coursemax.rows.length
                        if (amount === 0) {
                            amount ++
                        }

                        console.log("you have " + amount + " holes defined")




}
                        )
        console.log("returning amount: " + amount)
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
                            console.log("Error was: " +e)
                            if (e !== "") {
                                console.log("you don't have courses defined. adding placeholder")
                                coursenametemp = "Add course"
                                return coursenametemp

                            }

                        }



                        //console.log("success, you have courses defined and zero errors")
                        var courseread = tx.executeSql('SELECT coursename FROM courses GROUP BY coursename')
                        if (courseread.rows.length === 0) {
                            //console.log("zero items, add placeholder!")
                            coursenametemp = "Add course"
                            //console.log("returning " + coursenametemp)
                            return coursenametemp

                        }

                        var numb = arg1 - 1
                        coursenametemp = courseread.rows.item(numb).coursename



                        //GROUP BY
                        //coursenametemp = courseread.rows.length

} )
        //console.log("course name: " + coursenametemp)

        return coursenametemp

    case "amount":
        console.log("arg1: " + arg1 + ", arg2: " + arg2)
        var amountofholes = ""
        cdb2.transaction(
        function(tx) {
            var amntholes = tx.executeSql('SELECT * FROM courses WHERE coursename="' +arg1 +'"')
            //var amntholes = tx.executeSql('SELECT * FROM courses')
            amountofholes = amntholes.rows.length
            //console.log("there are " + amountofholes + " holes in this course!")

        }
)
        return amountofholes

    case "id":
        console.log("arg1: " + arg1 + ", arg2: " + arg2)
        var idnmber = ""
        cdb2.transaction(
                    function(tx) {
                        /*try { tx.executeSql('SELECT * FROM courses WHERE coursename="' + arg1 + '" AND holenumber=' +arg2)
                        }
                        catch(e) {
                            console.log("error was: " + e)
                        }*/

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

        //read hole id where course = and hole =
        return idnmber


    case "par":
        var par = ""
        cdb2.transaction(
                    function(tx) {
                        var partmp = tx.executeSql('SELECT par FROM courses WHERE coursename="'+arg1+'" AND holenumber='+arg2)
                        par = partmp.rows.item(0).par

                         }
                    )
        //console.log("par: " + par)
                    return par
    case "clear":
        cdb2.transaction(
                    function(tx) {
                        tx.executeSql('DROP TABLE courses')
                    }
                        )
        //console.log("requested course name: " + coursenametemp)
        return "table dropped"

}
}
function populateclubs() {
    //console.log("clubs are " + readclub("clubamount"))
    for (var i=1;i<=readclub("clubamount");i++) {
        var clubtemp = readclub(i)
        //console.log("clubtemp: " + clubtemp)
        //console.log("output of function: " + readclub(i))
        //if (clubtemp !== "") {
            clubModel.append({name:clubtemp})
        //}
    //else {
           // console.log("reached end of the club stuff")
      //  }
    appWindow.clubsinitiated = true

}
}

function populateholes(name) {

    //add read amnt of holes here!
    var holes
        //= 9
    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                     var read = tx.executeSql('SELECT * FROM courses WHERE coursename="' + name +'"')
                     holes = read.rows.length
                    /*
                    for(var i = 0; i < read.rows.length; i++) {
                        var j = i + 1
                        console.log("hole: " + j + " par: " + read.rows.item(i).par)

                    }*/

}
                )

    console.log("amount of holes: " + holes)







    for (var i = 1; i <= holes; i++ ) {
        holeNumbers.append({value: i})
        //console.log("added hole #" + i)
    }


}

function populatecourses(addedit) {
    //console.log("You have " + readcourse("quantity","","") + " courses defined")
    console.log("populating courses initiated")
    //console.log("quantity :" + readcourse("quantity","","",""))
    for (var i=1;i<=readcourse("quantity","","","");i++) {
        var coursetemp = readcourse("name",i,"","")
        courseModel.append({name:coursetemp})
        console.log(coursetemp + " has been added to list")
    }
    if (addedit) {
    //courseModel.append({name: "Add course" })
        //obsolete?!?
    }

}

function populatehcp() {
    for (var i=1; i<= 30; i++) {
        hcpNumbers.append({value:i})
    }
}

function populatedetails(){

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

                    for (var i=0; i < tmp.rows.length; i++) {
                        var two = i + 1
                        var latid1 = tmp.rows.item(i).latitude
                        var longit1 = tmp.rows.item(i).longitude
                        if (i < tmp.rows.length -1) {
                        var latid2 = tmp.rows.item(two).latitude
                        var longit2 = tmp.rows.item(two).longitude
                        }
                        //console.log("distance: " +getdistance(latid1, longit1, latid2, longit2))
                        //var hitfetch = tx.executeSql('SELECT * FROM gore WHERE hole=')
                        /*detailModel.append({ hole: tmp.rows.item(i).hole,
                                           hit: tmp.rows.item(i).hit,
                                           club: tmp.rows.item(i).club,
                                           distance: getdistance(latid1, longit1, latid2, longit2)})
                        */
                        if (tmp.rows.item(i).club != "potted"){
                        detailModel.append({ hole: tmp.rows.item(i).hole,
                                           club: tmp.rows.item(i).club,
                                           distance: getdistance(latid1, longit1, latid2, longit2),
                                           hit: 69})
                        }
}
                }
    )
    //detailModel.append({ })

}

function populatemap() {

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
    //console.log(getdistance(61, 40, 50, 55))

    cdb.transaction(
                function(tx) {
                    var tmp = tx.executeSql('SELECT * FROM gore WHERE sessionid=' + appWindow.sessionidtemp)

                    for (var i=0; i < tmp.rows.length; i++) {
                        console.log("does this work?!?")
                        var two = i + 1
                        var latid1 = tmp.rows.item(i).latitude
                        var longit1 = tmp.rows.item(i).longitude
                        /*if (i < tmp.rows.length -1) {
                        var latid2 = tmp.rows.item(two).latitude
                        var longit2 = tmp.rows.item(two).longitude
                        }*/

                        var creationstring = 'import QtMobility.location 1.1;Coordinate { latitude:'+ latid1 +'; longitude:' +longit1 + ' ;}'
                        //console.log("creationstring: " + creationstring)
                        var coord = Qt.createQmlObject(creationstring, viewMapPage, "dynamic"+i)

                        if (i==0) {

                            map.center = coord

                            //add new circle to map
                            console.log("trying to add a circle")

                            creationstring = 'import QtQuick 1.0; import QtMobility.location 1.2; MapCircle { center: ' + coord + '; color:"blue"; radius:1000}'
                            console.log("creationstring: " + creationstring)
                            var newcircle = Qt.createQmlObject(creationstring,viewMapPage, "dynamicSnippet"+i);
                            map.addMapObject(newcircle)
                            console.log("circle probably added")

                        } //Does this work at all?!?

                        console.log("adding polyline to " + latid1 + ", " + longit1)

                        //polyline.addCoordinate({latitude: latid1, longitude: longit1})
                        polyline.addCoordinate(coord)

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




function getdistance(lat1, lon1, lat2, lon2) {

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


//id number                idnumber int
//course name              coursename varchar
//hole number              holenumber int
//par                      par int
//handicap                 hcp varchar

function gethcp(course, numbr){
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

function getpar(course, numbr) {
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

function removeround(id) {
    //id ++

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

function removecourse(name) {

    var cdb = openDatabaseSync("golftrackerDB", "1.0", "Golf Tracker complete database", 1000000);
    cdb.transaction(
                function(tx) {
                    try{
                        tx.executeSql('DELETE FROM courses WHERE coursename="' + name +'"')
                    }

                    catch(e) {
                        console.log("error: " +e)
    }
}
                )


}

function removeclub(id) {

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

function removelastrow() {

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

function removelastround() {

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
