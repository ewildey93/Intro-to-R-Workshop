#### Introduction to R ####
## Adapted from Courtney Check's intro to R workshop ##


# R is a really useful tool for statistical analysis. 
# And, consequently, we usually learn it in the context of doing statistics. 
# But 90% of the time when an analysis won't run, it isn't a statistics problem, 
# but a programming problem (i.e. the data isn't assigned the right data type, the data is being indexed wrong, etc.) 
# And knowing how to program can also help you design your data structure properly on the front end,
# so that it will be easy to work with later. 


### Sections
#   1. What is R?
#   2. Data management in R
#   3. R as a calculator
#   4. Data types & storage
#         - vectors
#         - data frames
#   5. Manipulating data


### 1. WHAT IS R? ----

# R is both the name of the language and the software used for data storage and manipulation.
# RStudio is the interface. 

### When you first open RStudio, you will be greeted by three panels:

# - The interactive R console
# - Environment/History (tabbed in upper right)
#       - Environment tab shows all of your "objects" (more on that later)
# - Files/Plots/Packages/Help (tabbed in lower right)
#       - "Files" shows all the files in the folder/directory you are working in
#       - "Plots" displays plots you generate
#       - "Packages" displays any packages you have downloaded and installed in R. 
#       - "Help" will show you the description of functions. 
# - Once you open files, such as R scripts, an editor panel will also open in the top left. The scripts are
#   basically like a notepad, where you write the code that you want to run in the console.

### How do you start working in R?

# Best practice for organizing R files is to start a "project" in Rstudio for classes/workshops/projects/etc. 
# A project is like a big folder that holds all of your scripts and any outputs from your code in one spot. 
# When you create the project, this also sets a "working directory." The working directory is the file path 
# for your project and all of the files associated with it.

# R already comes with a lot of functions that you can start using right away, but sometimes you want
# to use functions that other people created. These come in "packages" that you install and load into Rstudio.
# You'll have to load these packages using the function library() every time you open up Rstudio. More on this later.

## We’re going to create a new project in RStudio:

# 1. Click the “File” menu button, then “New Project”.
# 2. Click “New Directory”.
# 3. Click “Empty Project”.
# 4. Type in “r-intro” as the name of the directory.
# 5. Click the “Create Project” button.

# Every time you open this project our working directory will always be set to the 
# folder `r-intro`! Projects are useful because you won't have to setwd() every time, 
# as long as you are working in the project.


### 2. DATA MANAGEMENT IN R -------

# Now that you have your project set up, you can organize your project directory.

## Project directory organization:

# This is an example of how an R project is organized:
#   - README.Rmd file: this is an R markdown file with information on the project and how your directory is organized
#   - raw_data folder: includes all raw data that you need for your analysis (csv files)
#   - cleaned_data folder: all data that you've cleaned for your analysis
#   - code folder: contains the scripts in which you do the cleaning and analysis
#   - output folder: model outputs, organized by date

## Code folder organization:

# R is a function-based language. You download packages with functions, but you can also create custom functions.
# Programming-heavy projects can produce a lot of custom functions (workshop on December 4).
# You don't want a data cleaning script that's a thousand long because it's hard to read.

# Instead you can set up your code folder with the following scripts:
#   - functions script: basically where you store all of your custom functions
#   - cleaning/analysis scripts: these scripts should really just include 1) loading the data,
#     2) loading the functions script, and 3) running the functions and/or models
#   - RUN_EVERYTHING script: this script calls the other scripts in your code folder,
#     so someone using your code can just run this script and everything can run in one place

## Script organization:

# Finally, when you open a script, you should start by setting the working directory as a RELATIVE path.
# Super necessary for working across multiple computers or sharing code with others.
# I use the following at the top of my code scripts:

library(rstudioapi) # package to retrieve the relative path to the document location
current_path <- getActiveDocumentContext()$path # extracting the current path
setwd(dirname(current_path)) # setting the working directory as the location of the document

# A tidy and reproducible script is one with headers and lots of comments.

#### Header ####
### Header ----
## Sub header
# comment

# Good programming practice is to comment every line!


# Your turn!

# In your new project directory, create the project items listed above (README.Rmd,raw_data,cleaned_data,code,outputs).
# Now create an R script in your code folder and add the three lines of code above to set the working directory.





### 3. R AS A CALCULATOR ---- 

(3 + 5) * 2 # text after each code line is called a "comment"; R ignores anything that follows the # mark

1 < 2  # less than
1 <= 1  # less than or equal to

# Use R to assign objects

# Remember when I said the "Environment" shows all your objects?
# An object is just a term with data and attributes associated with it. 
# You can assign any data to an object.
# Use the arrow (<-) or equal sign (=) to assign something to an object.

x <- 1/40
x
x <- 24 # variables can easily be re-assigned/over-written
y <- x * 2

# Object names can contain letters, numbers, underscores and periods. 
# They CANNOT start with a number OR contain spaces (**at all**). 
# A few different conventions for longer variable names:

# - periods.between.words
# - underscores_between_words
# - CaseToSeparateWords

# Your turn!

# Assign two numbers to two different objects, then add the objects together.
# You can use ChatGPT or another AI tool to check your answer once you've tried it.







### 4. DATA TYPES & DATA STORAGE ----

# When you're working with data, you'll likely have other types of data than just numbers.
# Becoming familiar with the different types of data is important because you can
# do certain operations with some data types but not others.

# Main types: `numeric`, `integer`, `logical`, `character`, and `factor`.

class(3.14) # numeric: any real number
class(1L) # integer: any integer. The L suffix forces the number to be an integer
class(TRUE) # logical: binary TRUE or FALSE 
class("1") # character: words; "" denote words
class(factor("1a")) # factor: denotes categorical variables, they can be words or numbers

# You can coerce to a desired data type, as long as they follow the rules
# using the functions as.<desired data type>()

a <- 45
class(a)
a <- as.integer(a)
class(a) # now 45 is an integer, not numeric


# So far we've only dealt with objects that one thing (1 number, 1 character, etc). 
# If you're analyzing data, you'll store multiple things in 1 and 2 dimensional objects.
# A 1 dimensional object (aka a set of things with a given length) is called a vector.
# A common 2 dimensional object (aka a set of things with rows and columns) is a data frame.

## Vectors

# A vector in R is essentially an ordered set of things, of the same basic 
# data type. Each 'thing' in the vector is called an element. 

# You can make vectors with explicit contents using the combine function `c()`.

vector <- c(2, 74, 23)
vector

# The combine function `c()` will also append an existing vector...

ab <- c("a", "b")
ab
my.letters <- c(ab, "c","d","e","f","g","h","i")
my.letters

# Or we can make a series of numbers...

my.series <- 1:10 # just integers; the colon selects all values between the two numbers
my.series

# To extract elements of a vector we can give their corresponding index
# (square brackets are used for indexing)

my.letters[1]
my.series[c(2:4)] # extracting multiple elements requires the c() function 

# We can also extract elements with comparison operators (e.g. >, <, ==).

my.series[my.series < 5]
my.series[my.series == 7]

# We can use a negative sign with the index of an element that we want to remove.
# R will return every element except for the one specified.

my.letters[-2]

# We can skip multiple elements with the c() like we did when extracting elements.
my.letters[-c(1,5)]

# Your turn!

# Make a vector of 6 numbers using c(), then extract the 3rd element. Bonus: add the 1st and 5th element.
# You can use ChatGPT or another AI tool to check your answer once you've tried it.






## Data frames

# A data frame is a two-dimensional object with rows and columns. The columns are basically vectors
# of all the same data type (e.g. all numeric). The columns must all be the same length (i.e. all have
# the same number of rows). The columns also have names.

# The data isn't in an existing package in R. First, we have to install the package
install.packages("DALEX")
# Now we load the package
library(DALEX)

# The data set we're going to use is called dragons. Let's look at the data:
data(dragons)
head(dragons) # look at the first few rows
dim(dragons) # look at the dimensions of the data frame
colnames(dragons) # look at the names of the columns

# If we look at the data, we can see that each column is a specific data type,
# and we can index it with the operator $.
# All columns in a data frame have to be the same data type.
dragons$height
dragons$year_of_birth[1]

# We could also use brackets to index specific elements of the data frame
dragons[1,2] # [rows, columns]
dragons[1,"height"]
dragons[ ,1:3] # when you leave the rows or columns index empty, it extracts all rows or columns

# We can also check our data types in each column
class(dragons$height)
class(dragons$colour)

# Your turn!

# Check if the 77th dragon lost more teeth than the 78th (i.e. is the 77th element in the number_of_lost_teeth 
# column is greater than the 78th element?).
# You can use ChatGPT or another AI tool to check your answer once you've tried it.







### 5. DATA MANIPULATION ----

# Odds are you're going to need to manipulate your data a bit before you can analyze it. 
# We'll practice manipulating data frames, instead of just looking at them.

# Let's create a new column to hold information on which dragons lost more or less than 10 teeth:
dental.hygiene <- dragons$number_of_lost_teeth < 10
dental.hygiene

# We've simply created a vector with TRUE/FALSE values; but we can add this to our data frame using
# cbind() aka column bind. There's also an rbind(), or row bind, function that works similarly.

dragons <- cbind(dragons, dental.hygiene)
head(dragons)

# Each dragon now has a TRUE/FALSE value about their dental hygiene based on the lost teeth column. 
# But what if we wanted to change this to "good" and "bad" instead of TRUE/FALSE to be more informative?

# You can change certain entries in the column:
dragons$dental.hygiene[dragons$dental.hygiene==TRUE]<- "good"
dragons$dental.hygiene[dragons$dental.hygiene==FALSE]<- "bad"

# Finally, let's create a new column based on existing columns. Let's take the height and weight of each
# dragon and see what the BMI is. 

# First let's assume height is in centimeters and change that to meters.
dragons$height <- dragons$height/100

# BMI is weight/height^2, so let's create a new column with that calculation from the height and weight columns.
dragons$BMI <- dragons$weight/(dragons$height^2)
# Creating a column directly with the object assignment is another way you can create a new column.

# Your turn!

# Create a column where dragons born before year 0 are "ancestor" dragons and dragons born after are "descendant"
# dragons.
# You can use ChatGPT or another AI tool to check your answer once you've tried it.





