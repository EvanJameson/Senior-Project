import sys
import urllib.request
import pymongo
import time
import json
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
from termcolor import colored

athletes_stored = 0
parse_time_start = time.time()
# parse_time_stop = time.time()
months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
events = ["100 Meters", "200 Meters", "400 Meters", "800 Meters", "1500 Meters", "1600 Meters", "1 Mile", "3000 Meters", "3200 Meters", "2 Miles", "5000 Meters", "110m Hurdles - 33\"", "110m Hurdles - 36\"", "110m Hurdles - 39\"", "110m Hurdles - 42\"", "300m Hurdles - 30\"", "300m Hurdles - 33\"", "300m Hurdles - 36\"", "300m Hurdles - 39\"", "400m Hurdles - 30\"", "400m Hurdles - 33\"", "400m Hurdles - 36\"", "2k Steeplechase", "3k Steeplechase", "4x100 Relay", "4x200 Relay", "4x400 Relay", "4x800 Relay", "4x1600 Relay", "SMR 100-100-200-400m", "SMR 1600m", "DMR 1200-400-800-1600m", "Shot Put", "Discus", "Javelin", "High Jump", "Pole Vault", "Long Jump", "Triple Jump", "Hammer", "25 Meter Dash", "30 Meter Dash", "35 Meter Dash", "40 Meter Dash", "45 Meter Dash", "50 Meter Dash", "55 Meter Dash", "60 Meter Dash", "70 Meter Dash", "75 Meter Dash", "80 Meter Dash", "90 Meter Dash", "100 Meters", "110 Meters", "145 Meters", "150 Meters", "160 Meters", "165 Meters", "180 Meters", "200 Meters", "250 Meters", "300 Meters", "360 Meters", "400 Meters", "500 Meters", "550 Meters", "600 Meters", "720 Meters", "750 Meters", "800 Meters", "800m Racewalk", "1000 Meters", "1200 Meters", "1440 Meters", "1500 Meters", "1500m Racewalk", "1600 Meters", "1600m Racewalk", "2000 Meters", "2400 Meters", "3000 Meters", "3000m Racewalk", "3200 Meters", "5000 Meters", "5000m Racewalk", "8000 Meters", "10,000 Meters", "10,000 Meters Racewalk", "20,000 Meters Racewalk", "1-Hour Racewalk", "40m Hurdles", "45m Hurdles", "50m Hurdles", "55m Hurdles - 30\"", "55m Hurdles - 33\"", "55m Hurdles - 39\"", "55m Hurdles - 42\"", "60m Hurdles - 30\"", "60m Hurdles - 33\"", "60m Hurdles - 36\"", "60m Hurdles - 39\"", "65m Hurdles", "70m Hurdles", "75m Hurdles", "80m Hurdles", "100m Hurdles - 30\"", "100m Hurdles - 33\"", "100m Hurdles - 36\"", "110m Hurdles", "195m Hurdles", "200m Hurdles", "300m Hurdles - 30\"", "300m Hurdles - 33\"", "400m Hurdles - 30\"", "1k Steeplechase", "1.5k Steeplechase", "1 Mile Steeplechase", "2k Steeplechase", "3k Steeplechase", "4x50 Relay", "4x55 Relay", "4x60 Relay", "4x60 Shuttle Relay", "4x75 Relay", "4x80 Relay", "4x100 Relay", "4x100 Throwers Relay", "4x133 Relay", "4x145 Relay", "4x150 Relay", "4x160 Yard Relay", "4x160 Relay", "4x180 Relay", "4x200 Relay", "4x225 Relay", "4x240 Relay", "4x300 Relay", "4x320 Relay", "4x360 Relay", "4x375 Relay", "4x400 Relay", "4x600 Relay", "4x720 Relay", "4x750 Relay", "4x800 Relay", "4x1200 Relay", "4x1500 Relay", "4x1600 Relay", "4x3200 Relay", "SMR 200-100-100-200m", "SMR 200-180-180-216m", "SMR 100-100-200-400m", "SMR 200-200-300-100m", "SMR 160-80-80-480m", "Swedish 100-200-300-400m", "SMR 300-200-200-500m", "SMR 100-300-600-200m", "SMR 400-200-200-400m", "SMR 200-200-600-400m", "SMR 180-180-360-720m", "SMR 435-145-290-580m", "SMR 450-150-150-750m", "SMR 400-160-160-800m", "SMR 1600m", "SMR 320-160-480-640m", "SMR 480-160-160-800m", "SMR 600-200-400-800m", "MMR 800-400-400-800m", "MMR 1200-800-200-400m", "DMR 1000-200-400-800m", "DMR 200-400-800-1200m", "DMR 800-200-400-1600m", "DMR 400-400-800-1600m", "DMR 400-800-800-1200m", "DMR 1000-200-600-1600m", "DMR 400-800-1200-1200m", "DMR 1200-400-800-1600m", "DMR 800-800-1600-1600m", "DMR 1200-800-1600-3200m", "4x50 Shuttle Hurdles", "4x51.5 Shuttle Hurdles", "4x55 Shuttle Hurdles", "4x60 Shuttle Hurdles", "4x65 Shuttle Hurdles", "4x70 Shuttle Hurdles", "4x80y Shuttle Hurdles", "4x100 Shuttle Hurdles", "4x102.5 Shuttle Hurdles", "4x110 Shuttle Hurdles", "4x120y Shuttle Hurdles", "4x160m Shuttle Hurdles", "4x200m Shuttle Hurdles", "4x300 Shuttle Hurdles", "4x400 Shuttle Hurdles", "4x440y Shuttle Hurdles", "Shot Put - 4lb", "Shot Put - 6lb", "Shot Put - 8lb", "Shot Put - 10lb", "Shot Put - 12lb", "Shot Put - 16lb", "Shot Put - 3kg", "Shot Put - 4kg", "Shot Put - 5kg", "Shot Put - 6kg", "JV Shot Put", "Softball Throw", "Baseball Throw", "Soccerball Throw", "Discus - 1kg", "Discus - 1.5kg", "Discus - 1.6kg", "Discus - 1.75kg", "Discus - 2kg", "Javelin - 300g TJ", "Javelin - 500g TJ", "Javelin - 600g", "Javelin - 800g", "High Jump", "Pole Vault", "Long Jump", "Standing Long Jump", "Triple Jump", "Standing Triple Jump", "Hammer - 3kg", "Hammer - 4kg", "Hammer - 5kg", "Hammer - 6kg", "Hammer - 12lb", "Hammer - 16lb", "Weight Throw", "Super Weight Throw", "Ultra Weight Throw", "Medicine Ball Throw OHB", "Medicine Ball Throw UHF", "Roster Only", "Attendee", "Other", "Triathlon Score", "Tetrathlon Score", "Pentathlon Score (Indoor)", "Pentathlon Score (Outdoor)", "Heptathlon Score", "Octathlon Score", "Decathlon Score", "Throws Penthlon Score", "40 Yard Dash", "45 Yard Dash", "50 Yard Dash", "60 Yard Dash", "100 Yard Dash", "110 Yard Dash", "200 Yards", "220 Yards", "300 Yards", "330 Yards", "440 Yards", "500 Yards", "600 Yards", "660 Yards", "880 Yards", "1000 Yards", "1320 Yards", "Mile Racewalk", "1 Mile", "2 Miles", "3 Miles", "6 Miles", "Half Marathon", "Marathon", "40y Hurdles", "45y Hurdles", "50y Hurdles", "60y Hurdles", "120y Hurdles", "180y Hurdles", "200y Hurdles", "220y Hurdles", "330y Hurdles", "440y Hurdles", "4x50 Yard Shuttle Relay", "4x110 Yard Relay", "4x200 Yard Relay", "4x220 Yard Relay", "4x320 Yard Relay", "4x400 Yard Relay", "4x440 Yard Relay", "4x800 Yard Relay", "4x880 Yard Relay", "4xMile Relay", "SMR 110-110-220-440y", "SMR 110-220-440-880y", "SMR 200-200-400-880y", "DMR 1320-440-880-Mile", "4x55y Shuttle Hurdles"]

# =============================================
# ---------------|HELPER FUNCS|----------------
# =============================================

# FIX QUIT
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

    elif flag == "complete":
        if stop:
            quit(msg, True)
        else:
            print(msg)

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
def clean_lines(tags, lines):
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


# check if athlete exists in DB already **TODO**
def athlete_exists(data):
    return False


# check if result exists in DB already **TODO**
def result_exists(data):
    return False


# clean up result and extract wind and pr / sr
def clean_result(result):
    pos = result[0]
    mark = result[1]
    date = result[2]
    meet = result[3]
    pr = False
    sr = False
    wind = ""

    # Clean position
    if not(pos.isnumeric()):
        pos = "--"

    # Clean mark
    if "(" in mark and ")" in mark:
        w1 = mark.index("(")
        w2 = mark.index(")")
        wind = mark[w1:w2+1]
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

    result[0] = pos
    result[1] = final_mark
    result[2] = date
    result[3] = meet
    result.append(wind)
    result.append(pr)
    result.append(sr)

    return result


def print_scrape_result(msg, color, debug_width):
    global athletes_stored
    print('{:{fill}{align}{width}}'.format(colored(msg, color), fill = '-', align = '>', width = debug_width), end='')
    print(" [" + str(athletes_stored) + "/" + sys.argv[2] + "] ")


def handle_scrape_exception(e, athlete_link):
    log = open("fail_logfile.txt", "a")
    log.write("-------------------------------------------------------------------\n")
    log.write("https://www.athletic.net/TrackAndField" + athlete_link + "\n")
    log.write(str(e))
    log.write("\n-------------------------------------------------------------------\n")
    log.close()


def handle_repeat_athlete(athlete_link):
    log = open("repeat_logfile.txt", "a")
    log.write("https://www.athletic.net/TrackAndField" + athlete_link)
    log.close()

# =============================================
# ----------------|MAIN FUNCS|-----------------
# =============================================

# inserts info of single athlete into database
def store(data, sr_data, se_data, doc):
    # build document by piecing these together
    store_doc = {'athlete': {'name': data['athlete'], 'school': data['school'], 'grade': data['grade'],'tf':doc}}
    # debug_message(doc, "json", True)

    # print(data)
    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
    mydb = myclient["AthleteDB"] # names db
    mycol = mydb["athletes"]  # names collection
    x = mycol.insert_one(store_doc)


# Convert to appropriate datatypes and insert into table
def insert_result(result, season, event):
    result = clean_result(result)

    pos = result[0]
    mark = result[1]
    date = result[2]
    meet = result[3]
    wind = result[4]
    pr = result[5]
    sr = result[6]


# scraping data from page of individual athlete
def scrape_athlete(data):
    global athletes_stored
    global events

    lines = []

    # only store as many athletes as specified so things dont get out of hand
    # set to any negative number to run scrape of full site
    if(athletes_stored == int(sys.argv[2])):
        quit("", True)

    athletes_stored += 1
    print("Scraping " + data['athlete'] + " ", end = '')

    link = "https://www.athletic.net/TrackAndField" + data['athlete_link']
    soup = get_soup(link)
    tags = soup.find_all(["td", "h4", "h5"])

    lines = clean_lines(tags, lines)

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
                        insert_result(result, season, event)

                    result_index = 1
                    result = []


# gets necessary data from one result then passes in athletes link to be scraped
def scrape_result_table (soup):
    global athletes_stored

    table = soup.find_all("td")
    athlete_links = get_links(soup)


    # set i to keep track of what line of soup we're on
    result_index = 0

    # set a to keep track of which link we're on
    link_index = 0
    for athlete_result in table:


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

            # get athlete name and link **TODO**
            # skipping the other links provided for the time being
            if result_index%9 == 2:
                athlete = text
                athlete_link = athlete_links[link_index]
                link_index += 1

            # get school of athlete
            if result_index%9 == 6:
                school = text

            # get meet of mark and pass all data on
            if result_index%9 == 8:

                data.update({'grade': grade,'athlete': athlete, 'athlete_link': athlete_link, 'school': school})

                # check if athlete already exists in database before
                # going to page and scraping

                debug_length = len("Scraping " + athlete + " ")
                debug_width = 65 - debug_length
                if not (athlete_exists(data)):
                    try:
                        scrape_athlete(data)
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
    elif sys.argv[1] == "-auto":
        print("Starting with full scrape functionality...\n")
        with open("years.txt") as fp:
            build_year_url(fp)
        debug_message("Scrape Complete", "Complete", True)


if __name__== "__main__":
  main()

