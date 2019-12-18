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
events =["55 Meter Dash", "60 Meter Dash", "100 Meters", "200 Meters", "300 Meters", "400 Meters", "500 Meters", "800 Meters", "1600 Meters", "3200 Meters",
         "60m Hurdles - 39\"", "110m Hurdles - 36\"", "110m Hurdles - 39\"", "300m Hurdles - 30\"", "300m Hurdles - 36\"",
         "4x100 Relay", "4x200 Relay", "4x400 Relay", "4x800 Relay", "4x1600 Relay", "SMR 100-100-200-400m", "DMR 1200-400-800-1600m - [12-4-8-16]",
         "Shot Put - 10lb", "Shot Put - 12lb", "Discus - 1.6kg", "High Jump", "Pole Vault", "Long Jump", "Triple Jump",
         "400 Meters - Relay Split", "SMR 1600m", "Swedish 100-200-300-400m", "SMR 100-100-200-400m" ,"100 Meters - Wheelchair",
         "Discus - 1.6kg"
         ]

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
    if(athletes_stored == int(sys.argv[2])):
        quit("", True)

    athletes_stored += 1
    print("Scraping [" + str(athletes_stored) + "/" + sys.argv[2] + "] " + data['athlete'] + " ", end = '')

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
                    if not (athlete_exists(data)):
                        insert_result(result, season, event)
                    # print("-------------")
                    # print (event)
                    # debug_message(result, "list", False)
                    result_index = 1
                    result = []



# gets necessary data from one result then passes in athletes link to be scraped
def scrape_result_data (soup):
    global athletes_stored

    table = soup.find_all("td")
    athlete_links = get_links(soup)
    print("\nScraping Rankings List...\n")

    # set i to keep track of what line of soup we're on
    i = 0

    # set a to keep track of which link we're on
    a = 0
    for e in table:

        # pull text out of tag
        text = e.getText()

        # header data prior to 9
        if i > 8:

            # dictionary to store data of single athlete to then be
            # passed to store() <- [this may change]
            data ={}

            # get grade of athlete
            if i%9 == 1:
                grade = text

            # get athlete name and link **TODO**
            # skipping the other links provided for the time being
            if i%9 == 2:
                athlete = text
                athlete_link = athlete_links[a]
                a += 1

            # get school of athlete
            if i%9 == 6:
                school = text

            # get meet of mark and pass all data on
            if i%9 == 8:

                data.update({'grade': grade,'athlete': athlete, 'athlete_link': athlete_link, 'school': school})

                # check if athlete already exists in database before
                # going to page and scarping
                if not (athlete_exists(data)):
                    debug_length = len("Scraping [" + str(athletes_stored) + "/" + sys.argv[2] + "] " + data['athlete'] + " ")

                    try:
                        scrape_athlete(data)
                        print('{:{fill}{align}{width}}'.format(colored(" Success", 'green'), fill = '-', align = '>', width = 65 - debug_length))
                    except Exception as e:
                        print('{:{fill}{align}{width}}'.format(colored(" Failure", 'red'), fill = '-', align = '>', width = 65 - debug_length))
                        # print(e)
                else:
                    print("Athlete exists, skipping...")

        i += 1





# builds url to loop through every page for a specific event
def build_result_url(num_page, event_url):
    for page in range(num_page):
        results_url = event_url

        # only pages after the first need &page=x added on
        if page > 0:
            results_url = event_url + "&page=" + str(page)

        # get soup of page and pass to parser
        soup = get_soup(results_url)
        scrape_result_data(soup)


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
    elif sys.argv[1] == "-debug":
        print("Entering debug mode:")
        debug(get_soup(sys.argv[2]))

    # Uses year links from years.txt to loop through
    # all athletic.net top even results
    # this should reach every athlete ever stored
    elif sys.argv[1] == "-auto":
        print("Starting with full scrape functionality...")
        with open("years.txt") as fp:
            build_year_url(fp)


if __name__== "__main__":
  main()

