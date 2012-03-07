# Homework 4: Similarity joins using q-grams
### CS186, UC Berkeley, Spring 2012
### Points: [5% of your final grade](https://sites.google.com/a/cs.berkeley.edu/cs186-s12/basic-info/grading-info)
### Due: Tuesday, March 13, 2012, 11:59:59 PM (Note: This is a one-week project. Get started early!)
### Note: *This homework is to be done in pairs! Pair-programming is highly recommended!*

###Motivation

For this assignment, you will be implementing similarity joins using `q-grams` 
Similarity joins are useful for when the data is dirty or unreliable. 
For example, say we have two relations A and B and we want to join them on the address field.  We have a record in relation A:

    | Name                           | Address                      |
    | Cheap but Delicious Restaurant | 123 Durant Ave. Berkeley, CA |

and we have a record in relation B:

    | Address                        | Phone          |
    | 123 Durant Avenue Berkeley, CA | (510) 123-4567 |

and we wish to join them on the address field.  We could try using `A.Address = B.Address` but that would never match, and we would never be able to match the two records. 
However, if the addresses were `similar` enough, they could be joined. 
Similarity joins use similarity calculations to determine whether records should be matched. 

###Trigrams

The source code of Postgresql-9.1.2 comes with trigrams. The `pg_trgm` module provides functions and operators for determining the similarity of ASCII alphanumeric text based on trigram matching. A `trigram` is a group of three consecutive characters taken from a string. We can measure the similarity of two strings by counting the number of trigrams they share. This simple idea turns out to be very effective for measuring the similarity of words in many natural languages.

In the existing source code, a string is considered to have two spaces prefixed and one space suffixed when determining the set of trigrams contained in the string. 
For example, the set of trigrams in the string `cat` is <code>"&nbsp;&nbsp;c", " ca", "cat", and "at "</code>

In this assignment, we will be modifying this to extend it to *q-grams*: runs of *q* characters for arbitrary *q*.  (Trigrams are a special case where *q*=3).

##Your task: Extending trigrams to q-grams

Your task is to extend the given trigram code to q-grams using the following rules:

* Remove any padding from the strings
* If the length of the string is less than the given value for `q`, return that string as a q-gram. In this event, there is no need to implement the two new rules we are introducing below
* We will introduce two new rules:
   + The first trigram produced from each term is marked at the right end by the addition of the symbol `!' 
   + The first letter of the term is marked by adding the character `#' to the right

* You may assume that the input will be entirely ASCII characters

The two functions of the `pg_trgm` module that we are primarily interested in are:

<table>
  <tr>
    <th>Function</th>
    <th>Returns</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>similarity(text, text)</tt></td>
    <td><tt>real</tt></td>
    <td>
        Returns a number that indicates how similar the two arguments are. 
        The range of the result is zero (indicating that the two strings are completely dissimilar) to one (indicating that the two strings are identical).
    </td>
  </tr>
  <tr>
    <td><tt>show_trgm(text)</tt></td>
    <td><tt>text[]</tt></td>
    <td>Returns an array of all the trigrams in the given string. (In practice this is seldom useful except for debugging.)</td>
  </tr>
</table>
 
More information about the `pg_trgm` module can be found here: http://www.postgresql.org/docs/9.1/static/pgtrgm.html

***Note:*** Even though you are implementing `q-grams` don't change the names of the functions like `show_trgm` and `generate_trgm`

***Note:*** The primary files that you need to modify are `trgm_op.c` and `trgm.h`



##Examples

####Helpful Applet

We have provided an applet for you to play around with show_trgm and similarity results. It can be found at [http://qgrammify.appspot.com/](http://qgrammify.appspot.com/) 

Some examples of using the `pg_trgm` modules in `psql` are produced below:

####For q=3

```
postgres=# select show_trgm('apple');
{a#,app,app!,ple,ppl}
```

```
postgres=# select show_trgm('I like apples');
{a#,app,app!,i,ike,l#,les,lik,lik!,ple,ppl}
```

```
postgres=# select show_trgm('I like apples'), show_trgm('i lke apple'), similarity('i like apples', 'i lke apple');
                  show_trgm                  |              show_trgm              | similarity 
---------------------------------------------+-------------------------------------+------------
 {a#,app,app!,i,ike,l#,les,lik,lik!,ple,ppl} | {a#,app,app!,i,l#,lke,lke!,ple,ppl} |   0.636364
```

####For q=4

```
postgres=# select show_trgm('i love lollipops');
                       show_trgm                       
-------------------------------------------------------
{i,ipop,l#,lipo,llip,loll,loll!,love,love!,olli,pops}
(1 row)

```

####For q=6

```
postgres=# select show_trgm('I like apples');
{a#,apples,apples!,i,like}
``` 

##Setting q at runtime (as an environment variable)

We will be setting `q` dynamically as an environment variable called `POSTGRES_Q_GRAM`
To set this environment variable to your choice of `q` run the following command before starting the PostgreSQL server:

    $ export POSTGRES_Q_GRAM=q

If PostgreSQL was already running, you'll need to restart it to pick up the new value of that variable:

    $ $HOME/pgsql/bin/pg_ctl restart

To get the C string containing the value of the environment variable use the `getenv` function.
To then extract the value of `q` as an int use `atoi`

So, you could have something like the following in your header file:

```
#define q_str getenv("POSTGRES_Q_GRAM")
#define q ((q_str == NULL || q_str[0] == '\0') ? 3 : atoi(q_str))
````
More information on the `getenv` can be found here: http://www.cplusplus.com/reference/clibrary/cstdlib/getenv/

##Testing

In order to import the test data used for the project, start the PostgreSQL server.
Create a new database `similarity` and import the data with these commands:

    $HOME/pgsql/bin/psql -p <port> postgres -c 'CREATE DATABASE similarity;'
    $HOME/pgsql/bin/psql -p <port> -d similarity -f ~/sp12/hw4/similarity_data.sql

<b>Remember to use the `pg_trgm` module with the `similarity` database, you need to load it as an extension again from the psql prompt.</b>

After starting your PostgreSQL server, type the following:
    
    $ ~/pgsql/bin/psql -p <port> similarity
    similarity=# CREATE EXTENSION pg_trgm;
    
You can check the data using the "psql" command-line client:

    $HOME/pgsql/bin/psql -p <port> similarity
    psql (9.1.2)
    Type "help" for help.

    similarity=# select count(*) from addressphone;
     count 
     -------
     607
    (1 row)

    similarity=# select count(*) from restaurantaddress;
     count 
     -------
     615
    (1 row)

    similarity=# select count(*) from restaurantphone;
     count 
     -------
     617
    (1 row)

If you look through some of the imported data, you will notice that there are several typos in the names, and various formatting and abbreviation differences for the phone numbers and addresses.  This makes it difficult to do equality joins on any of those string fields.

For example, we have a few thousand records in each table, but this query only returns a few hundred rows:

    similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where ra.name = rp.name;
    count 
    -------
    95
    (1 row)

A better way to join on this field would be to use a similarity metric. Using q-gram matching will allow the join condition to match more strings, and produce more results. 

For example, the same query but now using q-gram matching with <b>q=3</b> as follows produces more results.


***Note:*** You should remove all your debugging output before running this query - else it might take a while!!

***Note:*** Remeber to set q=3 before starting your PostgreSQL server using the command `export POSTGRES_Q_GRAM=3`

    similarity=# select count(*) from restaurantaddress ra, restaurantphone rp where similarity(ra.name, rp.name) > 0.7;
    count 
    -------
    500
    (1 row)



Here is the result from a sample query using <b>q=4</b> (Remember to change POSTGRES_Q_GRAM to 4!) to check your implementations. The query

```
similarity=# select ra.name, rp.name, ra.address, rp.phone                                                                                                                        
             from restaurantaddress ra, restaurantphone rp                                                                                                                                
             where similarity(ra.name, rp.name) > 0.8                                                                                                                                    
             order by 4, 3, 2, 1                                                                                                                                          
             limit 5; 
```

gives this output

```
                  name                   |                  name                  |               address                |     phone                                                           
-----------------------------------------+----------------------------------------+--------------------------------------+----------------                                                     
 Ben's Chili Bowl                        | Ben's Chili Bowl                       | 1213 U St. Northwest Washington D.C. | (202) 667-0909                                                      
 Daniel George Restaurant                | Daniel George Restaurant               | 2837 Culver Road Mountain Brook      | (205) 871.3266                                                      
 Bouttega Italian Restaurant             | Bottega Italian Restaurant             | 2242 Highland Ave South Birmingham   | (205) 933-2001                                                      
 Cafe Dupont                             | Cafe Dupont                            | 113 20th St. North Birmingham        | (205)322-1282                                                       
 Azuca Nuevo Latino,. Rextaurant and Bar | Azuca Nuevo Latino, Restaurant and Bar | 713 South Alamo San Antonio          | (210) 225-5550                                                      
(5 rows)   

```


The entire result of the following query for <b>q=5</b> has been provided in the file - [solution_5.txt](https://github.com/anirudhtodi/CS186-Private/blob/master/hw4/solution_5.txt)

    bin/psql similarity -c "SELECT show_trgm(ra.address), show_trgm(ap.address),
                                   similarity (ra.address, ap.address), ra.address, 
                                   ap.address
                            FROM restaurantaddress ra, addressphone ap
                            WHERE similarity(ra.address, ap.address) > .75
                            ORDER BY 1,2,3,4;" > 5.txt

The solution file has also been provided with the skeleton source code. Compare your results with the provided file by using the command `diff 5.txt ~/sp12/hw4/solution_5.txt`

##Need more help?

Check the [FAQ page](https://github.com/cs186/sp12/blob/master/hw4/FAQ.md)

##What to turn in

Repeat the same query that you ran above (for q=5) for q=2,3,4 and 6 storing the results in `2.txt`, `3.txt`, `4.txt` and `6.txt` respectively

Submit the following:

1. trgm_op.c
2. trgm.h
3. 2.txt, 3.txt, 4.txt 6.txt

To submit your assignment, save the submission files listed above in a directory called `hw4` within your cs186 home directory.
and then submit using `submit hw4`

##Getting Started: Building PostgreSQL

For this assignment, you will be modifiying a slightly modified version of the PostgreSQL 9.1.2 source code. 
To follow these instructions you SHOULD use the virtual machine you downloaded for HW3. If you really donot want to use a VM, you can develop on the hive machines using you cs186-xx accounts too. Instructions on how to build on the inst machines have been denoted using an asterix (*)

#####Step 1
To obtain the source code in your `cs186/sp12` repository that you previously cloned for `hw3` run 

    $ git pull

#####Step 2 (If installing Postgres on the hive machines you can skip this step)

To install Postgres, you need to first install `flex` and `bison` since they aren't installed on the VM and are required by Postgresql. To do so run the following two commands:

````
sudo apt-get install bison
sudo apt-get install flex
```

Remember the password you need is `saasbook`

#####Step 3

After checking out the assignment, configure, compile and install PostgreSQL. We will configure PostgreSQL to be installed in the "pgsql" subdirectory of your VM's home directory:

    cd postgresql-9.1.2
    ./configure --prefix=$HOME/pgsql
    make
    make install

***If installing Postgres on the hive machines in the previous step you should have configured Postgres using `--without-readline`. That is instead of `./configure --prefix=$HOME/pgsql` use `./configure --prefix=$HOME/pgsql --without-readline`

##### Step 4

After building and installing Postgres, use the `initdb` command to initialize a local PostgreSQL database cluster.  This only has to be done once.

    $HOME/pgsql/bin/initdb -D $HOME/pgsql/data --locale=C

Next, start PostgreSQL server:
    
    $HOME/pgsql/bin/pg_ctl -D $HOME/pgsql/data -l log.txt start

This will start the server running in the background, logging any log messages such as errors to `log.txt` 

To exit psql, you can use `Ctrl+D` or the special command `\q` 

To shutdown the PostgreSQL server, you can also use the `pg_ctl` command:
    
    $HOME/pgsql/bin/pg_ctl -D $HOME/pgsql/data stop

### *Some inst machine details (Port conflicts)

The server is accessed over TCP/IP using a unique port assigned to your `$PGPORT` environment variable, so it won't conflict with anyone else's server. 
Check the file `log.txt` immediately after launching for any error messages.

If you see an error message like the following:

    LOG: could not bind IPv4 socket: Address already in use
    HINT: Is another postmaster already running on port 5430? If not, wait a few seconds and retry.
    WARNING: could not create listen socket for "localhost"
    FATAL: could not create any TCP/IP sockets

This indicates that another instance of PostgreSQL is running on the same port number. Try running PostgreSQL on a different hive machine, or change the port that your instance of PostgreSQL is running on.

To change the port number of of your Postgres instance, first shut down the instance, and then change the port number in postgresql.conf as follows:

    $HOME/pgsql/bin/pg_ctl -D $HOME/pgsql/data stop
    emacs $HOME/pgsql/data/postgresql.conf

Edit the line with the port number, making sure to remove the comment (#) at the beginning of the line. 
Port numbers between 1025 and 32768 should be usable. 
Then start your instance of PostgreSQL as usual and connect to the database using your specified port number.
For example, if you changed it to 5430, you would use:

    $HOME/pgsql/bin/psql -p 5430 postgres
    
###Installing pg_trgm

As mentioned above, the source code of PostgreSQL-9.1.2 has `trigram` i.e. q-gram similariy for `q=3` implemented in the `pg_trgm` module of the `contrib` directory.
We will be modifying this to extend it to `q-grams`

But, first we want to make and load the `pg_trgm` module as an extension. This is done as follows:

First, cd into the `postgresql-9.1.2/contrib/pg_trgm` directory and make the `pg_trgm` module as follows:
    
    make
    make install

Then start the PostgreSQL server using the `pg_ctl` command:

    $HOME/pgsql/bin/pg_ctl -D $HOME/pgsql/data -l log.txt start
    
Connect to the `psql` prompt using:

    $HOME/pgsql/bin/psql -p <port> postgres

and type:

    CREATE EXTENSION pg_trgm;

This will install the `pg_trgm` module in the `postgres` database.

***NOTE:*** If you create a new database, you must install the extension in that database too!

***NOTE:*** After you have modified PostgreSQL source code, you should recompile and reinstall the modified version of PostgreSQL using the `make` and `make install` commands respectively.
If you only modify the files in the `pg_trgm` module, you only need to run `make` and `make install` in the `pg_trgm` directory. You don't have to `CREATE EXTENSION` again. Neither do you have to recompile and reinstall the PostgreSQL `src` directory.

You can see see the existing trigram implementation in action by running the following query in the `psql` prompt:

    postgres# select show_trgm('cat');
           show_trgm
    ------------------------
     {"  c"," ca","at ",cat}
    (1 row)

***NOTE:*** There is a shell script `do_magic.sh` in the `contrib/pg_trgm` directory. This script recompiles and reinstalls the `pg_trgm` module. It then restarts PostgreSQL and can even run a query (optionally). For example, from the `pg_trgm` directory, you can run:

```
./do_magic.sh "SELECT show_trgm('cat');"
```

For just recompiling and reinstalling the `pg_trgm` module, you can run `./do_magic.sh`

The last line of the `do_magic.sh` script sets the port that it is going to set the PostgreSQL server on.
Please make sure that it is consistent with your chosen port above

##Coding Tips
####Hints

* With the introduction of the new rules, you now have variable sized `q-grams` It might be a good idea to have all the `q-grams` be of the same length and pad the extra space at the end with whitespaces. This will make the pointer arithmetic in your C code much easier

* Since the largest `q-gram` is q+1 characters big, a suggestion is that you have all q-grams be `q+2` characters long with the last character in the `q-gram` representing whether this particular `g-gram` is a "normal" q-gram with q characters, whether it is a "special" q-gram with q+1 characters (i.e. with a '!' at the end of it) or if it is a "special" q-gram with a "#" after the first character

* Note that the `trgm` character array defined statically to have size 3 in `trgm.h` will now have be changed into a pointer (since we don't know the value of `q` at compile time.

####Notes about PostgreSQL

* When allocating memory, use the Postgres routines `palloc` and `pfree` instead of the corresponding C library routines `malloc` and `free`. The memory allocated by palloc will be freed automatically at the end of each transaction, preventing some types of memory leaks. This is because PostgreSQL allocates memory within `memory contexts`. More information can be found here: http://www.postgresql.org/docs/8.3/static/spi-memory.html

* In `trgm.h` you may also be confused by the definition of the `TRGM` struct. This struct is a variable sized datatype. To support this variable-length (varlena) representation, the first 32-bit word of any stored value contains the total length of the value in bytes (including itself). More information can be found here: http://www.postgresql.org/docs/9.0/static/storage-toast.html

####Debugging

#####Using elog()

You can add `elog()` statements at any point to output a message to the log file, using the same syntax as printf():

    elog(LOG, "Two plus three is %d", 2+3);
    
We have also provided you with `print_qgram` and `print_qgram_array` helper functions in `trgm_op.c`. You can use them to see how your q-grams are being stored in memory. Feel free to modify them to provide prettier output!

#####Using gdb

To debug PostgreSQL using `gdb`, first start the server and connect to it using psql. Next, in a separate shell window, you first to determine the PID of the backend process. The simplest way to do this is to locate the `postgres` process with the most recent start time in the output of ps:

```
ps -f -u $USER | egrep /+postgres | sort -r -k 26
cs186-ek  2347  2304   0 23:48:55 ?           0:00 ./bin/postgres -D data
cs186-ek  2309  2304   0 23:42:11 ?           0:00 ./bin/postgres -D data
cs186-ek  2308  2304   0 23:42:11 ?           0:00 ./bin/postgres -D data
cs186-ek  2307  2304   0 23:42:11 ?           0:00 ./bin/postgres -D data
cs186-ek  2306  2304   0 23:42:11 ?           0:00 ./bin/postgres -D data
cs186-ek  2304 11960   0 23:42:11 pts/14      0:00 ./bin/postgres -D data
```

Next, grab the PID of the process, which is the first numeric column in the output of ps. Attach to the backend `postgres` process using gdb:

```
gdb ~/pgsql/bin/postgres 2347
```

Once gdb has attached to the backend process, you might want to set a `breakpoint` inside the code, and then use the `continue` command to resume the execution of the backend process. For example:


```
(gdb) break trgm_op.c:<line number> 
(gdb) continue
```
