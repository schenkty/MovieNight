# MovieNight

For this project you will be building an app to help two friends agree on what movie to watch. The two persons will be using with the same iPhone with the app installed, simply by handing it back and forth between them. Your app will access The Movie Database (https://www.themoviedb.org). Unlike the Star Wars API which you used for project 5, the Movie Database API is not completely open, hence an API key is required. You need to request the API key as one of the first steps.

We encourage you to contemplate and experiment with the best way to get two people to select a movie. Explore the API documentation (refer to the two links provided in the Project Resource section) to see what functionalities and data are available to you. As you may discover it is often easier to think about ways you would like to fetch, parse and match the data, than it is to actually implement them. We suggest that you begin with a one or two steps matching process before embarking on anything more complex.

For the workflow of the app, one approach would be to first query for the most popular actors and have each user take turns selecting 5 actors they like (this could be done using a TableView or Picker). Then, based on the selections, query for movies with combinations of those actors and display the list of movies in a TableView which the users can again select from. The final result would then be based on matches in the lists. Alternatively, you could have each user select a fews genres and then bring up a list of recent movies in the overlapping genres.

Use your creativity to decide how the workflow should be. Please do note that the primary objective of this project is for you to demonstrate the proficiency with TableViews, API calls and data modeling, rather than creating complex matching algorithms. That said, once the primary objective is achieved, feel free to experiment with more creative, elegant, or complex matching algorithms.

We provided some sample mockups, image assets and icons. Feel free to use them, or find or create your own design elements, so long as it provides a good user experience.

Please note that this project is more open-ended than the previous ones. Experiment and give the app your own personal touch. There are many valid ways you could approach this problem.

Project Instructions

To complete this project, follow the instructions below. If you get stuck, ask a question in the community.

You can submit this project in either Swift 2.3 or Swift 3. If you are using Xcode 8.x and Swift 2.3, you will need to download and use the empty Swift 2.3 starter files template to start your project. (Xcode 8 might still prompt you to convert the starter file, if so, please select “convert” and “Swift 2.3”. It should then tell you that there is nothing that needs to be changed.)

First of all, please register as a user at themoviedb.org and request an API key.
Once you have received your API key, begin experimenting with requests. Bear in mind this can be tested in a web browser, rather than in code, to help see what responses look like. You should also keep the API documentation handy for new ideas and troubleshooting.

Create a workflow where both users can select a set of movie criteria such as genre, actors/actress, etc. The app should perform the matches and present the best possible selection to the users. Please include at least two parameters.
Note: the screenshots provided are only suggestions, feel free to use other UI elements or ideas you might have.
This project is somewhat open-ended, but make sure it demonstrates the proper usage of:
UITableViews
Asynchronous API call and Error handling
Autolayout
Data Modelling

Please make sure you tested the app for a variety of inputs, including those which may not be ideal user behavior. Be sure your app can handle any issues gracefully.

Extra Credit

To get an "exceeds" rating, you can expand on the project in the following ways:

Implement more than 2 selection criteria for the users to specify their preferences, and create the associated TableView and TableViewCells to support the selection.
