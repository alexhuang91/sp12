# Homework 1: Enron email command-line wrangling 

###Your challenge
Given a massive directory of email messages, generate structured csv files that capture the message contents in a structure way suitable for loading into a database, spreadsheet or statistical package.  

###Your tools
For this assignment, you are limited to using Ruby, bash, and the standard Unix utilities.  We strongly encourage you to use Ruby's built-in `CSV` and `find` libraries, and the `mail` gem to deal with email and csv file formats.  (We have installed the mail gem for you on the instructional computers.)  You are not to use any additional Ruby gems!

###Your constraints
You need to be able to handle an input directory that is far larger than the memory of the computer that runs the script.  To do so, you should:

1. write *streaming* Ruby and bash code that only examines one email message at a time, and
2. utilize UNIX utilities like `sort` that provide out-of-core, divide-and-conquer algorithms.  

###Notes

* You should not need to write much code in either Ruby or bash.  Take advantage of UNIX utilities as much as you can.
* There is no need for you to write an out-of-core algorithm to complete this homework.

###Getting started
In these instructions, we assume you are using your CS186 inst account.  (Things should work similarly on any UNIX-style environment, but you'll be on your own -- the CS186 staff will only answer configuration questions pertaining to inst.)

Log into your account, and check out the git repository for the course:

    % git clone XXXXXXXXXXXXX

This will create a directory called sp12 in your home directory, which will contain a subdirectory called hw1. change directory into there and look around:

    % cd sp12/hw1
    % ls
    README.md		mail.csv		test.rb
    hw1.sh*			state_counts.csv	token_counts.csv
    %

In addition to this README file, you will see:

* `hw1.sh`, a skeleton of the bash file you will write
* `test.rb`, a ruby unit test you can use to validate your solution,
* `mail.csv`, `state_counts.csv` and `token_counts.csv`: correctly-formatted example outputs.


###Specification
Your solution should be driven by a `hw1.sh` script that is passed one argument: the root of a directory that contains valid email files:

    % ./hw1.sh ~cs186/sp12/hw1/enron_sample
    
The directory may contain arbitrary files, but the ones that are to be parsed as email must have names ending in ".txt".

The script should overwrite the three csv output files, as follows:

* `mail.csv` should be a legal csv file containing the same header row as the example.  The remainder of the file should contain the specified fields from all the email messages.  See the discussion of "Reading an email" in the [documentation on the `mail` gem](https://github.com/mikel/mail).
* `token_counts.csv` should contain pairs of tokens (strings) and counts (positive integers) taken from the body fields of the emails.  More specifically, the body fields should be processed as follows to form tokens:
    * initial tokens are formed by splitting apart body text non-alphanumeric characters
	* initial tokens are converted to lowercase to form tokens
Then for each token, the count should reflect how often that token appears in *all* the email files under the root of the directory passed into the script.
* `state_counts.csv` is intended to store the rough result of the question "how often is each state mentioned in an email?" It should contain those rows from `token_counts.csv` with the (lowercase) name of a US state in the `token` field.  For states containing two tokens in their name, we will be a bit sloppy, returning the row for only one token as follows:
    * "new hampshire", "new jersey", "new mexico", "new york": return row for the second token
    * "north carolina", "north dakota", "south carolina", "south dakota": return row for the second token
	* "rhode island": return row for the first token
	
###Testing
A simple Ruby unit test is provide in `tc_sanity.rb`.  If you type 

  % ruby tc_sanity.rb

it runs your `doit.sh` script against a subset of about 75 emails taken from [Berkeley's Enron Analysis website](http://bailando.sims.berkeley.edu/enron_email.html) and compares your output to what the solution produced.

Our grading script will compare your code against the approximately [1700 emails](http://bailando.sims.berkeley.edu/enron/enron_with_categories.tar.gz) provided on that website.  To test against that data, you type:

  % ruby tc_grading.rb