# Homework 3: Schema Design and Web Application Server Code in Ruby On Rails
### CS186, UC Berkeley, Spring 2012
### Points: [10% of your final grade](https://sites.google.com/a/cs.berkeley.edu/cs186-s12/basic-info/grading-info)
### Note: *This homework is to be done in pairs!*
### Due: Thursday, March 1 11:59:59 PM

###Description

In the rehaul of the calmail system UC Berkeley CIO Shel Waggener has hired you to write a calendar application for the campus to use! The calendar allows for multiple users to create as many private calendars as they'd like, each containing several events that you can invite other users to as well! Shel contracted out some of the frontend work to your very own GSI Caroline Modic and has provided you with the following description: 
  
  * The ability to signup / login / logout users
    + Users must have a unique username
    + Users must have a username
    + Users may optionally have a password
  * Each user can create and view multiple calendars
    + Within the scope of a single user, calendar names are unique
    + Calendars must have a name, and can optionally have a description
  * Calendar can holds multiple events
    + Events must have a name, start and end time
  * Events can have multiple users attending them
    + You can invite users to an event when you create it
    + Invites can optionally have a message attached (same for all invited users)
    + If accepted the invitee assigns the event to a calendar in their account
    + Invites can be rejected by an invitee
    + Users can not be sent a second invite if one is already pending for that event
    + You can not invite yourself to an event
    + Only the event owner can send invites
  * Events and Calendars can be deleted
    + Calendars must contain 0 events to be deleted
    + When an event owner deletes an event it is deleted from everyone attending it, otherwise it is only deleted for the invitee. 
  * Events and Calendars can be edited
    + Only the event owner can edit the event
    + When editing an event you can change the calendar the event belongs to (for simplicity only the event owner can do this as well) 

You can see a working version of the application at http://bearplanner.heroku.com

###Tools
For this assignment you will be developing with postgres/sqlite and ruby on rails on a virtual machine. You must download virtualbox and the vm by following the instructions at : http://alpha.saasbook.info/bookware-vm-instructions . You will need to unzip the vm*.zip file. If you are using a Mac you may have trouble unzipping this with the built in archive utility, I suggest installing The Unarchiver to do the job: http://wakaba.c3.cx/s/apps/unarchiver . 

Note: DO NOT install the updates when you run the VM. 

Optionally you may choose not to download the VM in which case you can use the inst machines. Note: The inst machines can NOT run rails locally. If you choose to use the inst machines you can ONLY deploy your application via heroku, following the steps explained throughout this readme. 

To obtain the homework files, you can run 

    % git pull

In your `cs186/sp12` repository that you previously cloned for `hw1`. The app can be found under 'hw3/bearplanner'. If you are on a VM you can obtain the git directory by running:

    % git clone git://github.com/cs186/sp12.git


#### Running the app locally

To run the app locally you can launch: (this only works on vm's) 

    % rails server
    
Then browse to localhost:3000 in the VM's browser to see your app!
Note if you see an error first run:

    % bundle install
    
Then continue with launching the server. 

#### Running the app on Heroku

To submit the code you will need to launch a heroku application with your app, you may also do this to debug. You will need to go to http://heroku.com and signup with a new account then follow these steps:
    
    % heroku login

If you are running on an inst machine you must do the following steps (on a vm you can ignore this):

    % ssh-keygen -t rsa
    % heroku add:keys

Enter your login info when prompted (that you used to sign up at heroku.com) and respond 'yes' when it asks to create a public key. 

    % git init
    % git add .
    % git commit -m "init"
    % heroku create --stack cedar
    % git push heroku master

After that your heroku site should be up and running! It will tell you the url you can go to, or you can use the following line to open up the site in the browser:
 
    % heroku open
If you want to push your new changes to heroku you simply need to type the following at the command line:

    % git add .
    % git commit -m "some message"
    % git push heroku master
    
Locally, your changes with automatically appear as long as you rails server command is still running. 

Note: If you would like to collaborate with your partner on the same heroku app, this is very straightforward. Simply have one of you partners follow the steps above then do:

    % heroku sharing:add otherPartner@whatever.com
    
The the otherPartner (after performing heroku login) can execute:

    % git clone -o heroku git@heroku.com:theirapp.git
    
theirapp is the name of the app you creating this will be the name that is something like "flying-dove-1234" or "shivering-pine-5678" something (in my working solution just "bearplanner")
    
And you will both have access to the app/git repo!! If you would like more info check out: http://devcenter.heroku.com/articles/sharing 

##Part I: Schema Design

To begin, we will design the database schema for the app and create the appropriate Rails models. 

###ActiveRecord Intro: Migrations
	
Rails uses a library called ActiveRecord for database access.  In Rails, we create tables in our database using "migrations".  For our purposes, a migration is just a fancy "CREATE TABLE ..." statement in Ruby code.

See here for everything you ever wanted to know about migrations: http://guides.rubyonrails.org/migrations.html.  I'll try to give a brief summary below:

To create a new "Model" (a Ruby object that encapsulates a database table), as well as the underlying database table, you would use these commands:

    % cd hw3/bearplanner/
    % rails generate model Something
    
NOTE: If you are working on an inst machine any command beginning with "rails" WILL NOT WORK. You must instead manually create the file, you can model the file off of the users.rb in the framework code and the db/migrate/*_create_users.rb file. 

This will create a bunch of stuff for your new model ("Something").  The important files for our purposes are:

    % ~/hw3/bearplanner/app/models/something.rb
    % ~/hw3/bearplanner/db/migrate/[some_unique_id]_create_somethings.rb

You would put the table columns (including columns for foreign keys) in the _create_somethings.rb file (see ~/hw4/rubysketch/db/migrate/.

As an example, we have given you a migration for the "User" model (users table).  When you ran the "rake db:migrate" command above, Rails created the corresponding "users" table in Postgres.  You can find the migration in:

    % ~/hw3/bearplanner/db/migrate/20120205182312_create_users.rb

This migration creates a table called "Users" with columns:
 
  * a string field called "name"
  * a string field called "password"
  * an implicit field called "id", which is a primary key (a unique integer representing each tuple)
  * "created_at" and "updated_at", two timestamps that are included because of the line: "t.timestamps"

You can enforce integrity constraints in the database itself by adding them to the migration or enforce them in the model (see: /app/models/Users.rb). In this example we do the latter. 

### ActiveRecord Intro: Relationships
  You can optionally specify any relationships with other models (i.e., using has_one, has_many, belongs_to, and has_and_belongs_to_many) in the app/models/[modelname].rb file.

  For the "User" model, the corresponding "~/hw3/bearplanner/models/user.rb" is quite boring, because there are no relationships to define (we've only given you one model!).

  It is not required to specify relationships -- you can successfully complete the assignment by not editing any files in the "models/" directory.  However, specifying relationships makes writing code to access your database a bit simpler, as we highlight in the example below:

#### Relationships Example

Assume that we've created another model called OtherThing, and we have the following column in our "~/hw4/rubysketch/db/migrate/[some_unique_id]_create_somethings.rb" migration:

    % t.integer :other_thing_id

We will highlight the value of specifying relationships by showing code with and without them:

With relationships:

Assume that you have the following in your app/models/something.rb file:

    % class Something < ActiveRecord::Base
      % has_one :other_thing
    % end

    Now, here's some code you might write:

    //intuitively, these statements together represent the query "SELECT O.name from other_things O, somethings S WHERE S.id = 2 AND O.id = S.other_thing_id;"
    thing = Something.find_by_id(2)
    name = thing.other_thing.name

    Without relationships:

    Here's the same code, but without relationships:

    thing = Something.find_by_id(2)
    name = OtherThing.find_by_id(thing.other_thing_id).name

    Notice how we had to explicitly refer to the column name "other_thing_id", and look up the corresponding OtherThing record using find_by_id.  Putting "has_one :other_thing" in your model automatically lets you say ".other_thing", instead of having to refer to the column name explicitly.

### Your Assignment
You will be using Rails "migrations" to create the database. You may create whatever tables/models you wish but you may not edit the users migrations. You can however edit the users model if you wish to add relationships (although you do not need to). In order to update the database with these migrations you must run 
    
    % rake db:migrate

Or if you are on heroku
   
    % heroku run rake db:migrate

You can look in the database locally to see if everything is correct by running
  
    % sqlite3 db/development.sqlite3

Your job is too create both the models and the database migrations neccessary to model the data in this step. Look at the example for users if you aren't sure how to get started. If you are ever stuck and just want to reset the state of your database (drop all tables then rerun all migrations) try:

    % rake db:reset
    
Or on heroku:

    % heroku run rake db:reset

##Part II: Backend Server Code

###Intro
Since you created your own models you will need to plug them  into our views through the controller methods. If you find yourself wishing you added another column to a database in step 1 you can do so easily check out the following link for details: http://guides.rubyonrails.org/migrations.html#creating-a-standalone-migration. We have implemented login() signup() and logout() for you in /hw3/bearplanner/app/controller/bear_planner_controller.rb. You must implement the rest!

#### Important Notes:
  * If a user is logged in session[:uid] will contain their user id, otherwise it will be null.
  * All other input will be given to you in the "params" hash. 
  * You will give output by assigning it to the @VARIABLE variables we instruct you to. 
  * The views rely on these variables having SPECIFIC names so please make sure you are accurate. 
  * Check out the before_filter lines at the top of the application "login_required" is definited for you in application_controller.rb, but you will need to implement the others. 
    * These are all methods that a run before the bear_planner_controller methods, in order to verfiy that a user is logged in and accessing an event/calendar/invite that they own before proceeding with the controller method.
  * When the user has the option to submit a form, request.post? will return true if the user has submitted the form and false otherwise (see login() and signup()). 

#### show_calendars
  * Purpose: To show a list of calendars for a user. 
  * Input: None
  * Output: 
    *An array of hashes named "@calendarArray". Each hash has the following fields:
      * 'id' - A identifier of the calendar
      * 'name' - A string with the name of the calendar
      * 'description' - A string with the description of the calendar

#### show_calendar
  * Purpose: To show all the events/information of a specific calendar. 
  * Input: 
    *params[:cal_id] - Contains a identifier of the calendar (whatever you gave in the 'id' field in show_calendars
  * Output:
    * @calName - The name of the calendar
    * @calDescription - The description of the calendar
    * @eventArray - And array of hashes with event information with the following fields:
      * 'id' - an indentifier of the event
      * 'name' - a name of the event
      * 'starts_at' - a DateTime object with the time the event starts
      * 'ends_at' - a DateTime object with the time the event ends

#### edit_event
  * Purpose: To give the current information about an event and let a user edit it. (see signup and login for user input examples)
    * If the edit is submitted and all goes well redirect to "show_calendar" with params[:cal_id] set. 
    * Otherwise redirect to "edit_event" with params[:notice] set to the string "An error has occurred." with params[:event_id] and params[:cal_id] set.  And do not change the event. 
    * If an invitee username is invalid (nonexistent, already invited, or the current user), change the event and invite the valid users and redirect to "show_calendar" but in addition to setting params[:cal_id] also set params[:notice] to the string "The following invited usernames are invalid/duplicates and invites were not sent:" followed by the invalid usernames (with a space between each one) 
    * if you are not the owner of the event redirect to edit_event with the params[:notice] "You can not edit this event, contact owner: " followed by the owner of the event's name. Also set params[:cal_id] and params[:event_id] appropriately. 
  * Input:
    * params[:event_id] - An identifier of the event
    * params[:cal_id] - An identifier of the calendar to which the event belongs
    * After the form is submitted:
      * params[:eventName] - The new event name
      * params[:starts_at] - New start time
      * params[:ends_at] - New end time
      * params[:old_cal_id] - Identifier for calendar event previously belonged to
      * params[:cal_id] - Identifier for new calendar
      * params[:invitees] - String of comma-seperated list of usernames for invitees
      * params[:inviteMessage] - Message for the invite
  * Output(all set before checking for request.post):
    * @calendars - A hash where the key is the calendars name and the value is its indentifier for all calendars the user owns. 
    * @eventName - Name of the event
    * @eventId - Identifier of the event
    * @eventStarts - DateTime with start of event
    * @eventEnds - DateTime with end of event
    * @eventOwner - Identifier of the owner of the event
    * @invitees - Array of hashes of the current people who have accepted invites (this is only set if you are the event owner) 
      * 'name' - Invitee's name

#### create_calendar
  * Purpose: Allows user to create a calendar, info sent when request.post? is true
    * If creation occurs properly redirect to "show_calendar" with params[:cal_id] set.
    * If creation fails redirect to "create_calendar" with params[:notice] set as "An error has occurred."
  * Input:
    * After form is submitted
      * params[:calName] - new calendar name
      * params[:calDescription] - new calendar description
  * Output: None

#### edit_calendar
  * Purpose: Allows user to edit a calendar
    * after form is submitted if correct redirect to "show_calendar" with params[:cal_id] set
    * after form submitted if there is an error redirect to "edit_calendar" with params[:cal_id] set and params[:notice] set as "An error has occurred."
  * Input 
    * params[:cal_id] - An identifier of the calendar
    * If request.post?
      * params[:calName] - new name of the calendar
      * params[:calDescription] - new description of the calendar
  * Output - set these whether or not request.post is set
    * @calName - original name of the calendar
    * @calDescription - original description of the calendar

#### delete_calendar
  * Purpose: To delete a calendar
    * If the calendar has no events, delete it and redirect to  "show_calendars"
    * If it has events redirect to "show_calendar" with params[:notice] set to "You can not delete a calendar that contains any events." and params[:cal_id] set.
  * Input: 
    * params[:cal_id] - An identifier of the calendar
  * Output: None

#### create_event 
  * Purpose: To create an event
    * If the form is submitted and all goes well redirect to "show_calendar" with params[:cal_id] set. 
    * Otherwise redirect to "create_event" with params[:notice] set to the string "An error has occurred." and params[:cal_id] set. And do not create the event. 
    * If an invitee username is invalid (nonexistent, already invited, or the current user), create the event and invite the valid users and redirect to "show_calendar" but in addition to setting params[:cal_id] also set params[:notice] to the string "The following invited usernames are invalid/duplicates and invites were not sent:" followed by the invalid usernames (with a space between each one) 
  * Input:
    * params[:cal_id] the calendar we were in when we clicked "create event" 
    * After the form is submitted:
      * params[:eventName] - The new event name
      * params[:starts_at] - New start time
      * params[:ends_at] - New end time
      * params[:cal_id] - Identifier for the calendar chosen for the event to belong to
      * params[:invitees] - String of comma-seperated list of usernames for invitees
      * params[:inviteMessage] - Message for the invite

  * Output:(all set before checking for request.post):
    * @calendars - A hash where the key is the calendars name and the value is its identifier for all calendars the user owns.

#### delete_event
  * Purpose: Delete an event
    * If you are the events owner you delete the event completely and no one can see it
    * If you are not the events owner you delete the event from your own account but others can still see it
    * After delete redirect to "show_calendar" with params[:cal_id] set to the calendar the event belonged to
  * Input: 
    * params[:cal_id] - identifier of calendar the event belongs to
    * params[:event_id] - identifier of the event
  * Output: none

#### show_invites
  * Purpose: Show all the pending (neither accepted or declined) invites for a user
  * Input: None
  * Output: 
    * @allInvites - An array of hashes of invites where each hash has the values:
      * 'inviteId' - Identifier of the invite
      * 'eventName' - Name of the event invited to 

#### show_invite
  * Purpose: Show an invite, allow user to assign to calendar and accept/decline
    * If user accepted or declined successfully redirect to "show_invites"
    * If form is submitted and an error occurred redirect to "show_invite" with params[:invite_id] set and params[:notice] set to "An error has occurred."
  * Input:
    * params[:invite_id] - Identifier of invite
    * If form is submitted
      * params[:cal_id] - Selected calendar to assign event to 
      * params[:commit] - Either "Accept" or "Reject" 
  * Output: 
    * @inviteMessage - message for invite
    * @inviteId - identifier of invite
    * @eventName - Name of event
    * @eventStarts - DateTime of start of event
    * @eventEnds - DateTime of end  of event
    * @eventUserName - name of the owner of the event
    * @calendars - A hash where the key is the calendars name and the value is its identifier for all calendars the user owns.

### before_filter methods
These are in place to ensure you can't access the information of another user, we have already designated which methods these filters apply to you just need to fill them in in application_controller.rb

#### invite_id_matches_user
  * Purpose : Make sure the invite is the current users
     * If it is return true
     * If it doesn't redirect to "show_invites" set params[:notice] to "You can not access that invite." and return false.
  * Input
     * params[:invite_id] - Identifier of the invite
  * Output: None

#### cal_id_matches_user
  * Purpose : Make sure the calendar is the current users
     * If it is return true
     * If it doesn't redirect to "show_calendars" set params[:notice] to "You can not access that item." and return false.
  * Input
     * params[:cal_id] - Identifier of the calendar
  * Output: None

### Testing 
You can test out any ruby code by going into "bearplanner/" folder, and typing "rails console".  This will provide you with an interactive Rails shell, where you can run any ActiveRecord queries using the tables and models you have defined.   To learn about what you can do in the rails console check out this link : http://railsonedge.blogspot.com/2008/05/intro-to-rails-console.html . Additionally, if you want to directly call any methods you have defined in ~/hw4/bearplanner/app/controllers/bear_planner_controller.rb, you must first type the line: "include Helpers".

### More Background?
Check out https://sites.google.com/a/cs.berkeley.edu/cs186-sp10/assignments/hw4-rails and scroll down to "Background on Ruby on Rails to learn more if you are still confused, or check out the links in our resources. 
 
#### Heroku
 The following commands may be useful
    
    % heroku logs
 
 Shows the recent logs of your app on heoku
    
    % heroku console 
 
 Runs the interactive rails console (i.e. 'rails console' locally) on your heroku app. 
 If you notice any difference between your app locally and on heroku notify the staff immediately. 

##What to turn in
  * hw3.tar - A .tar file of your bearplanner/ directory
  * website.txt - A text file containing ONLY your heroku website url. DO NOT make changes to the website on heroku after the submission deadline, if we notice you have done so we reserve the right to give you a 0 on the assignment. 
  * MY.PARTNERS - Lists the other person you work with, this should be autogenerated when you run the submit command. 

`cd` into your solution's directory and run the `submit hw3` command.  It will automatically collect the relevant files. You don't need to submit any other files, and, if you do, they will be ignored.
