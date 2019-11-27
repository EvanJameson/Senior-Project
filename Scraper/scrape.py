import sys
import urllib.request
import pymongo
import time
import json
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup

# unicode dot char?
# convert keys to base64? hex?

athletes_stored = 0
parse_time_start = time.time()
# parse_time_stop = time.time()
months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
events =["55 Meter Dash", "60 Meter Dash", "100 Meters", "200 Meters", "300 Meters", "400 Meters", "500 Meters", "800 Meters", "1600 Meters", "3200 Meters",
         "60m Hurdles - 39\"", "110m Hurdles - 36\"", "110m Hurdles - 39\"", "300m Hurdles - 30\"", "300m Hurdles - 36\"",
         "4x100 Relay", "4x200 Relay", "4x400 Relay", "4x800 Relay", "4x1600 Relay", "SMR 100-100-200-400m", "DMR 1200-400-800-1600m - [12-4-8-16]",
         "Shot Put - 10lb", "Shot Put - 12lb", "Discus - 1.6kg", "High Jump", "Pole Vault", "Long Jump", "Triple Jump",
         "400 Meters - Relay Split", "SMR 1600m", "Swedish 100-200-300-400m", "SMR 100-100-200-400m" ,"100 Meters - Wheelchair",
         "Discus - 1.6kg"
         ]

# FIX QUIT
def quit(msg, timer_stop):
    global parse_time_start
    global parse_time_stop

    halt = "\n=================================\n-------|EXECUTION HALTED:|-------\n=================================\n\n"
    bump = "\n\n=================================\n"
    if(timer_stop) and msg == "":
        timer("stop")
        print (parse_time_stop)
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


def debug_message(msg, flag, stop):

    # Print out key value pairs of dictionary
    if flag == "dict" :
        print("========================================")
        for k in msg:
            print (str(k) + ": " + str(msg[k]))
        if stop:
            quit("Dict Printed",True)

    elif flag == "json":
        print ("JSON Struct")
        print (json.dumps (msg, sort_keys=True, indent=4))
        if stop:
            quit("JSON Printed",True)

    # Print soup
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

    # Strings
    else:
        if stop:
            quit(msg,True)
        else:
            print(msg)

# gets all links and returns as a list
# to be consumed during parsing
def get_links(soup):
    temp_links = [td.a for td in soup.findAll('td')]
    athlete_links = []
    for link in temp_links:
        if (not (link is None)) and "/Athlete" in str(link):
            temp = str(link)
            q1 = temp.index("/")
            q2 = temp.index(">") - 1
            # print (temp[q1:q2])
            athlete_links.append(temp[q1:q2])
    # debug_message(athlete_links, "list", True)
    return athlete_links


# inserts info of single athlete into database
def store(data, sr_data, se_data, doc):
    # build document by piecing these together
    store_doc = {'Athlete': {'Name': data['athlete'], 'School': data['school'], 'Grade': data['grade'],'TF':doc}}
    # debug_message(doc, "json", True)

    # print(data)
    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
    mydb = myclient["AthleteDB"] # names db
    mycol = mydb["athletes"]  # names collection
    x = mycol.insert_one(store_doc)


# goes to page of specific athlete and gets all results and stores
def scrape_athlete(data):

    global athletes_stored
    global events

    lines = []

    # flags to track where I am in athlete page
    sr_flag = False      # Season records
    sr_event_flag = False
    sr_season_flag = False
    sr_grade_flag = False
    sr_mark_flag = False
    sr_check = False #checking JSON for data

    se_flag = False     # Seasons - normal results
    se_event_flag = False
    se_pos_flag = False
    se_mark_flag = False
    se_date_flag = False
    se_meet_flag = False

    # variables to store data
    sr_event = ""
    sr_season = ""
    sr_grade = ""
    sr_mark = ""

    sr_data = []

    se_grade = ""
    se_school = ""

    se_event = ""
    se_pos = ""
    se_mark = ""
    se_wind = ""
    se_pr = False
    sr_sr = False
    se_date = ""
    se_meet = ""

    se_data = {}


    doc = {'records': sr_data, 'results': se_data}

    # only store as many athletes as specified so
    # things dont get out of hand
    if(athletes_stored == int(sys.argv[2])):
        quit("", True)

    athletes_stored += 1

    link = "https://www.athletic.net/TrackAndField" + data['athlete_link']
    # link = "https://www.athletic.net/TrackAndField/Athlete.aspx?AID=9261230"
    soup = getsoup(link)
    tags = soup.find_all(["td", "h4", "h5"])

    prev_line = ""
    i = 0

    # clean tags and remove duplicate lines
    for e in tags:
        cur_line = e.getText().strip()
        if cur_line != prev_line:
            lines.append(cur_line)

        prev_line = e.getText().strip()

    # debug_message(lines, "tags_text", True)
    # debug_message(tags, "tags_text", True)



    # loops get all season records and all marks recorded
    for e in lines:
        line = e

        # event -> season -> grade -> mark
        # skip first line, "Season Records"
        if sr_flag and not se_flag:
            # get event
            if line in events:
                sr_event_flag = True

            if sr_event_flag:
                sr_event_flag = False
                sr_event = line
            else:
                # get season
                if not sr_season_flag:
                    sr_season_flag = True
                    sr_season = line
                else:
                    # get grade
                    if not sr_grade_flag:
                        sr_grade_flag = True
                        sr_grade = line
                    else:
                        # get mark, set flags false, store data
                        sr_mark = line
                        sr_season_flag = False
                        sr_grade_flag = False
                        # check if event is already entered
                        e_index = -1
                        for event in doc["records"]:
                            e_index += 1
                            if event["event"] == sr_event:
                                sr_check = True
                                break
                        if (sr_check): #already in
                            doc["records"][e_index]["marks"].append(
                                    {
                                        "year": sr_season,
                                        "mark": sr_mark
                                    }
                                )
                            sr_check = False # need to reset manually
                        else:
                            doc["records"].append(
                                    {
                                        "event": sr_event,
                                        "marks": [
                                            {
                                                "year": sr_season,
                                                "mark": sr_mark
                                            }
                                        ]
                                    }
                                )

        # have season records, need all results now
        elif se_flag and not sr_flag:
            # get event
            if line in events:
                se_event_flag = True

            if se_event_flag:
                se_event_flag = False
                se_event = line.replace('.', '-') # dicus 1.6kg
                # print(se_event)
            else:
                # get pos
                if not se_pos_flag:
                    se_pos_flag = True
                    se_pos = line
                else:
                    # get mark
                    if not se_mark_flag:
                        se_mark_flag = True
                        # check for pr and set to true if found
                        if "PR" in line:
                            se_pr = True
                            line = line.replace('PR','')
                        else:
                            se_pr = False

                        if "SR" in line:
                            se_sr = True
                            line = line.replace('SR','')
                        else:
                            se_sr = False

                        #
                        # pull text apart to get wind speed
                        if "(" in line and ")" in line:
                            w1 = line.index("(")
                            w2 = line.index(")")
                            se_wind = line[w1:w2+1]
                            line = line[0:w1]

                        else:
                            se_wind = ""

                        se_mark = line
                    else:
                        # get date
                        if not se_date_flag:
                            se_date_flag = True
                            se_date = line
                        else:
                            # get meet
                            if not se_meet_flag:
                                se_meet_flag = True
                                se_meet = line.replace('.', '')
                            else:
                                # store data -> set flags to false

                                # new season, add entire thing
                                if not(se_season in se_data):
                                    se_data.update({se_season:
                                        {se_event:
                                        {se_meet:
                                        {'1':
                                        {'pos': se_pos,
                                         'mark': se_mark,
                                         'date': se_date,
                                         'wind': se_wind,
                                         'pr': se_pr,
                                         'sr': se_sr
                                        }}}}})

                                else:
                                    # new event in current season
                                    if not (se_event in se_data[se_season]):
                                        # print("\n======\n" + se_event + "\n======\n")
                                        se_data[se_season].update({se_event:
                                        {se_meet:
                                        {'1':
                                        {'pos': se_pos,
                                         'mark': se_mark,
                                         'date': se_date,
                                         'wind': se_wind,
                                         'pr': se_pr,
                                         'sr': se_sr
                                        }}}})
                                        # print (se_data)

                                    # event is already in, just need to add new mark
                                    else:
                                        # event is in, need to check if running at same meet
                                        if not (se_meet in se_data[se_season][se_event]):
                                            se_data[se_season][se_event].update({se_meet:
                                            {'1':
                                            {'pos': se_pos,
                                             'mark': se_mark,
                                             'date': se_date,
                                             'wind': se_wind,
                                             'pr': se_pr,
                                             'sr': se_sr
                                            }}})
                                        # person is running the same event at the same meet on the same day
                                        else:
                                            se_data[se_season][se_event][se_meet].update(
                                            {'2':
                                            {'pos': se_pos,
                                             'mark': se_mark,
                                             'date': se_date,
                                             'wind': se_wind,
                                             'pr': se_pr,
                                             'sr': se_sr
                                            }})

                                se_pos_flag = False
                                se_mark_flag = False
                                se_date_flag = False
                                se_meet_flag = False
                                se_pr = False
                                se_sr = False




        # check section
        if line == "Season Records":
            sr_flag = True

        # need to get grade and school out
        if "Outdoor Season" in line or "Indoor Season" in line:
            se_flag = True
            sr_flag = False
            se_grade = line[len(line) - 10:]
            se_school = line[line.index("Season") + 29:len(line) - 10]
            se_season = (line[:line.index("Season") + 6] + line[line.index("                    ") + 19:]).replace('.', ' ')
            se_pos_flag = False
            se_mark_flag = False
            se_date_flag = False
            se_meet_flag = False
            se_pr = False
            se_sr = False




        i += 1
    # debug_message(se_data, "json", True)
    # debug_message(sr_data, "dict", True)
    # debug_message(tags, "tags_text", True)

    # here sr_data and se_data are complete, store everything
    store(data, sr_data, se_data, doc)



# check if athlete exists in DB already **TODO**
def athlete_exists(data):
    return False


# parses page based on html soup passed in
# only does one page at a time
def parser (soup):
    table = soup.find_all("td")
    athlete_links = get_links(soup)
    # print("\nParsing Results\n============================================\n")

    # set i to keep track of what line of soup we're on
    i = 0

    # set a to keep track of which link we're on
    a = 0
    for e in table:

        # pull text out of tag
        text = e.getText()

        # this is for links (?)
        link = e

        # header data prior to 9
        if i > 8:

            # dictionary to store data of single athlete to then be
            # passed to store() <- [this may change]
            data ={}

            # position, check for tied athletes and assign
            # appropriate position on list
            if i%9 == 0:
                position = text
                if position == "":
                    position = prev_pos # the position of the tied athletes
                else:
                    prev_pos = position

            # get grade of athlete
            if i%9 == 1:
                grade = text

            # get athlete name and link **TODO**
            # skipping the other links provided for the time being
            if i%9 == 2:
                athlete = text
                athlete_link = athlete_links[a]
                a += 1

            # get mark, check for wind and PR
            if i%9 == 4:
                mark = text

                # set pr to true and remove from mark
                if "PR" in mark:
                    pr = True
                    mark = mark.replace('PR','')
                else:
                    pr = False

                # pull text apart to get wind speed
                if "(" in mark and ")" in mark:
                    w1 = text.index("(")
                    w2 = text.index(")")
                    mark = text[0:w1]
                    wind = text[w1:w2+1]
                else:
                    wind = ""

            # get state of athlete
            if i%9 == 5:
                state = text

            # get school of athlete
            if i%9 == 6:
                school = text

            # get date of mark [mth dy]
            if i%9 == 7:
                date = text

            # get meet of mark and pass all data on
            if i%9 == 8:
                meet = text
                data.update({'position': position,'grade': grade,'athlete': athlete,
                             'athlete_link': athlete_link, 'mark': mark,'wind': wind,
                             'pr': pr,'state': state,'school': school,'date': date,'meet': meet})

                # check if athlete already exists in database before
                # going to page and scarping
                if not (athlete_exists(data)):
                    scrape_athlete(data)

                # store(data) # insert data into DB
                # debug_message(data, "dict", False)
        i += 1


# gets the number of results for an event
def results (soup):
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
def getsoup(link):
    req = Request(link, headers={'User-Agent': 'Mozilla/5.0'})
    fp = urlopen(req)
    mybytes = fp.read()
    html = mybytes.decode("utf8")
    soup = BeautifulSoup(html, "html.parser")
    fp.close()
    return soup


# Takes the years file and reads line by line
# loops through all possible pages of events and years
def mac_daddy(years):
    line = years.readline()

    # get link to each year of events
    while line:
        year = line.strip()

        # builds url for a certain event number
        # get event from 1 to 478 (keeping small for testing)
        for event in range(1, 2):

            # at this level make it to base page of an event
            # need to find amount of results
            event_url = year + "&Event=" + str(event)
            num_results = results(getsoup(event_url))

            # event has no results reported and is skipped
            if num_results is None:
                continue

            # get num page for each event
            # 100 results per page, + 2 for first page and excess
            num_page = int((num_results /100) + 2)

            # builds url to loop through every page for a specific event
            for page in range(num_page):
                results_url = event_url

                # only pages after the first need &page=x added on
                if page > 0:
                    results_url = event_url + "&page=" + str(page)

                # get soup of page and pass to parser
                soup = getsoup(results_url)
                parser(soup)

        # advance to next year
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
    # Parses from the single link passed in
    if sys.argv[1] == "-link":
        parser(getsoup(sys.argv[2]))

    # Debugging, pass link to play with html
    elif sys.argv[1] == "-debug":
        debug(getsoup(sys.argv[2]))

    # Parses an html file based on the filename passed in
    elif sys.argv[1] == "-file":
        with open(sys.argv[2]) as fp:
            file = fp.read()
            soup = BeautifulSoup(file, "html.parser")
            parser(soup)

    # Uses year links from years.txt to loop through
    # all athletic.net top even results
    # this should reach every athlete ever stored
    # [BUT NOT EVERY RESULT EVER STORED]
    elif sys.argv[1] == "-auto":
        with open("years.txt") as fp:
            mac_daddy(fp)



if __name__== "__main__":
  main()

