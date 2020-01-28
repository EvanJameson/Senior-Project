import traceback
import sys
import urllib.request
import time
import json
import re
import mysql.connector
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
from termcolor import colored

athletes_stored = 0
parse_time_start = time.time()
# parse_time_stop = time.time()
months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
years = ["2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
events = ["100 Meters", "100 Meters - Wheelchair", "200 Meters", "400 Meters", "400 Meters - Relay Split", "800 Meters", "1500 Meters", "1600 Meters", "1 Mile", "3000 Meters", "3200 Meters", "2 Miles", "5000 Meters", "110m Hurdles - 33\"", "110m Hurdles - 36\"", "110m Hurdles - 39\"", "110m Hurdles - 42\"", "300m Hurdles - 30\"", "300m Hurdles - 33\"", "300m Hurdles - 36\"", "300m Hurdles - 39\"", "400m Hurdles - 30\"", "400m Hurdles - 33\"", "400m Hurdles - 36\"", "2k Steeplechase", "3k Steeplechase", "4x100 Relay", "4x200 Relay", "4x400 Relay", "4x800 Relay", "4x1600 Relay", "SMR 100-100-200-400m", "SMR 1600m", "DMR 1200-400-800-1600m", "Shot Put", "Discus", "Javelin", "High Jump", "Pole Vault", "Long Jump", "Triple Jump", "Hammer", "25 Meter Dash", "30 Meter Dash", "35 Meter Dash", "40 Meter Dash", "45 Meter Dash", "50 Meter Dash", "55 Meter Dash", "60 Meter Dash", "70 Meter Dash", "75 Meter Dash", "80 Meter Dash", "90 Meter Dash", "100 Meters", "110 Meters", "145 Meters", "150 Meters", "160 Meters", "165 Meters", "180 Meters", "200 Meters", "250 Meters", "300 Meters", "360 Meters", "400 Meters", "500 Meters", "550 Meters", "600 Meters", "720 Meters", "750 Meters", "800 Meters", "800m Racewalk", "1000 Meters", "1200 Meters", "1440 Meters", "1500 Meters", "1500m Racewalk", "1600 Meters", "1600m Racewalk", "2000 Meters", "2400 Meters", "3000 Meters", "3000m Racewalk", "3200 Meters", "5000 Meters", "5000m Racewalk", "8000 Meters", "10,000 Meters", "10,000 Meters Racewalk", "20,000 Meters Racewalk", "1-Hour Racewalk", "40m Hurdles", "45m Hurdles", "50m Hurdles", "55m Hurdles - 30\"", "55m Hurdles - 33\"", "55m Hurdles - 39\"", "55m Hurdles - 42\"", "60m Hurdles - 30\"", "60m Hurdles - 33\"", "60m Hurdles - 36\"", "60m Hurdles - 39\"", "65m Hurdles", "70m Hurdles", "75m Hurdles", "80m Hurdles", "100m Hurdles - 30\"", "100m Hurdles - 33\"", "100m Hurdles - 36\"", "110m Hurdles", "195m Hurdles", "200m Hurdles", "300m Hurdles - 30\"", "300m Hurdles - 33\"", "400m Hurdles - 30\"", "1k Steeplechase", "1.5k Steeplechase", "1 Mile Steeplechase", "2k Steeplechase", "3k Steeplechase", "4x50 Relay", "4x55 Relay", "4x60 Relay", "4x60 Shuttle Relay", "4x75 Relay", "4x80 Relay", "4x100 Relay", "4x100 Throwers Relay", "4x133 Relay", "4x145 Relay", "4x150 Relay", "4x160 Yard Relay", "4x160 Relay", "4x180 Relay", "4x200 Relay", "4x225 Relay", "4x240 Relay", "4x300 Relay", "4x320 Relay", "4x360 Relay", "4x375 Relay", "4x400 Relay", "4x600 Relay", "4x720 Relay", "4x750 Relay", "4x800 Relay", "4x1200 Relay", "4x1500 Relay", "4x1600 Relay", "4x3200 Relay", "SMR 200-100-100-200m", "SMR 200-180-180-216m", "SMR 100-100-200-400m", "SMR 200-200-300-100m", "SMR 160-80-80-480m", "Swedish 100-200-300-400m", "SMR 300-200-200-500m", "SMR 100-300-600-200m", "SMR 400-200-200-400m", "SMR 200-200-600-400m", "SMR 180-180-360-720m", "SMR 435-145-290-580m", "SMR 450-150-150-750m", "SMR 400-160-160-800m", "SMR 1600m", "SMR 320-160-480-640m", "SMR 480-160-160-800m", "SMR 600-200-400-800m", "MMR 800-400-400-800m", "MMR 1200-800-200-400m", "DMR 1000-200-400-800m", "DMR 200-400-800-1200m", "DMR 800-200-400-1600m", "DMR 400-400-800-1600m", "DMR 400-800-800-1200m", "DMR 1000-200-600-1600m", "DMR 400-800-1200-1200m", "DMR 1200-400-800-1600m", "DMR 800-800-1600-1600m", "DMR 1200-800-1600-3200m", "4x50 Shuttle Hurdles", "4x51.5 Shuttle Hurdles", "4x55 Shuttle Hurdles", "4x60 Shuttle Hurdles", "4x65 Shuttle Hurdles", "4x70 Shuttle Hurdles", "4x80y Shuttle Hurdles", "4x100 Shuttle Hurdles", "4x102.5 Shuttle Hurdles", "4x110 Shuttle Hurdles", "4x120y Shuttle Hurdles", "4x160m Shuttle Hurdles", "4x200m Shuttle Hurdles", "4x300 Shuttle Hurdles", "4x400 Shuttle Hurdles", "4x440y Shuttle Hurdles", "Shot Put - 4lb", "Shot Put - 6lb", "Shot Put - 8lb", "Shot Put - 10lb", "Shot Put - 12lb", "Shot Put - 16lb", "Shot Put - 3kg", "Shot Put - 4kg", "Shot Put - 5kg", "Shot Put - 6kg", "JV Shot Put", "Softball Throw", "Baseball Throw", "Soccerball Throw", "Discus - 1kg", "Discus - 1.5kg", "Discus - 1.6kg", "Discus - 1.75kg", "Discus - 2kg", "Javelin - 300g TJ", "Javelin - 500g TJ", "Javelin - 600g", "Javelin - 800g", "High Jump", "Pole Vault", "Long Jump", "Standing Long Jump", "Triple Jump", "Standing Triple Jump", "Hammer - 3kg", "Hammer - 4kg", "Hammer - 5kg", "Hammer - 6kg", "Hammer - 12lb", "Hammer - 16lb", "Weight Throw", "Super Weight Throw", "Ultra Weight Throw", "Medicine Ball Throw OHB", "Medicine Ball Throw UHF", "Roster Only", "Attendee", "Other", "Triathlon Score", "Tetrathlon Score", "Pentathlon Score (Indoor)", "Pentathlon Score (Outdoor)", "Heptathlon Score", "Octathlon Score", "Decathlon Score", "Throws Penthlon Score", "40 Yard Dash", "45 Yard Dash", "50 Yard Dash", "60 Yard Dash", "100 Yard Dash", "110 Yard Dash", "200 Yards", "220 Yards", "300 Yards", "330 Yards", "440 Yards", "500 Yards", "600 Yards", "660 Yards", "880 Yards", "1000 Yards", "1320 Yards", "Mile Racewalk", "1 Mile", "2 Miles", "3 Miles", "6 Miles", "Half Marathon", "Marathon", "40y Hurdles", "45y Hurdles", "50y Hurdles", "60y Hurdles", "120y Hurdles", "180y Hurdles", "200y Hurdles", "220y Hurdles", "330y Hurdles", "440y Hurdles", "4x50 Yard Shuttle Relay", "4x110 Yard Relay", "4x200 Yard Relay", "4x220 Yard Relay", "4x320 Yard Relay", "4x400 Yard Relay", "4x440 Yard Relay", "4x800 Yard Relay", "4x880 Yard Relay", "4xMile Relay", "SMR 110-110-220-440y", "SMR 110-220-440-880y", "SMR 200-200-400-880y", "DMR 1320-440-880-Mile", "4x55y Shuttle Hurdles"]
db = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="A9BX782*",
  database="resultsDB",
  auth_plugin='mysql_native_password'
)
dbcursor = db.cursor(buffered=True)

# =============================================
# ---------------|DICT -> OBJECT|--------------
# =============================================

class objectview(object):
    def __init__(self, d):
        self.__dict__ = d

# =============================================
# ---------------|HELPER FUNCS|----------------
# =============================================


def quit(msg, timer_stop):
    global parse_time_start
    global parse_time_stop

    halt = "\n=================================\n-------|EXECUTION HALTED:|-------\n=================================\n\n"
    bump = "\n\n=================================\n"
    if(timer_stop) and msg == "":
        timer("stop")
        #print (parse_time_stop)
        msg = halt + (str(athletes_stored) + " stored in " +
              str(round(parse_time_stop - parse_time_start, 2)) + " seconds")+ bump
        sys.exit(msg)
    else:
        msg = halt + msg + bump
        sys.exit(msg)

def timer (flag):
    global parse_time_start
    global parse_time_stop

    if flag == "start":
        parse_time_start = time.time()
    elif flag == "stop":
        parse_time_stop = time.time()
        # print(parse_time_stop - parse_time_start)


# Print debug message based on flag and type of message passed
def debug_message(msg, flag, stop):
    if flag == "dict" :
        print("\n\n{")
        for k in msg:
            print (str(k) + ": " + str(msg[k]))
        print("}\n")
        if stop:
            quit("Dict Printed",True)

    elif flag == "json":
        print ("JSON Struct")
        print (json.dumps (msg, sort_keys=True, indent=4))
        if stop:
            quit("JSON Printed",True)

    elif flag == "soup":
        for e in msg:
            print(e)
        if stop:
            quit("Soup Printed",True)

    elif flag == "tags_text":
        for e in msg:
            print(e.getText().strip())
        if stop:
            quit("Text in Tags Printed", True)

    elif flag == "list":
        for e in msg:
            print(e)
        if stop:
            quit("List Printed",True)

    elif flag == "complete":
        if stop:
            quit(msg, True)
        else:
            print(msg)

    # Strings
    else:
        if stop:
            quit(msg, True)
        else:
            print(msg)

# gets all athlete links and returns as a list
# to be consumed during parsing
def get_athlete_links(soup):
    temp_links = [td.a for td in soup.findAll('td')]
    athlete_links = []
    for link in temp_links:
        if (not (link is None)) and "/Athlete" in str(link):
            temp = str(link)
            q1 = temp.index("/")
            q2 = temp.index(">") - 1
            # print (temp[q1:q2])
            athlete_links.append(temp[q1:q2])
    return athlete_links


# gets all school links and returns as a list
# to be consumed during parsing
def get_school_links(soup):
    temp_links = [td.a for td in soup.findAll('td')]
    school_links = []
    none_count = -100

    for link in temp_links:
        if (not (link is None)) and "/School" in str(link):
            temp = str(link)
            q1 = temp.index("/")
            q2 = temp.index(">") - 1
            # print (temp[q1:q2])
            school_links.append(temp[q1:q2])
        if (not (link is None)):
            none_count = 0
        elif (link is None):
            none_count += 1
            if none_count > 2:
                school_links.append("Unattached")

    return school_links


# gets the number of results for an event
def get_num_results (soup):
    table = soup.find_all("td")
    i = 0
    for e in table:
        text = e.getText()

        # This is lazy but I wait til we iterate
        # until the results tag, take it apart and return it
        if(i == 909):

            # get indexes of string so I only get the number
            r1 = text.index(":")
            r2 = text.index(")")
            text = text[r1 + 2:r2].replace(',','')  # get only the number and remove ,
            return int(text)
        i += 1


# get the soup based on the link given
def get_soup(link):
    req = Request(link, headers={'User-Agent': 'Mozilla/5.0'})
    fp = urlopen(req)
    mybytes = fp.read()
    html = mybytes.decode("utf8")
    soup = BeautifulSoup(html, "html.parser")
    fp.close()
    return soup


# clean tags and remove duplicate lines
# also removes records from tags, only results remain
def clean_tags(tags, lines):
    prev_line = ""
    save_data = False

    for e in tags:
        cur_line = e.getText().strip()
        if "Outdoor Season" in cur_line or "Indoor Season" in cur_line:
            save_data = True

        if (save_data):
            if cur_line != prev_line:
                lines.append(cur_line)

            prev_line = cur_line

    return lines


def clean_links(athlete_links):
    links = []

    for e in athlete_links:
        cur_link = e['href']
        if "meet" in cur_link:
            links.append(cur_link)

    return links



# clean up result and extract wind and pr / sr
def clean_result(result, season, event):
    pos = result[0]
    mark = result[1]
    date = result[2]
    meet = result[3]
    pr = False
    sr = False
    wind = ""
    handtime = False
    converted = False
    dq = False
    dnf = False
    dns = False
    scr = False
    fs = False
    nt = False
    nd = False
    nm = False
    nh = False
    foul = False
    markType = ""

    # Clean position
    if not(pos.isnumeric()):
        pos = 0

    if pos == "" or pos == " ":
        pos = 0

    # Clean mark
    if "h" in mark:
        handtime = True
        mark = mark.replace('h', '')

    if "c" in mark:
        converted = True
        mark = mark.replace('c', '')

    if "a" in mark:
        mark = mark.replace('a', '')

    if "q" in mark:
        mark = mark.replace('q', '')

    if "(" in mark and ")" in mark:
        w1 = mark.index("(")
        w2 = mark.index(")")
        wind = float(mark[w1+1:w2])
        final_mark = mark[0:w1]


    if "PR" in mark:
        pr = True
        if wind == "":
            p = mark.index("PR")
            final_mark = mark[0:p]

    if "SR" in mark:
        sr = True
        if wind == "":
            s = mark.index("SR")
            final_mark = mark[0:s]

    if (not (pr or sr)) and wind == "":
        final_mark = mark.strip()

    if final_mark == "--":
        final_mark = "0.0"

    elif final_mark == "DQ":
        final_mark = "0.0"
        markType = "DQ"

    elif "DNF" in final_mark:
        final_mark = "0.0"
        markType = "DNF"

    elif "DNS" in final_mark:
        final_mark = "0.0"
        markType = "DNS"

    elif "SCR" in final_mark:
        final_mark = "0.0"
        markType = "SCR"

    elif "DQ" in final_mark:
        final_mark = "0.0"
        markType = "DQ"

    elif "FS" in final_mark:
        final_mark = "0.0"
        markType = "FS"

    elif "NT" in final_mark:
        final_mark = "0.0"
        markType = "NT"

    elif "ND" in final_mark:
        final_mark = "0.0"
        markType = "ND"

    elif "NM" in final_mark: # not a val in db
        final_mark = "0.0"
        markType = "NM"

    elif "NH" in final_mark:
        final_mark = "0.0"
        markType = "NH"

    elif "FOUL" in final_mark:
        final_mark = "0.0"
        markType = "FOUL"

    if markType == "":
        markType = "LEGAL"

    # check if field event mark or running mark
    if "'" in final_mark:
        d = final_mark.index("'")
        feet = final_mark[:d]
        inches = final_mark[d + 2:]
        final_mark = ("field", (float(feet) * 12.0) + float(inches))

    elif "m" in final_mark:
        d = final_mark.index("m")
        meters = final_mark[:d]
        final_mark = ("field", (float(meters) / 0.0254)) # turning meters into inches

    else:
        final_mark = ("track", final_mark)

    # TODO: If you do this techincally every result ever would have a wind guage, find different way to store
    if wind == "":
        wind = 0.0

    result = {'pos': pos, 'mark': final_mark, 'date': date, 'meet': meet, 'season': season, 'event': event,'wind': wind, 'pr': pr, 'sr': sr,
              'handtime': handtime, 'converted': converted, 'markType': markType}

    return result


def clean_school(text):

    # Name
    n1 = text.index("\"Name\":\"") + 8
    n2 = text.index(",\"Level") - 1
    name = text[n1:n2]

    # City
    c1 = text.index("City\":") + 7
    c2 = text.index(",\"State") - 1
    city = text[c1:c2]

    # State
    s1 = text.index("State\":") + 8
    s2 = text.index(",\"Mascot") - 1
    state = text[s1:s2]

    # Mascot
    m1 = text.index("Mascot\":") + 9
    m2 = text.index(",\"MascotUrl") - 1
    mascot = text[m1:m2]

    # TODO: Mascot link (link for team image, may use later somehow . . . )
    ml1 = text.index("MascotUrl\":") + 14
    ml2 = text.index(",\"TeamRecords") - 1
    mascot_link = text[ml1:ml2]

    school_data = {'name': name, 'city': city, 'state': state, 'mascot': mascot, 'mascot_link': mascot_link}

    return school_data


# TODO: Need to remove names of people in relays
def clean_meet(result, athlete):
    meet_year = ""
    month = ""

    meet = result['meet']

    # check for relay
    if athlete in meet:
        if "," in meet:
            cap_count = 0
            c1 = meet.index(",")
            temp = meet[:c1]
            for i in range(len(temp) - 1, 0, -1):
                if ord(temp[i]) >= 65 and ord(temp[i]) <= 90:
                    cap_count += 1
                    if cap_count == 2:
                        meet = temp[:i]
        else:
            meet.replace(athlete,"")

    # split date
    bad_month = result['date'][:3]
    meet_day = result['date'][4:]

    # get year
    for year in years:
        if year in result ['season']:
            meet_year = year

    # get month
    for i in range(len(months)):
        if months[i] == bad_month:
            meet_month = str(i + 1)
            if i < 10:
                meet_month = "0" + meet_month

    date = meet_year + "-" + meet_month + "-" + meet_day

    meet_data = {'name': meet, 'date': date}

    return meet_data


def print_scrape_result(msg, color, debug_width):
    global athletes_stored
    print('{:{fill}{align}{width}}'.format(colored(msg, color), fill = '-', align = '>', width = debug_width), end='')
    print(" [" + str(athletes_stored) + "/" + sys.argv[2] + "] ")


def handle_scrape_exception(e, athlete_link):
    log = open("fail_logfile.txt", "a")
    log.write("-------------------------------------------------------------------\n")
    log.write("Athlete [" + str(athletes_stored) + "/" + sys.argv[2] + "]\n")
    log.write("https://www.athletic.net/TrackAndField" + athlete_link + "\n")
    log.write("Exception:       " + str(e))
    log.write("\nTrace:           " + str(traceback.format_exc()))
    log.write("\n-------------------------------------------------------------------\n")
    log.close()


def handle_repeat_athlete(athlete_link):
    log = open("repeat_logfile.txt", "a")
    log.write("https://www.athletic.net/TrackAndField" + athlete_link)
    log.close()


# =============================================
# ------------|CONCURRENCY FUNCS|--------------
# =============================================

def unattached_athlete_exists(name, grade):
    global db
    global dbcursor

    dbcursor.execute(
        "SELECT AthleteID, COUNT(*) FROM Athletes WHERE  Name = (%s) and Grade = (%s) GROUP BY AthleteID",
        (name, grade)
    )

    if dbcursor.rowcount == 0:
        b = {"exists": False, "athlete_id": -2}
        d = objectview(b)
        return d

    elif dbcursor.rowcount == 1:
        results = dbcursor.fetchall()

        aid = results[0][0]
        b = {"exists": True, "athlete_id": aid}
        d = objectview(b)
        return d

    else:
        b = {"exists": True, "athlete_id": -3}
        d = objectview(b)
        return d

# check if athlete exists in DB already **TODO**
def athlete_exists(name, grade, school):
    global db
    global dbcursor

    if school == "Unattached":
        return unattached_athlete_exists(name, grade)

    dbcursor.execute(
        "SELECT A.AthleteID, COUNT(*) FROM Athletes A, Schools S, Athletes_Schools ASS WHERE A.AthleteID = ASS.AthleteID and S.SchoolID = ASS.SchoolID and A.Name = (%s) and A.Grade = (%s) and S.Name = (%s) GROUP BY AthleteID",
        (name, grade, school)
    )

    if dbcursor.rowcount == 0:
        b = {"exists": False, "athlete_id": -2}
        d = objectview(b)
        return d

    elif dbcursor.rowcount == 1:
        results = dbcursor.fetchall()

        aid = results[0][0]
        b = {"exists": True, "athlete_id": aid}
        d = objectview(b)
        return d


# check if result exists in DB already **TODO**
# if athlete_exists is implemente correctly i dont think this one needs to exist
def result_exists(data):
    return False


# check if school exists in DB already **TODO**
def school_exists(name, mascot, city, state):
    global db
    global dbcursor

    dbcursor.execute(
        "SELECT SchoolID, COUNT(*) FROM Schools WHERE Name = (%s) and Mascot = (%s) and City = (%s) and State = (%s) GROUP BY SchoolID",
        (name, mascot, city, state)
    )

    if dbcursor.rowcount == 0:
        b = {"exists": False, "school_id": -2}
        d = objectview(b)
        return d

    elif dbcursor.rowcount > 0:
        results = dbcursor.fetchall()

        sid = results[0][0]
        b = {"exists": True, "school_id": sid}
        d = objectview(b)
        return d


# check if meet exists in DB already **TODO**
def meet_exists(meet, date):
    global db
    global dbcursor

    dbcursor.execute(
        "SELECT MeetID, COUNT(*) FROM Meets WHERE Name = (%s) and Day = (%s) GROUP BY MeetID",
        (meet, date)
    )

    if dbcursor.rowcount == 0:
        b = {"exists": False, "meet_id": -2}
        d = objectview(b)
        return d

    elif dbcursor.rowcount > 0:
        results = dbcursor.fetchall()

        mid = results[0][0]
        b = {"exists": True, "meet_id": mid}
        d = objectview(b)
        return d


# need useless val for no event
# abstract to object instead of checker function
# return exists object that has whether or not it exists and the corresponding id
def event_exists(event):
    global db
    global dbcursor

    dbcursor.execute(
        "SELECT EventID, COUNT(*) FROM Events WHERE Name = (%s) GROUP BY EventID",
        (event,)
    )

    if dbcursor.rowcount == 0:
        b = {"exists": False, "event_id": -2}
        d = objectview(b)
        return d

    elif dbcursor.rowcount > 0:
        results = dbcursor.fetchall()


        eid = results[0][0]
        b = {"exists": True, "event_id": eid}
        d = objectview(b)
        return d


# =============================================
# ---------------|INSERT FUNCS|----------------
# =============================================


def insert_athlete(data):
    global db
    global dbcursor

    insert = "INSERT INTO Athletes (Name, Gender, Grade) VALUES (%s, %s, %s)"
    vals = (data['athlete'], "Male", data['grade'])

    dbcursor.execute(insert, vals)
    db.commit()

    athlete_id = dbcursor.lastrowid

    return athlete_id


# Convert to appropriate datatypes and insert into table
def insert_result(result, season, event, event_id, meet_id):
    global db
    global dbcursor

    insert = "INSERT INTO Results (Position, TimeMark, DistanceMarkInches, Pr, Sr, Wind, Sport, Season, HandTime, Converted, MarkType, EventID, MeetID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
    vals = ()
    if (result['mark'][0] == "track"):
        vals = (str(result['pos']), str(result['mark'][1]), "0", result['pr'], result['sr'], str(result['wind']), "TF", season, result['handtime'], result['converted'], result['markType'], event_id, meet_id)
    elif (result['mark'][0] == "field"):
        vals = (str(result['pos']), "0", str(result['mark'][1]), result['pr'], result['sr'], str(result['wind']), "TF", season, result['handtime'], result['converted'], result['markType'], event_id, meet_id)

    # debug_message(event_id, "", False)

    dbcursor.execute(insert, vals)
    db.commit()

    result_id = dbcursor.lastrowid

    return result_id


# Insert new school into table
def insert_school(school_data):
    global db
    global dbcursor

    insert = "INSERT INTO Schools (Name, Mascot, City, State) VALUES (%s, %s, %s, %s)"
    vals = (school_data['name'], school_data['mascot'], school_data['city'], school_data['state'])

    dbcursor.execute(insert, vals)
    db.commit()

    school_id = dbcursor.lastrowid

    return school_id


# Insert new meet into table
def insert_meet(meet_data):
    global db
    global dbcursor

    insert = "INSERT INTO Meets (Name, Day, Sport) VALUES (%s, %s, %s)"
    vals = (meet_data['name'], meet_data['date'], "TF")

    dbcursor.execute(insert, vals)
    db.commit()

    meet_id = dbcursor.lastrowid

    return meet_id


# Insert new event into table
def insert_event(event):
    global db
    global dbcursor

    insert = "INSERT INTO Events (Name) VALUES (%s)"
    vals = (event,)

    dbcursor.execute(insert, vals)
    db.commit()

    event_id = dbcursor.lastrowid

    return event_id


# Insert AthleteID and ResultID pair to maintain relationship
def insert_athlete_result(athlete_id, result_id):
    global db
    global dbcursor

    insert = "INSERT INTO Athletes_Results (AthleteID, ResultID) VALUES (%s, %s)"
    vals = (athlete_id, result_id)

    dbcursor.execute(insert, vals)
    db.commit()


# Insert AthleteID and SchoolID pair to maintain relationship
def insert_athlete_school(athlete_id, school_id):
    global db
    global dbcursor

    insert = "INSERT INTO Athletes_Schools (AthleteID, SchoolID) VALUES (%s, %s)"
    vals = (athlete_id, school_id)

    dbcursor.execute(insert, vals)
    db.commit()


# Insert MeetID and SchoolID pair to maintain relationship
def insert_meet_school(meet_id, school_id):
    global db
    global dbcursor

    insert = "INSERT INTO Meets_Schools (MeetID, SchoolID) VALUES (%s, %s)"
    vals = (meet_id, school_id)

    dbcursor.execute(insert, vals)
    db.commit()


# Insert ResultID and EventID pair to maintain relationship
# def insert_result_event(result_id, event_id):
#     global db
#     global dbcursor

#     insert = "INSERT INTO Results_Events (ResultID, EventID) VALUES (%s, %s)"
#     vals = (result_id, event_id)

#     dbcursor.execute(insert, vals)
#     db.commit()


# Insert ResultID and MeetID pair to maintain relationship
# def insert_result_meet(result_id, meet_id):
#     global db
#     global dbcursor

#     insert = "INSERT INTO Results_Meets (ResultID, MeetID) VALUES (%s, %s)"
#     vals = (result_id, meet_id)

#     dbcursor.execute(insert, vals)
#     db.commit()


# =============================================
# -------------|MAIN SCRAPE FUNCS|-------------
# =============================================


# Unattached athlete, find where they run and pass to scrape school
def scrape_school_deep(data,athlete_id):
    lines = []

    athlete_link = "https://www.athletic.net/TrackAndField" + data['athlete_link']
    athlete_soup = get_soup(athlete_link)

    temp_links = [td.a for td in athlete_soup.findAll('b')]

    # debug_message(athlete_soup, "soup", True)
    # debug_message(temp_links, "soup", True)
    #
    # At this point I need to move on from the scraper, not going
    # to handle this edge case unless I must

# scrape school info from school page
def scrape_school(data, athlete_id):
    lines = []

    link = "https://www.athletic.net/TrackAndField" + data['school_link']
    soup = get_soup(link)
    regex = r"\"teamNav\"(.*?)\"siteSupport\""

    school_id = -1

    # use regex to get string that contains info
    matchObj = re.search(regex, soup.getText())

    # clean string and get back dict of necessary info
    school_data = clean_school(matchObj.group())

    check_school = school_exists(school_data['name'], school_data['mascot'], school_data['city'], school_data['state'])
    if not (check_school.exists):
        school_id = insert_school(school_data)
    else:
        school_id = check_school.school_id

    insert_athlete_school(athlete_id, school_id)

    return school_id

# scraping data from page of individual athlete
def scrape_athlete(data, athlete_id, school_id):
    global athletes_stored
    global events

    lines = []


    print("Scraping " + data['athlete'] + " ", end = '')

    link = "https://www.athletic.net/TrackAndField" + data['athlete_link'] + "&L=0"
    soup = get_soup(link)

    tags = soup.find_all(["td", "h4", "h5"])

    lines = clean_tags(tags, lines)

    result = []
    result_index = 1

    for line in lines:

        # Check if line denotes season
        if "Outdoor Season" in line or "Indoor Season" in line:
            season = line
        else:

            # Check if line denotes event
            if line in events:
                event = line

            else:

                # Based on structure of page get contents of result and send to insert
                if result_index % 5 > 0:
                    result.append(line)
                    result_index += 1

                else:
                    if not (result_exists(data)):
                        event_id = -1
                        meet_id = -1

                        result = clean_result(result, season, event) # get info out of result and turn into dict
                        check_event = event_exists(event)
                        if not (check_event.exists):
                            event_id = insert_event(event)
                        else:
                            event_id = check_event.event_id
                        # insert_result_event(result_id, check_event['event_id'])
                        # get info out of result and turn into dict
                        meet_data = clean_meet(result, data['athlete'])

                        check_meet = meet_exists(meet_data['name'], meet_data['date'])
                        if not (check_meet.exists):
                            meet_id = insert_meet(meet_data)
                            # insert_result_meet(result_id, meet_id)
                            insert_meet_school(meet_id, school_id)
                        else:
                            meet_id = check_meet.meet_id



                        result_id = insert_result(result, season, event, event_id, meet_id) # dont need to pass season and event here
                        insert_athlete_result(athlete_id, result_id) # maintain relationship

                    result_index = 1
                    result = []


# gets necessary data from one result then passes in athletes link to be scraped
def scrape_result_table (soup):
    global athletes_stored

    table = soup.find_all("td")
    athlete_links = get_athlete_links(soup)
    school_links = get_school_links(soup)


    # set i to keep track of what line of soup we're on
    result_index = 0

    # set a to keep track of which link we're on
    link_index = 0
    for athlete_result in table:
        # only store as many athletes as specified so things dont get out of hand
        # set to any negative number to run scrape of full site


        # pull text out of tag
        text = athlete_result.getText()

        # header data prior to 9
        if result_index > 8:

            # dictionary to store data of single athlete to then be
            # passed to store() <- [this may change]
            data ={}

            # get grade of athlete
            if result_index%9 == 1:
                grade = text
                if grade == "-":
                    grade = "?"

            if result_index%9 == 2:
                athlete = text
                athlete_link = athlete_links[link_index]
                # if link_index >= len(school_links):
                #     debug_message(school_links, "list", False)
                #     print("size: " + str(len(school_links)) + "\nindex: " + str(link_index))
                school_link = school_links[link_index]
                link_index += 1

            # get school of athlete
            if result_index%9 == 6:
                school = text

            # get meet of mark and pass all data on
            if result_index%9 == 8:

                if(athletes_stored == int(sys.argv[2])):
                    quit("", True)

                athletes_stored += 1

                data.update({'grade': grade,'athlete': athlete, 'athlete_link': athlete_link, 'school_link': school_link, 'school': school})

                # check if athlete already exists in database before
                # going to page and scraping

                debug_length = len("Scraping " + athlete + " ")
                debug_width = 65 - debug_length
                check_athlete = athlete_exists(data['athlete'], data['grade'], data['school'])
                if not (check_athlete.exists):
                    try:
                        school_id = -1
                        athlete_id = insert_athlete(data)
                        # moved scrape_athlete, not sure if bad
                        if school_link == "Unattached":
                            scrape_school_deep(data, athlete_id)
                            school_id = 1 # just a default for now for unattached people
                        else:
                            school_id = scrape_school(data, athlete_id)

                        scrape_athlete(data, athlete_id, school_id) # to here
                        print_scrape_result(" Success", "green", debug_width)
                    except Exception as e:
                        print_scrape_result(" Failure", "red", debug_width)
                        # add failures to log file
                        handle_scrape_exception(e, athlete_link)

                else:
                    print("Scraping " + athlete + " ", end = '')
                    print_scrape_result(" Athlete exists", "yellow", debug_width)

                    # add repeats to logfile
                    handle_repeat_athlete(athlete_link)

        result_index += 1


# builds url to loop through every page for a specific event
def build_result_url(num_page, event_url):
    print("\nScraping Rankings List...\n")
    for page in range(num_page):
        results_url = event_url

        # only pages after the first need &page=x added on
        if page > 0:
            results_url = event_url + "&page=" + str(page)

        # get soup of page and pass to parser
        soup = get_soup(results_url)
        scrape_result_table(soup)

        print("\nNext Page...\n")


# build next part of url by adding event and other necessary info
def build_event_url(year):
    # builds url for a certain event number
    # get event from 1 to 478 (keeping small for testing)
    for event in range(1, 2):

        # at this level make it to base page of an event
        # need to find amount of results
        event_url = year + "&Event=" + str(event)
        num_results = get_num_results(get_soup(event_url))
        print("Parsing event " + str(event))
        print(str(num_results) + " results")

        # event has no results reported and is skipped
        if num_results is None:
            print("Skipping event.")
            continue

        # get num page for each event
        # 100 results per page, + 2 for first page and excess
        num_page = int((num_results /100) + 2)
        print(str(num_page) + " pages")

        # build next part of url (results in page)
        build_result_url(num_page, event_url)

        print("\nNext Event...\n")


# Takes the years file and reads line by line
# loops through all possible pages of events and years
def build_year_url(years):
    line = years.readline()
    year_num = 1

    # get link to each year of events
    while line:
        year = line.strip()
        print("Parsing year " + str(year_num))

        # build next part of url (event)
        build_event_url(year)

        # advance to next year
        print("\nNext Year...\n")
        year_num += 1
        line = years.readline()


# junk function for debugging things
def debug(soup):
  #print("lol")
  # gets number of results for an event
  # results (soup)

  # # prints page contents
  # table = soup.find_all("td")
  # #links = table.find_all("a")
  # i = 0
  # for e in table:
  #   text = e.getText()
  #   # print (text + " --- "+ str(i))
  #   print (e.a['href'])
  #   i += 1
  #

    temp_links = [td.a for td in soup.findAll('td')]
    athlete_links = []
    for link in temp_links:
        if not (link is None):
            temp = str(link)
            q1 = temp.index("/")
            q2 = temp.index(">") - 1
            # print (temp[q1:q2])
            athlete_links.append(temp[q1:q2])


# driver
def main():
    timer("start")

    # Debugging, pass link to play with html
    if sys.argv[1] == "-debug":
        print("Entering debug mode:")
        debug(get_soup(sys.argv[2]))

    # Uses year links from years.txt to loop through
    # all athletic.net top even results
    # this should reach every athlete ever stored
    elif sys.argv[1] == "-full":
        print("Starting with full scrape functionality...\n")
        with open("years.txt") as fp:
            build_year_url(fp)
        debug_message("Scrape Complete", "Complete", True)


if __name__== "__main__":
  main()

