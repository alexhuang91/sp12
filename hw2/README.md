# Homework 2: Real-world SQL queries and scalable algorithms
### CS186, UC Berkeley, Spring 2012
### Points: [10% of your final grade](https://sites.google.com/a/cs.berkeley.edu/cs186-s12/basic-info/grading-info)
### Note: *This homework is to be done individually!*
### Due: Friday, February 10, 2012, 11:59 PM

***(NOTE: We issued a breaking change to enron_analyze.rb on 2/2/2012,
   11:20PM. Please issue `git pull` if you checked out the repository
   before then. The structure of query #5 has changed.)***

###Description

In this homework, we will exercise your newly acquired SQL skills.  
You will be writing queries against Postgres
on the inst cluster using public data.  In the first part,
we'll do some warm-up queries and, in the second part, we'll implement
a non-trivial social network analysis algorithm in SQL.

###Tools
For this assignment, you are limited to using Postgres and Ruby.  To follow these instructions **use your CS186 inst account on one of the Linux servers (hive1.cs, hive2.cs, ..., hive28.cs)**. If you do not use one of the hive servers, your tests may not execute correctly.

To obtain the homework files, you can run 

    % git pull

In your `cs186/sp12` repository that you previously cloned for `hw1`.

##Part I: SQL Warmup

To start, we're going to learn how to use Postgres and practice our SQL skills on some basic queries.

###About the schema, Part I

Peruse the schema for Part I, which is provided [here](https://sites.google.com/a/cs.berkeley.edu/cs186-s12/assignments/hw2-part1-schema.sql?attredirects=0&d=1).  You will see it is a bit more complicated than the examples in the book!  Still, it is fairly simple.  There are three main tables of "facts":

The `faads_main` table stores information from the [Federal Assistance Awards Data System](http://www.census.gov/govs/www/faads.html), one row for every award granted.  ***(edit:2/2/2012, fixing dead link)***  [Here's a note on that data](http://ire.org/nicar/database-library/databases/federal-grantsfaads/):

*It contains records of federal assistance awarded to state and local governments as well as all major programs giving transfer payments to individuals, loans, or insurance. More than 1,000 federal assistance programs are covered under FAADS. The data is based upon the fiscal year calendar and collected quarterly by the Census Bureau under mandates of Title 31, Section 6102(a) of the United States Code.*

The `fpds_award_details` and `fpds_contract_vendors` tables store information from the [Federal Procurement Data System](https://www.fpds.gov/).  Each table should have one row per transaction, and the two tables can be joined back together by record_id to assemble details about each transaction. ***(edit:2/2/2012, fixing dead link)*** [Here's a note on that data](http://www.ire.org/nicar/database-library/databases/federal-contracts/):

*The Federal Procurement Data System, maintained by the U.S. General Services Administration through a private contractor, includes transaction-by-transaction records related to federal contracts. ... The database includes services being performed or items being produced in all U.S. states, as well as U.S. territories and some foreign countries. The list of services or products being contracted is long, and includes: telecommunications, maintenance, office furniture, food products, nursing home care contracts, consulting services, military equipment, computer equipment and software, janitorial services, removal and cleanup of hazardous materials, hotel/motel lodging, construction of troop housing, textile fabrics and fuel products.*

The rest of the tables that interest us are "detail" tables (mostly prefixed with the string lookup_).  Essentially, the "fact" tables listed above have foreign keys to rows in these detail tables.

###Using Postgres

If you have not done so already, create space for your postgres tmp directory. Unfortunately, due to `inst` requirements, you have to do this from a machine running Solaris. So, quickly `ssh` to a machine running Solaris (e.g., `nova.cs.berkeley.edu`) and run

    % mkhometmpdir

Then, return to one of the `hive` machines (sorry for the inconvenience!). If this is your first time running postgres, run initdb to create a database in the default location (your $PGDATA directory):

	% echo $PGDATA 
	% initdb

Next launch the database server postmaster:

	% pg_ctl -l log.txt start
	
This will start the server running in the background, logging any log messages such as errors to log.txt.  The server is accessed over TCP/IP using a unique port assigned to your $PGPORT environment variable, so it won't conflict with anyone else's server. Check the file log.txt immediately after launching for any error messages.

***(As of 2/5/2011, we're having some problems with the inst infrastructure. We've described a workaround at http://piazza.com/class#spring2012/cs186/335)***

Now that the server is running, you can create a database, and start up the command-line interface psql to send SQL commands to that database:

	% createdb test
	% psql test

Use the `\d` command to describe your current relations. Use `CREATE TABLE` to create new relations. You can also enter `INSERT`, `UPDATE`, `DELETE`, and `SELECT` commands at the `psql` prompt. Remember that each command must be terminated with a semicolon (`;`).

When you're done, use `\q` to exit `psql`, and stop your postmaster server with:

	% pg_ctl stop
	
If you don't want postgres to print out any `NOTICE: ` statements, execute

	SET client_min_messages = warning;

###Getting started in Part I

If you haven't already, initialize and start up a PostgreSQL server for your use, and test out `psql` on the 'postgres' database to make sure it works:

	% initdb
	% pg_ctl -l pglogfile start
	% psql postgres
	% postgres=# \q

At this point you can load up the sample data:

	% sh ./import-part1.sh

This may take a while ... especially the final ANALYZE step (which gathers statistics for the query optimizer).  When you are done you have a database called USASpending.  You can connect to it with psql and verify that the schema was loaded:

	% psql USASpending
	% USASpending=# \dt

***Edit (1/31/12, more examples):*** Try running a few sample commands in the `psql` console and see what they do:

        % USASpending=# \d faads_main
        % USASpending=# SELECT recipient_name, total_funding_amount FROM faads_main ORDER BY recipient_name;
        % USASpending=# SELECT obligatedamount, agency_desc FROM lookup_agency_code, fpds_award_details WHERE lookup_agency_code.agency = fpds_award_details.idvagencyid;

###Write these queries

We've provided a `hw2_warmup.sql` file to help you get started. In the file, you'll find a `CREATE VIEW` statement for each question below, specifying a particular view name (like q2) and list of column names (like `recip_id`, `recipient_name`). The view name and column names constitute the interface against which we will grade this assignment. In order words, don't change or remove these names. Your job is to fill out the view definitions in a way that populates the views with the right tuples.

For example, consider a hypothetical Question 0: "What is the minimum number of widgets at any factory?".

In the warmup file we provide:

	CREATE VIEW q0(min) AS
	;
	
You would edit this with your answer, keeping the schema the same:

	-- solution you provide
	CREATE VIEW q0(min) AS
	 SELECT MIN(widget)
	 FROM factory
	;
	
Create views in the following queries:

q1. In the `fpds_award_details` table, find all the entries with a value for
  the `obligatedamount` attribute that is greater than $100,000, and return the
  `contractorname` and obligated amount.
  
q2. Which Universities are receiving money? In the
 `fpds_award_details` table, find the `contractorname` and `obligatedamount`
  for all contractors whose name contains the
  substring "UNIV". ***(edit 2/1/2012: got rid of requirement to sort results)***

q3. Find the number of contracts (rows) in the `fpds_contract_vendors` table
   for vendors that are veteran-owned businesses.
  
q4. From which major agencies has 'SCHOOL OF COMPUTERS INC' *not* gotten aid?
   Return distinct `majagency_tr` and `current_agency_head` fields.
 (Warning: This question is much more complicated than the previous ones.
  Examine some of the tables to see how to pull the data together.)

q5. Which recipients of federal awards (in `faads_main`) have gotten
aid from more than 10% of the major federal agencies?  Return the
recipient id (`recip_id`) and name (`recipient_name`) and the number
of major agencies (`maj_agency_cat`) that that they got aid from.  For
this question, assume we can distinguish recipients by the pair of
columns (`recip_id`, `recipient_name`) ***(edit 2/1/2012: fixing
column name)***.  (Hint: you might find it easier to first try
counting up the number of distinct agencies that each recipient has
gotten aid from, and after that figure out how to threshhold the
result at 10%. Do not hard code the 10% threshold.)
    
##Help?

To assist in your assignment, we've provided output from each of the views you need to define for the data set you've been given.  Your views should match ours, but note that your SQL queries should work on ANY data set. Indeed, we will be testing your queries on a (set of) different database(s), so it is *NOT* sufficient to simply return these results in all cases!

To run the test:

	% test/p1-test-sql-views.sh 
	
(Make sure you're invoking the script either directly or with `bash`; running it with `sh` may give you false passes!)

You may want to become familiar with the UNIX [diff](http://en.wikipedia.org/wiki/Diff) command, if you're not already, because our tests print the `diff` for any query executions that don't match.  If you care to look at the query outputs directly, ours are located at `/home/ff/cs186/sp12/hw2/part1/out/p1.q{1-5}.txt`. ***(edit 2/1/2012: fixed path)*** Your view output should be located in your solution's `test-output` directory once you run the tests.

**Note:** It doesn't matter how you sort your results; we will reorder them before comparing. Note, however, that our test query output is sorted, so if you're trying to compare yours and ours manually line-by-line, make sure you use the proper ORDER BY clause. The order should be apparent from looking at our test query output. ***(edit 2/1/2012: added this note)***
	
#Part II: Betweenness Centrality

Now that we're all warmed up with our SQL skills, we're going to put them to use in an interesting algorithmic analysis.

Read the entry for [betweenness
centrality](http://en.wikipedia.org/wiki/Betweenness_centrality) on
Wikipedia. Betweenness centrality is a measure of a node's centrality
in a network.  It is defined with respect to the number of shortest paths from all vertices
to all others that pass through that node.  Betweenness centrality is
a useful measure of a node's relative importance in the graph in terms
of traffic and connectivity. For example, in this
[figure](http://mande.co.uk/blog/wp-content/uploads/2008/06/kite2.gif),
node eight has the highest betweenness centrality.

In this (final) part of the assignment, we are going to calculate
betweenness centrality in SQL on the Enron dataset from HW1.  Betweenness
centrality in this example captures a notion of which members of the
Enron dataset were most important in the communication network.

##What we've done

We've written a mostly completed implementation of betweenness
centrality in Ruby and SQL. The betweenness centrality calculation
requires two steps:

* All-pairs/all-shortest-paths: Find all of the shortest paths between
  any two vertices in the graph.
* Summation of node importance: This is `g(v)` on Wikipedia.

We've already parsed the Enron sender-receiver data set for you and
defined the intermediate tables, views, and program flow you'll need
to complete both of these steps. Take a first read through
`enron_analyze.rb` to understand the control flow.

If you look at pseudocode for a shortest-paths algorithm
like [Djikstra's
algorithm](http://en.wikipedia.org/wiki/Dijkstra's_algorithm#Pseudocode),
you'll see that it's written in an imperative,
[von-Neumann](http://en.wikipedia.org/wiki/Von_Neumann_architecture)
style, processing a single vertex at a time.  The computation proceeds step by step, 
sequentially iterating over a loop
with many individual loads and stores to different memory locations.

By contrast, your SQL implementation of all-pairs/all-shortest-paths will use a 
[declarative](http://en.wikipedia.org/wiki/Declarative_programming), "batch" algorithm designed for efficient execution within a database.  This algorithm takes a [dynamic programming](http://en.wikipedia.org/wiki/Dynamic_programming) approach to the problem:
it iteratively finds paths of increasing length (in terms of hop count, or number of links in the path).

Note that our graphs are directed: if `a` sent a message to `b`, there is an edge between them. The edge weight between `a` and `b` is `1/(the number of messages betwen a and b)`, reflecting the fact that people emailing more represents a 'smaller' communication cost. This means that path cost is not the same as hop count! 

The pseudocode for our algorithm, annotated by (relationname) in our code, is as follows ***(edit 2/7/2012: clarifying pseudocode)***:

	(paths) = set of shortest paths we've seen so far
	(paths_to_update) = set of paths we added at step i
	(new_paths) = set of paths that are on the frontier of our exploration
			      and are of length i+1 hops
  
	//begin initialization
	
	// to start, we need to check all links
	insert all links of length 1 hop into (paths_to_update)
	
	//end initialization
	
	//this variable i is unnecessary, but illustrates the fact that we're
	//building paths of length i+1 hops out of paths of length i hops!
	i = 1
	while there are paths of length i (paths_to_update):
	   //find all paths of length i+1 (stored in extended_paths)
	   join paths of length i (paths_to_update) with 1-hop paths (from enron) to form paths of length i+1
	   
	   //find paths of length i+1 hops that are "better" than our current paths
	   //note: we store the intermediate result of the join between
	   //     (extended_paths) and (paths) in (compare_paths)
	   add to (new_paths):
		  --paths with sender/receiver pairs that we have not yet seen
		  --paths that are shorter than the paths in (paths) that have the same sender/receiver pairs
	   
	   //now store the "better" paths of length i hops in (paths)
	   remove all paths from (paths) where
               path is in (paths_to_update) and the path in (paths_to_update)
               is strictly cheaper than the path in (paths)
	   add all paths from (paths_to_update) to (paths)
	   
	   // when we go to the next iteration, need to swap the sets
	   (paths_to_update) = (new_paths)
	   (new_paths) = empty set
  
	   i++

 ***(edit 2/2/2012: removed unnecessary insertion of 1-hop paths into
    (paths) to start; exercise to reader: why are they unnecessary?
    why didn't this affect correctness?)***
		 
After computing these paths, we use them to compute betweenness centrality.

##Your task

Our implementation is almost done but we need your help to fill in
some of the holes!  We've specifically left holes (marked by `TO COMPLETE` and `???`) in our
Ruby implementation, `enron_analyze.rb` (operating on the `enron_stats` database) for you to fill in.
You may find alternate ways to implement these queries, and we
encourage you to experiment. However, you shouldn't need to do so,
and, if you do change the query structure, *make sure that your output
matches ours*.

Do *not* change the code within the `DO NOT EDIT` delimiters (see the *Help* section below). Unless you are 100% sure that your changes will correctly compute betweenness centrality, do not change the control flow of the program; simply fill in the blanks as necessary.

In summary, you need to fill in the queries to:

1. For shortest-paths: join all paths of length i that have been extended by one hop (given in `extended_paths`) with all paths in `paths` that have the same `s`, `t`; if none exist, return a `NULL` cost value; call this `compare_paths`

2. For shortest-paths: insert all paths in `compare_paths` that are shorter than those in `paths` or where there wasn't a path with the same `s`, `t` in `paths` into the `new_paths` relation.

3. For shortest-paths: delete the paths in `paths` that are not minimal with respect to `paths_to_update`. If we found a shorter path (stored in `paths_to_update`), delete the longer paths found in `paths.

4. For betweenness centrality: find delta_st(v) for all s,t,v pairs by calculating how many paths passed through each possible v.

5. For betweenness centrality: determine how many paths there were for each s,t, pair and calculate the non-normalized betweenness centrality using the view you computed in query #3.

6. For betweenness centrality: normalize the centrality metrics so all values are between 0 and 1.

To run your program:

	% ruby enron_analyze.rb FILE
   
Where `FILE` is one of the following files (listed in order of increasing size) ***(edit: 2/2/2012, path typo)***:

* `/home/ff/cs186/sp12/hw2/part2/test-micro.csv`: a simple synthetic graph ([see a diagram](https://github.com/cs186/sp12/raw/master/hw2/diagram/test-micro-diagram.png))
* `/home/ff/cs186/sp12/hw2/part2/test-sm.csv`: a little larger synthetic graph ([see a diagram](https://github.com/cs186/sp12/raw/master/hw2/diagram/test-sm-diagram.png))
* `/home/ff/cs186/sp12/hw2/part2/test-multpath.csv`: a more complex synthetic graph with many shortest paths ([see a diagram](https://github.com/cs186/sp12/raw/master/hw2/diagram/test-multpath-diagram.png))
* `/home/ff/cs186/sp12/hw2/part2/enron-med.csv`: a subset of the enron database
* `/home/ff/cs186/sp12/hw2/part2/enron-lg.csv`: the entire enron data set (this is really big, so only run this for fun!)
 
 You can then examine the results, which will be stored in the `betweenness_centrality` table.

##Help?

There are many intermediate steps to this computation, so we've provided a harness that lets you examine the contents of your views as you iterate over the shortest paths graph.  To exit your program after iteration `i`, run 

	% ruby enron_analyze.rb FILE i
   
Keep in mind that you shouldn't edit the code blocks responsible for this (denoted `DO NOT EDIT`) or the main control flow.  We will be using this functionality for *grading*, so, if this functionality breaks, you will receive *ZERO* credit for this portion of the assignment.

**We've provided test scripts for the micro, sm, and multpath datasets!**

	% test/p2-test-bc-micro.sh
	% test/p2-test-bc-sm.sh
	% test/p2-test-bc-multpath.sh

***(edit: 2/2/2012 11:20PM; added multpath test case)***
	
(Make sure you're invoking the script either directly or with `bash`; running it with `sh` may give you false passes!)

Again, we'll print any differences between your query results and our query results.  Our query results are located in `/home/ff/cs186/sp12/hw2/part2/out/`, and your query results should be located in your solution's `test-output` directory. `test-micro` should break after 2 iterations through the loop, and `test-sm` should break after three.

***Make sure to run your script on at least enron-med.csv. Passing
   tests is good and well, but there's no replacement for playing
   with REAL data!***

##What to turn in

All of your code should be contained in two files:
`hw2_warmup.sql` and `enron_analyze.rb`

`cd` into your solution's directory and run the `submit hw2` command.  It will automatically collect the relevant files. You don't need to submit any other files, and, if you do, they will be ignored.
