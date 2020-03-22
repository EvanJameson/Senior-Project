<h1 align="center">Welcome to my Senior-Project 👋</h1>
<p>
</p>

> Full stack senior project with the purpose of making Cross Country and Track & Field results easily accessible. Longterm goal of implementing new data representation methods and other misc. functionality based on the requests of coaches and athletes.

## Backend

* Web Scraper
  * Implemented in Python using the Beautiful Soup library to facilitate HTML scraping.
  * Can scrape input files via the "-file" flag.
  * Can scrape a hardcoded link via the "-auto" flag. Number of athletes scraped can be limited with an optional argument.
  * Data Scraped from each Athletes page is stored in a JSON format then inserted into a local MongoDB.

* MongoDB
  * No-SQL database that stores data in JSON documents
  * Plan to structure the database with 3 easily searchable indexes, Athletes, Schools, and Meets. Storing multiple copies of the data may be redundant but greatly increases performance.

* Express
  * node.js framework as an intermediary between the app and database, queried via REST API
  * Currently has 2 GET routes, one for retrieving all athletes and one for retrieving specific athletes based on their name.
  * API Documentation: https://app.swaggerhub.com/apis/EvanJameson/MTP_API/1.0.0

## Frontend

* SwiftUI
  * Writing in SwiftUI to create an iOS app to allow users to easily query the database.

## Author

👤 **Evan Jameson**

* Github: [@EvanJameson](https://github.com/EvanJameson)
