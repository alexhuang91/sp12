#!/bin/bash

#N.B.: This is hardly a pretty bash script.

rm -rf test-output 2> /dev/null
mkdir test-output 2>/dev/null

pass=true

#ITERATION 0
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-micro.csv 0 2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/micro.paths_to_update.iteration0.txt
if ! diff test-output/micro.paths_to_update.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/micro.paths_to_update.iteration0.txt; 
then
echo "paths_to_update didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/micro.compare_paths.iteration0.txt
if ! diff test-output/micro.compare_paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/micro.compare_paths.iteration0.txt; 
then
echo "compare_paths didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/micro.new_paths.iteration0.txt
if ! diff test-output/micro.new_paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/micro.new_paths.iteration0.txt; 
then
echo "new_paths didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/micro.paths.iteration0.txt
if ! diff test-output/micro.paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/micro.paths.iteration0.txt; 
then
echo "paths didn't match at iteration break number 0"
pass=false
fi

if ! $pass ; then
echo "wrong output at iteration break number 0; stopping"
exit
fi

#ITERATION 1
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-micro.csv 1  2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/micro.paths_to_update.iteration1.txt
if ! diff test-output/micro.paths_to_update.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/micro.paths_to_update.iteration1.txt; 
then
echo "paths_to_update didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/micro.compare_paths.iteration1.txt
if ! diff test-output/micro.compare_paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/micro.compare_paths.iteration1.txt; 
then
echo "compare_paths didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/micro.new_paths.iteration1.txt
if ! diff test-output/micro.new_paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/micro.new_paths.iteration1.txt; 
then
echo "new_paths didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/micro.paths.iteration1.txt
if ! diff test-output/micro.paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/micro.paths.iteration1.txt; 
then
echo "paths didn't match at iteration break number 1"
pass=false
fi

if ! $pass ; then
echo "wrong output at iteration break number 1; stopping"
exit
fi

#Betweenness Centrality

ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-micro.csv 2> /dev/null

psql -c "SELECT * FROM between_paths ORDER BY s, v, t, path;" enron_stats > test-output/micro.between_paths.txt
if ! diff test-output/micro.between_paths.txt /home/ff/cs186/sp12/hw2/part2/out/micro.between_paths.txt;
then
echo "between_paths was wrong"
pass=false
fi

psql -c "SELECT * FROM betweenness_centrality ORDER BY sender, centrality;" enron_stats > test-output/micro.betweenness_centrality.txt
if ! diff test-output/micro.betweenness_centrality.txt /home/ff/cs186/sp12/hw2/part2/out/micro.betweenness_centrality.txt;
then
echo "betweenness_centrality was wrong"
pass=false
fi

if ! $pass ; then
echo "centrality table output was wrong; stopping"
exit
fi

echo "Intermediate tables and output matched for test-micro.csv! Nice job."
