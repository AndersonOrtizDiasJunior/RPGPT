# Overview

This project is a chat app where you can play tabletop RPG with ChatGPT.
Objectives:
  - Demonstrate applied understanding of MVVM archteture
  - Display applied knowledg of the SwiftUI framework
  - Exemplify applied knowledg of the Combine framework
  - Illustrate skills to integrate third party libs using Swift Package Manager
  - Show Clean Code and best industry pratices
  - Prove deep understanding of Swift programming language

[Software Demo Video](https://www.youtube.com/watch?v=uNczYa18kVg&t=14s)

# Development Environment
XCode 13.3
Swift
Combine
Swift UI
OpenAI Swift

# Third Party Libs
* [OpenAI Swift](https://github.com/adamrushy/OpenAISwift)

# Future Work

{Make a list of things that you need to fix, improve, and add in the future.}
* Add Unit Tests
* Add UI Tests
* Create Service to retrieve API Key

#How to Run
In order to make the app work, you need to create an enviroment variable with an Open AI API Key, you can do this following the following steps:

Creating an OpenAI API Key(Skip this step with you already have an API key):
1 - access https://openai.com/product
2 - Click "Get Started"
3 - Create an Open AI account or sign in
4 - Click "Personal" > "View API Keys"
5 - Select "Create New Secret key"
6 - Copy the API Key and store it in a safe place

Adding variable to XCode:
1 - In XCode, select the RPGPT Scheme near the run button and then "Edit Scheme"
2 - In "Arguments > Enviroment Variables' create a variable with the name "API_KEY" and the value of the API Key you created
3 - Make sure it selected and build the application
