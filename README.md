# GitHubMining

A shiny tool for mining GitHub data

You can run this application from your R console or RStudio by installing the `shiny` package and then entering `runGitHub('GitHubMining', 'fcharte')`. You can also fork this repo and introduce your own changes.

## Introduction

This application allows you to access the GitHub API to get data about users, repositories, contributions, etc.

Use the buttons at the top of the page to access the sections of the application.

## Rate limits accessing GitHub API

GitHub limits the number of calls a user can send to its API. Use the **Update** button, located in the left panel, to see your current limits.

More restrictive limits are applied to anonymous users than to authenticated users. So, to extend de number of calls you can make please introduce your GitHub user name and password. These credentials will be used only for accessing the GitHub API, they are not sent anywhere.
