require "pg"

#DO NOT EDIT; FOR DEBUGGING AND GRADING
debug_loop_exit = -1
if ARGV.size == 2
   debug_loop_exit = ARGV[1].to_i
end
#END DO NOT EDIT SECTION

#clear out database from any prior runs
%x{dropdb enron_stats}
%x{createdb enron_stats}

conn = PGconn.open(:dbname => 'enron_stats')

conn.exec("
 --storage for directed email graph; read-only for our case
 CREATE TABLE enron (
  sender varchar NOT NULL,
  receiver varchar NOT NULL,
  nummsg numeric NOT NULL
 );

 --read in enron data from file
 COPY enron from '#{ARGV[0]}'
     WITH DELIMITER ',';

 --store our shortest paths so far here
 CREATE TABLE paths (
  s varchar NOT NULL,
  t varchar NOT NULL,
  path varchar[] NOT NULL,
  cost numeric);

 --for performance due to lots of table scans, index paths by s,t columns
 CREATE INDEX path_idx ON paths (s,t);

 CREATE TABLE paths_to_update (LIKE paths);
 CREATE TABLE new_paths (LIKE paths);

 --needed for iterating over all entities in graph
 --only used in second step, calculating betweenness_centrality
 CREATE VIEW vertices AS
  SELECT sender as vertex
    FROM enron
  UNION   -- removes dups!
  SELECT receiver
    FROM enron;
")

# calculate all-pairs, all-paths shortest paths first
conn.exec("
 --paths_to_update starts off with all 1-hop paths
 --because we need to check all of them for longer paths
 --paths are ARRAYS:
 --http://www.postgresql.org/docs/9.1/static/arrays.html
 INSERT INTO paths_to_update SELECT
      sender,
      receiver,
      ARRAY[sender],
      1/nummsg
 FROM enron;"
 )

i = 0
begin
 conn.exec("

 --for each path in paths_to_update (the prior iteration's paths we added)
 --what paths can we create by adding a single link fron the enron relation
 -- to the end?
 CREATE VIEW extended_paths AS
 SELECT DISTINCT paths_to_update.s, enron.receiver AS t,
          array_append(paths_to_update.path, enron.sender) AS path,
          paths_to_update.cost + 1/enron.nummsg AS cost
  FROM enron, paths_to_update
 WHERE paths_to_update.t = enron.sender;

 --TO COMPLETE (#1), probably the hardest query
 --join extended_paths with any pre-existing paths in 'path' that match
 --on both s and t.
 --if there is no matching path in paths, compare_paths.existing_cost should be NULL
 --hint: some kind of OUTER JOIN will be useful here
 CREATE VIEW compare_paths AS
 SELECT E.s, E.t, E.path, E.cost as new_cost, P.cost AS existing_cost
         FROM extended_paths E ???(SOME KIND OF JOIN HERE) paths P
           ON (??? = ??? AND ??? = ???);

 --TO COMPLETE (#2)
 --store the better paths that we've found
 --'better' paths are paths in extended_paths that are either:
 --  lower cost than an existing path in 'paths' with the same s and t OR
 --  are paths that don't exist already in 'paths' (no path in 'paths' with s,t)
 INSERT INTO new_paths
 SELECT s, t, path, new_cost
  FROM compare_paths
 WHERE ??? IS NULL OR  (??? < ???);

 --TO COMPLETE (#3)
 -- now delete the paths that are not minimal wrt paths_to_update;
 -- if we found a shorter path, delete the longer paths...
 DELETE FROM paths WHERE EXISTS
  (SELECT *
    FROM paths_to_update P
   WHERE ??? = ???
     AND ??? = ???
     AND ??? > ???);

 --  ...and insert the shorter paths
 INSERT INTO paths
 SELECT * FROM paths_to_update;")

 #DO NOT EDIT; FOR DEBUGGING AND GRADING
 if i == debug_loop_exit
   exit
 end
 i += 1
 #END DO NOT EDIT SECTION

 conn.exec("
 --rotate newpaths into paths_to_update, and refresh
 --use CASCADE because views depend on paths_to_update
 DROP TABLE paths_to_update CASCADE;
 ALTER TABLE new_paths RENAME TO paths_to_update;
 CREATE TABLE new_paths (LIKE paths);
 ")

# continue to iterate until there are no more paths
end while conn.exec("SELECT COUNT(*) FROM paths_to_update;").getvalue(0,0).to_i > 0

conn.exec("
 -- storage for betweenness centrality
 -- we'll check this first in grading
 CREATE TABLE betweenness_centrality (
      sender varchar NOT NULL,
      centrality NUMERIC,
      PRIMARY KEY (sender));

 -- TO COMPLETE (#4)
 -- find out how many paths passed through each possible v
 -- this is delta_st(v) for all s,t,v
 -- ARRAY operation ANY is useful here:
 -- http://www.postgresql.org/docs/9.1/static/arrays.html
 CREATE VIEW between_paths AS (
      SELECT
        P.s,
        V.vertex as v,
        P.t,
        P.path
      FROM paths P, vertices V
      WHERE ??? != ???
        AND ??? != ???
        AND ??? != ???
        AND ??? IS NOT NULL
        AND ??? = ANY(P.path));

 -- TO COMPLETE (#5)
 -- calculate non-normalized centrality
 -- figure out how many paths there were for each s,t, pair
 -- then apply the betweenness_centrality formula
 -- the Wikipedia article will help here!
 INSERT INTO betweenness_centrality (
   SELECT v, SUM(frac) FROM 
	 (SELECT
	   vCount.v,
	   (vCount.cnt::real)/totCount.cnt as frac
	  FROM 
		(SELECT
		   s,
		   t,
		   COUNT(*) AS cnt
		 FROM paths 
		 GROUP BY s, t) AS (??? choose either totCount OR vCount ???),
	   (SELECT DISTINCT 
		  s,
		  t,
		  v,
		  COUNT(*) AS cnt
		FROM between_paths
		GROUP BY ???,???,???) AS (??? choose either totCount OR vCount ???)
	  WHERE ??? = totCount.s
	  AND ??? = totCount.t) AS sigmas
   GROUP BY v); 

 -- insert all entities who weren't on any relevant shortest paths
 -- everyone should have a listing in betweenness_centrality
 INSERT INTO betweenness_centrality
 SELECT vertex, 0
  FROM vertices V
 WHERE vertex NOT IN (SELECT sender FROM betweenness_centrality);

 -- we can't use aggregates in an update, so compute here first
 CREATE VIEW extremes AS (
      SELECT
        max(centrality) AS maxc,
        min(centrality) as minc
        FROM betweenness_centrality );

 -- TO COMPLETE (#6)
 -- perform normalization
 UPDATE betweenness_centrality
      SET centrality = CASE
                       WHEN ??? != 0 THEN
                         (???-???)/(???-???)
                       ELSE 0
                       END
 FROM extremes E;")

#all done! congratulations!
#take a look at that betweenness_centrality relation!
