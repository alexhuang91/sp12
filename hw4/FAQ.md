#FAQ's

##I'm lost. Where do I start?

Below is a possible plan of attack:

* First try extending the given trigram code into qgrams without adding the new rules. Set `q` statically to some value in the `trgm.h` header file and replace your trgm character array in your header file to have size `q` now. Remove the existing padding in the trigrams and also take care of the case when len(word) < q

* Now that you have the simple q-grams implemented implement the two new rules which now allow for variable sized q-grams now. As mentioned in the `Hints` in the spec, it might be a good idea to have all the `q-grams` be of the same length and pad the extra space at the end with whitespaces. This will make the pointer arithmetic in your C code much easier. Since the largest `q-gram` is q+1 characters big, a suggestion is that you have all q-grams be `q+2` characters long with the last character in the `q-gram` representing whether this particular `g-gram` is a "normal" q-gram with q characters, whether it is a "special" q-gram with q+1 characters (i.e. with a '!' at the end of it) or if it is a "special" q-gram with a "#" after the first character

* Finally, now try to set q at runtime. The trgm character array will now have to be changer into a pointer (since we don't know the value of `q` at compile time). WARNING: This will complicate the pointer arithmetic, as ++ on a trgm* will now only move forward *one character* instead of q characters.

##I've made changes to the source code. How do I test them out?

Your wonderful GSI Aaron has you covered! Normally, after making changes to your code, you need to re-make the extension, reinstall it, restart postgres, and then run psql. In order to simplify this process, we've provided you with a handy bash script `do_magic.sh` in the `contrib/pg_trgm` directory (i.e., same directory as `pg_trgm.c`).

You can use this bash script throughout your development to recompile and run queries. Example usage:
`./do_magic.sh "SELECT show_trgm('apple')"`

In addition to doing the above mentioned tasks, this script also helps by providing some useful error checking.

##What do the following errors mean:

###psql: could not connect to server: No such file or directory. Is the server running locally and accepting connections on Unix domain socket "/tmp/.s.PGSQL.5000"?

Please read the "Getting Started: Building PostgreSQL" section. If your postgres isn't starting up on the default port, you'll have to read the "Port conflicts" section. If you have had to modify your port as described in that section, then make sure that when starting your server and the psql prompt you specify the port you set. For example, if you had to modify your port to 5430, then you should start your server and connect to the psql command line client as follows:

```
$HOME/pgsql/bin/pg_ctl -D data -p 5430 -l log.txt start
$HOME/pgsql/bin/psql -p 5430 postgres
```
Also note that if you are making use of the `do_magic.sh` shell script, you will have to edit the last line to include the relevant port.

If you didn't modify the port, then you don't need to enter the `-p <port>` option

###ERROR: could not find block containing chunk 0x9163968" mean?

It means that you either have a memory leak or a buffer overflow. Some of the common mistakes are not pfree'ing memory that you have palloc'ed. It could also be the result of not palloc'ing enough memory.

Either add elog() statements before all your pfree's and palloc's and then check your log file to isolate which part of your code is causing the problem. Or use gdb as described in the "Debugging with gdb" section of the spec 

###Upon running my query, I get the following error - "The connection to the server was lost. Attempting reset: Failed."

This is probably the result of you not having set the `POSTGRES_Q_GRAM` environment variable before starting your server