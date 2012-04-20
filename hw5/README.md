# Homework 5: Making similarity joins efficient
**NOTE:** There have been 2 major updates to this code, released on [4/19](http://piazza.com/class#spring2012/cs186/1211) and [4/15](http://piazza.com/class#spring2012/cs186/1149). Please make sure you've followed the update instructions linked to for each as applicable.
### CS186, UC Berkeley, Spring 2012
### Points: [15% of your final grade](https://sites.google.com/a/cs.berkeley.edu/cs186-s12/basic-info/grading-info)
### Note: *This homework is to be done in pairs!*
### Due: Thursday, April 26, 2012, 11:59:59 PM (Note: This is a three-week project. Get started early!)

##Motivation

Remember hw4, where you implemented q-grams in postgres? That was fun, right? But when you actually tried to perform a similarity join between two tables, it could take several minutes to run over tables with only a few hundred records!

Why was that? Well, Postgres couldn't use sort-merge or hash join--those only work on equijoins. Instead, it was reduced to using Nested Loops join, which forms the cross product of the two relations and computes similarity for every pair of strings! Even if it could fit both tables in memory, it would still have to compute similarity between N*M pairs of tuples, so it obviously gets unwieldy fast.

In order to make these joins more feasible, you will be implementing a more efficient algorithm for *threshholded similarity join* on trigrams, described below.

## In This Homework
In this homework, you will:

* Cuddle up with the friendly [panda](http://i.imgur.com/mih8b.jpg) that is gdb, and get experience debugging hardcore server software
* Learn to manipulate the decisions made by a query optimizer when you know better than it does
* Experience the rush of modifying a codebase with over 1 million lines of code
* Reverse-engineer the inner workings of a PostgreSQL iterator
* Implement an interesting iterator of your own, and see the improvements you get from HW4

For this homework, we're providing you a lot of tools to find the information you need. Most questions you will have during the homework will likely be directly answerable from the spec, tools described in the spec, or code mentioned in the spec. We are thus putting the onus on you this time to figure out what you'll need.

##Part 1: A Smarter Similarity Join

We're going to implement a smarter similarity join that makes use of an inverted index to avoid computing similarity between all pairs of values.

#### Informal description
Take a look at [this thingy](https://docs.google.com/presentation/d/1i_DO0Nsl1a6wdukd5tEfyW4LROj30ru8Tj5kRq30i4s/edit) to get an informal introduction to our similarity join algorithm.

#### Formal description
When the iterator initializes, we build an inverted index over the trigrams in the join column (i.e., the text column being joined on) of the inner (RHS) table.  The index stores entries of the form *(trigram ; list_of_tuples)*, for each trigram.  As we will see shortly, *list_of_tuples* must be sorted.

To perform the similarity join, we break up the join column of each outer (LHS) tuple into trigrams, and probe the RHS inverted index for each trigram.  If the join column of the outer tuple is broken up into *n* trigrams, then the result of this probe will be *n* postings lists of tuples, one per trigram. 

To complete the join, we merge these *n* postings lists using a process reminiscent of the merging phase in sort-merge join.  The similarity function is then applied to the result of the merge, and only matches with similarity greater than some threshold are accepted.

We formally define the smarter similarity join algorithm below by first introducing the following notation:

Assume that the join column of a given outer tuple is broken up into n trigrams: *t<sub>1</sub>*, ..., *t<sub>n</sub>*.  For each trigram *t<sub>i</sub>*, let *l<sub>ti</sub>* represent the sorted postings list associated with trigram *t<sub>i</sub>* in the inverted index.  Let *p<sub>ti</sub>* represent a pointer into the list *l<sub>ti</sub>*.

#### Steps
1. Consider the join column of a given outer tuple *q*; break it up into trigrams.  Call the trigrams *t<sub>1</sub>*, ..., *t<sub>n</sub>*.
2. For each trigram *t<sub>i</sub>*, probe the inverted index to find *l<sub>ti</sub>*.  Initialize *p<sub>ti</sub>* to point to the first element of *l<sub>ti</sub>*.
3. Find the least tuple currently pointed to by any *p<sub>ti</sub>*.  We will refer to this as tuple *s*.  Instantiate a variable, *m<sub>s</sub>* = 1.  Variable *m<sub>s</sub>* represents the number of matches with *s*.
4. For each *p<sub>ti</sub>* that points to a tuple equal to *s*, increment *m<sub>s</sub>* by 1, and advance *p<sub>ti</sub>* to the next tuple in the sorted postings list *l<sub>ti</sub>*.
5. When no more pointers point to *s*, then the value of *m<sub>s</sub>* is finalized.  Apply the similarity function to *m<sub>s</sub>* to compute sim(*m<sub>s</sub>*)
6. If sim(*m<sub>s</sub>*) exceeds a certain threshold, then emit the concatenated pair *(q ; s)*;
7. Repeat from #3 until all *l<sub>ti</sub>* lists (postings lists) are exhausted.
8. Repeat from #1 until all outer tuples have been exhausted.


##Part 2: Getting Started
###Postgres
First, pull down the hw5 repo using `git pull`. Your postgres database from last time should be sufficient to get started. If you want to recreate it cleanly, you can delete the `~/pgsql/data/` directory and follow the [instructions from hw4](https://github.com/cs186/sp12/tree/master/hw4) under "Building PostgreSQL", doing parts 3, 4, and 'port conflicts'.

Try running the following:

```
$ cd ~/sp12/hw5/postgres-9.1.2/          # Move to the hw5 postgres dir 
$ ./configure --prefix=$HOME/pgsql --enable-debug  # Configure postgres.
$ make -j6                               # Build postgres - this may take some time.
$ make install -C contrib/pg_trgm/       # Build and install pg_trgm.
$ ./rebuild_and_restart.sh               # Rebuild and start postgres.
$ ~/pgsql/bin/psql -p <PORT> similarity  # Let's try out postgres.
similarity=# DROP EXTENSION pg_trgm;    -- This may fail, that's OK.
similarity=# CREATE EXTENSION pg_trgm;  -- Create the actual extension and run a query.
similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where ra.name = rp.name;
```

Don't remember your &lt;PORT&gt; from last time? Try this: `grep "port =" ~/pgsql/data/postgresql.conf`.
<br/>Don't have a "similarity" database? Create it using the [instructions from hw4](https://github.com/cs186/sp12/tree/master/hw4) under the section "Testing".

Check log.txt for errors -- if everything looks OK, you're good to go!

###pg_trgm extension??
Unfortunately, we will not be able to use your pg_trgm code from hw4 (sorry about that!). Instead, we will be returning to the default implementation.

Further, in order to make everything work, we have duplicated the pg\_trgm code. It is located in `src/contrib/pg_trgm/` (like in hw4) to allow the extension to work and also in `src/include/utils/` to allow your internal postgres code to access it.

**NOTE**: Recall that the initial implementation of pg_trgm uses a char[3]. Ultimately, this means that the following code is correct:

```
TRGM* trgms = generate_trgm("abcd", 4);
trgm* trgmArr = GETARR(trgms);
elog(LOG, "First trigram: %.3s", (char*) trgmArr); // prints "  a"
trgmArr ++;
elog(LOG, "Second trigram: %.3s", (char*) trgmArr); // prints " ab"
```

###GDB: This time for real.
#### Background: The Architecture of PostgreSQL
To understand how to debug PostgreSQL, it's useful to understand its process architecture.  Basically, it works like this:

1. When you say `pg_ctl start`, a UNIX process called `postgres` is created to listen for connections on the port specified in your postgresql.conf file.  Let's call that process the "postmaster".  The postmaster, in turn, creates a bunch more utility processes.  You can see all this via the command `ps -ef | grep postgres`:

	```
% ps -ef | grep post
saasbook 11842     1  0 00:27 pts/2    00:00:00 /home/saasbook/pgsql/bin/postgres -D /home/saasbook/pgsql/data
saasbook 11844 11842  0 00:27 ?        00:00:00 postgres: writer process                                      
saasbook 11845 11842  0 00:27 ?        00:00:00 postgres: wal writer process                                  
saasbook 11846 11842  0 00:27 ?        00:00:00 postgres: autovacuum launcher process                         
saasbook 11847 11842  0 00:27 ?        00:00:00 postgres: stats collector process                             
	```

	In the above, process 11842 (`/home/saasbook/pgsql/bin/postgres ...`) is the postmaster, and the others (which have higher process IDs) were spawned from it.

2. When you issue the `psql` command, it connects to the PostgreSQL port that the postmaster listens on.  In response, the postmaster spawns a new `postgres` process on your behalf.  This process is where your actual query is run -- let's call this your "postman".  The postmaster informs your psql command about the identity of its postman. 

3. When you talk SQL to your psql prompt, it forwards your requests to your designated postman, which does the actual work and ships answers back to psql.  From psql, you can find out the process ID of your postman via a special query: `select pg_backend_pid();`.

4. When you quit psql, your postman detects that its psql has left and it in turn shuts itself down (perhaps out of [sheer loneliness](http://i.imgur.com/gvSgz.jpg)).

#### General flow
Last time we just mentioned some basic instructions for getting gdb working, but this time you'll need it to help reverse-engineer the workings of an iterator. So let's go into greater detail:

To debug the query processing logic in postgres, we need to attach gdb to your postman process.  To do that, let's start the psql client and get the postman's process ID (PID):

```
$ ~/pgsql/bin/psql -p <PORT> similarity  # Start a postgres client (we will NOT use do_magic like last time)
similarity=# select pg_backend_pid();    # Get the process id (=<PID>) for the postman.
```

In another terminal window, start gdb and attach it to the process:

```
$ sudo gdb ~/pgsql/bin/postgres          # Start gdb
(gdb) attach <PID>                       # Attach it to the process id returned by pg_backend_pid() above.
```

As soon as you do this, gdb interrupts the postgres process to which you attached, so typing commands into the psql console won't elicit a response. (Try it!)
<br/>To allow the program to resume, type "continue". If at any point you want to interrupt the program again, just press Ctrl+C in the gdb window (this is useful for debugging infinite loops).

#### Example
OK, let's play around a little. Run the following example, one command at a time, and see what it does.

psql:

>```
$ ~/pgsql/bin/psql -p <PORT> similarity  # Start a postgres client (we will NOT use do_magic like last time)
similarity=# SET enable_hashjoin=OFF;    -- See Part 3 for why we have to do this. (Added 4/6.)
similarity=# SET enable_mergejoin=OFF;
similarity=# select pg_backend_pid();    -- Get the process id (=<PID>) for the background postgres server.
```

gdb (another window):

>```
$ sudo gdb ~/pgsql/bin/postgres
(gdb) attach <PID>
(gdb) break nodeNestloop.c:385
(gdb) continue
```

in your psql window:

>```
similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where ra.name = rp.name;
```

back in gdb:

>```
(gdb) backtrace
(gdb) up
(gdb) print node
(gdb) print *node
(gdb) print node->total_cost   # Not found? Make sure you called 'up'!
(gdb) down
(gdb) print nlstate->nl_NeedNewOuter
(gdb) next
(gdb) print nlstate->nl_NeedNewOuter
(gdb) break 391
(gdb) del 2
(gdb) c
```

now look back at the psql window.

finalize gdb:

>```
[Ctrl+C]
(gdb) detach
```

Some things you should note about attaching/detaching the debugger:

* If you try to restart the postmaster via pg_ctl while a debugger is attached, it will hang forever when trying to stop the server. To fix this, just type `detach` in gdb.
* Protip: If you `detach` gdb from the postman process, then when you `attach` it to another process, the breakpoints will stay with you! If you don't want this, you can either delete the breakpoints or restart gdb.

See this page for more commands: <a href="http://users.ece.utexas.edu/~adnan/gdb-refcard.pdf">http://users.ece.utexas.edu/~adnan/gdb-refcard.pdf</a>
<br/>(Note that all commands may be abbreviated, so "continue" can just be "c".)

##Part 3: Postgres details
You should examine each of the following files -- you are responsible for determining what they provide for you.

<table>
<tr><td>Logical code</td><td>File location</td><td>Need to edit?</td></tr>
<tr><td>Nested Loops join algorithm</td><td>src/<b>backend</b>/executor/nodeNestloop.c</td><td>NO</td></tr>
<tr><td>Similarity join algorithm</td><td>src/backend/executor/nodeSimJoin.c</td><td>YES</td></tr>
<tr><td>Similarity join index utilities</td><td>src/backend/executor/simjoinUtil.c</td><td>NO</td></tr>
<tr><td>Similarity join utilities header</td><td>src/<b>include</b>/executor/simjoinUtil.h</td><td>NO</td></tr>
<tr><td>NestLoopState and SimJoinState structs</td><td>src/include/<b>nodes</b>/execnodes.h</td><td>YES</td></tr>
</table>

####Similarity join
In order to implement Similarity Joins, we extended the existing Nested Loops join to invoke your Similarity Join code for similarity comparison operators like `<text> % <text>`. Thus,

`SELECT * FROM a, b WHERE a.name = b.name` invokes Nested Loops join code, and

`SELECT * FROM a, b WHERE a.name % b.name` invokes your Similarity Join code.

####Other join algorithms
When you do a join such as `SELECT * FROM a, b WHERE a.name = b.name`, postgres may choose any of its multitude of join algorithms to answer your query. We want it to choose Nested Loops Join for this project, so that it can delegate to your Similarity Join code as necessary.

First, you should try to determine which join algorithm a particular query is trying to use. You can do this through the SQL `explain` command:

```
postgres=# explain SELECT * FROM a, b WHERE a.name = b.name;
                             QUERY PLAN                             
--------------------------------------------------------------------
 Hash Join  (cost=1.09..2.19 rows=4 width=248)
   Hash Cond: (a.name = b.name)
   ->  Seq Scan on a  (cost=0.00..1.04 rows=4 width=140)
   ->  Hash  (cost=1.04..1.04 rows=4 width=108)
         ->  Seq Scan on b  (cost=0.00..1.04 rows=4 width=108)
(5 rows)
```

Here we see postgres would have chosen hash join. In order to prevent hashjoin and mergejoin from being chosen, we can disable them, like this:

```
postgres=# SET enable_hashjoin=OFF;
postgres=# SET enable_mergejoin=OFF;
```

Rerunning `explain` after setting these two should cause postgres to choose nested loops join, which is what we want. This change is transient, however, and will not persist through postgres being restarted. If you wish to set these or other joins ON or OFF permanently, take a look at `~/pgsql/data/postgresql.conf` under the line "QUERY TUNING".

##Part 4: Understanding Nested Loops Join
In class we discussed nested loops join, which is essentially the simplest join algorithm. We will now examine the actual implementation in Postgres to see what details we left out in class. (Also because you need to in order to implement your own join algorithm.)

Create a couple tables that both have a TEXT column. Insert some data appropriate for doing equijoins or similarity joins.

Now use gdb to examine how nodeNestloop.c executes in order to answer the following questions. (Note that postgres's source code is online. Try searching "doxygen tupletableslot", for instance. This can be convenient for keeping tabs on code.)

In order to see if you're understanding the flow of this code, use to gdb to step through the code in nodeNestloop.c until you are able to answer the following questions:

1. Which function is called first? Which function is called repeatedly? Which function is called last?
2. What does ExecReScanNestLoop do? Namely, what does the "ExecReScan" mean?
	- Don't try getting postgres to call ExecReScanNestLoop. Instead, look for where "ExecReScan" is called within nodeNestloop and try to figure out what it's doing.
 	- **Updated 4/17 to clarify that you should figure out what "ExecReScan" means, not the precise behavior of ExecReScanNestLoop.**
3. What is a TupleTableSlot?
	- Examine the address of the TupleTableSlot over multiple iterations of ExecNestLoop.
 	- Examine the contents of the TupleTableSlot.
4. A HeapTuple is postgres's name for a standard tuple which may or may not be on disk. How is a HeapTuple related to a MinimalTuple? How is it related to a TupleTableSlot?
	- Examine the source code comments for MinimalTuple, HeapTuple, and TupleTableSlot.
5. If we need to copy and move around tuples in a context where memory is constrained, would we use HeapTuples, MinimalTuples, or TupleTableSlots?
	- Hint: Take a look at the simjoinUtil.h code (see Part 3: Postgres details for location).
6. How is memory allocated? How is it freed?
	- Examine the concept of an ExprContext.
7. What determines where our "cursor" is in each table? How do we get the next tuple based on that cursor? When do we do so?
	- Examine the differences between when we get new outer tuples versus new inner tuples.
8. How do we produce output tuples? What does it mean to return NULL?
	- Look at the return statements in ExecNestLoop.

##Part 5: Implementation of Similarity Join

With the questions in Part 4 answered, and equipped with an understanding of the algorithm presented in Part 1, you should be ready to finish the implementation of nodeSimjoin! Have fun!!  The following functions will help you:

###Useful Postgres functions
Here are some functions you may want to make sure you're aware of:

- [ExecCopySlotMinimalTuple](http://doxygen.postgresql.org/execTuples_8c_source.html#l00585) - fetches and copies the MinimalTuple out of a TupleTableSlot
- ReconstructInnerTupleSlot (nodeSimjoin.c) - Places a MinimalTuple inside an (inner) TupleTableSlot.
- GetSimJoinColumn (nodeSimjoin.c) - Returns the column being joined on within a particular tuple.
- cmptup(tup1, tup2) (simjoinUtil.c) - Compares two tuples -- use this to look for equality or to find the 'least' tuple! Returns -1 if tup1<tup2, 0 if they're equal, 1 otherwise. (**Added 4/17**)

##Part 6: Testing

**If you started on this homework before 2AM PDT on 15 April 2012, make sure you follow the instructions in the Piazza post before continuing with this part!!!**

Okay, time to verify that all is in working order.  We're going to compare your implementation with Postgres' default trigram join implementation.  Remember how you tested the last homework by using this command?

```
select count(*) from restaurantaddress ra, restaurantphone rp where similarity(ra.name, rp.name) > 0.7;
```

That command will also work for this homework, but will use Postgres' default similarity join implementation, instead of the super-awesome algorithm you implemented in this homework.  To use your super-awesome algorithm, you'll need to use a different syntax for the SQL statement.  The following command should produce an equivalent result to the above command, except it will use your super-awesome algorithm, which means it will be faster:

```
select count(*) from restaurantaddress ra, restaurantphone rp where ra.name % rp.name;
```

NOTE that you  need to ensure that THRESH is set to .7 (or whatever the query uses).  The following command will set THRESH to .7:

```
similarity=# SELECT set_limit(.7);
```

To see the current value of THRESH, use the following command:

```
similarity=# SELECT show_limit();
```

So the basic idea behind testing your algorithm for correctness is to make sure that Postgres' default similarity join implementation returns the same results as your super-awesome implementation.  For your peace of mind, we recommend you test using the following two commands, for various values of THRESH:

```
similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where similarity(ra.name, rp.name) > show_limit();
similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where ra.name % rp.name;
```

####Larger data
Bored with the small data set?  Try the large data set!!!  Use the following commands to set it up:

```
$HOME/pgsql/bin/psql -p <PORT> postgres -c 'CREATE DATABASE similarity_large;'
$HOME/pgsql/bin/psql -p <PORT> -d similarity_large -f ~/sp12/hw5/similarity_large.sql
```

Connect to your `similarity_large` database like this.  Don't forget to create the pg_trgm extension the first time you connect!

```
$ bin/psql -p <PORT> similarity_large
similarity_large=# CREATE EXTENSION pg_trgm;
```


####Performance analysis
Okay, that was fun, but equivalence is boring.  You wrote this homework to make Postgres fly!  So, let's try comparing the performance of your super-awesome implementation with Postgres' built-in implementation.

We'll be comparing runtime using Postgres' `EXPLAIN ANALYZE` command.  The final line of the output of this command shows the total runtime of the query in miliseconds.  Please put the output of the following `EXPLAIN ANALYZE` commands (in order) into a file called performance.txt, which you will submit as described in Part 7.  Do not include the output of the `SELECT set_limit(...)` commands.

First, run the below commands in the `similarity` database, and then run the commands again in the `similarity_large` database.  In summary, the performance.txt file should contain the output of eight queries: the four below on the `similarity` database, followed by the four below on the `similarity_large` database.

```
similarity=# SELECT set_limit(.3);
similarity=# EXPLAIN ANALYZE select count(*) from restaurantaddress ra, restaurantphone rp where similarity(ra.name,rp.name) > show_limit();
similarity=# EXPLAIN ANALYZE select count(*) from restaurantaddress ra, restaurantphone rp where ra.name % rp.name;
similarity=# SELECT set_limit(.7);
similarity=# EXPLAIN ANALYZE select count(*) from restaurantaddress ra, restaurantphone rp where similarity(ra.name,rp.name) > show_limit();
similarity=# EXPLAIN ANALYZE select count(*) from restaurantaddress ra, restaurantphone rp where ra.name % rp.name;
```

If you implemented the algorithm correctly, your implementation should be faster than Postgres' built-in similarity join. 

##Part 7: Turn-in

Please submit the following:

1. nodeSimjoin.c
2. execnodes.h
3. part4.txt - The answers to the questions from Part 4.  Do not worry about being thorough in your answers -- answering these questions is mostly to help YOUR understanding so you can do the assignment more easily. We just want to make sure you took the time to understand Nested Loops join, but we don't want to read an essay about it.
4. performance.txt - The eight EXPLAIN ANALYZE outputs from Part 6, in order.
5. MY.PARTNERS - Lists the other person you work with, this should be autogenerated when you run the submit command.
6. If you are using slip days please also turn in a README with a single digit indicating the number of slip days you wish to use. For example, if I wanted to use two slip days, my README would consist of only line with the number: `2`

To submit your assignment, save the submission files listed above in a directory called `hw5` within your cs186 home directory, and then submit using `submit hw5`.