#!/bin/bash

#N.B.: This is hardly a pretty bash script.

rm -rf test-output 2> /dev/null
mkdir test-output 2>/dev/null

pass=true

#ITERATION 0
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-sm.csv 0 2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths_to_update.iteration0.txt
if ! diff test-output/sm.paths_to_update.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths_to_update.iteration0.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths_to_update didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/sm.compare_paths.iteration0.txt
if ! diff test-output/sm.compare_paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/sm.compare_paths.iteration0.txt; 
then
echo -e "\e[02;31mERROR:\e[00m compare_paths didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.new_paths.iteration0.txt
if ! diff test-output/sm.new_paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/sm.new_paths.iteration0.txt; 
then
echo -e "\e[02;31mERROR:\e[00m new_paths didn't match at iteration break number 0"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths.iteration0.txt
if ! diff test-output/sm.paths.iteration0.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths.iteration0.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths didn't match at iteration break number 0"
pass=false
fi

if ! $pass ; then
echo -e "\e[02;31mERROR:\e[00m wrong output at iteration break number 0; stopping"
exit
fi

#ITERATION 1
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-sm.csv 1  2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths_to_update.iteration1.txt
if ! diff test-output/sm.paths_to_update.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths_to_update.iteration1.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths_to_update didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/sm.compare_paths.iteration1.txt
if ! diff test-output/sm.compare_paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/sm.compare_paths.iteration1.txt; 
then
echo -e "\e[02;31mERROR:\e[00m compare_paths didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.new_paths.iteration1.txt
if ! diff test-output/sm.new_paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/sm.new_paths.iteration1.txt; 
then
echo -e "\e[02;31mERROR:\e[00m new_paths didn't match at iteration break number 1"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths.iteration1.txt
if ! diff test-output/sm.paths.iteration1.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths.iteration1.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths didn't match at iteration break number 1"
pass=false
fi

if ! $pass ; then
echo -e "\e[02;31mERROR:\e[00m wrong output at iteration break number 1; stopping"
exit
fi

#ITERATION 2
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-sm.csv 2 2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths_to_update.iteration2.txt
if ! diff test-output/sm.paths_to_update.iteration2.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths_to_update.iteration2.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths_to_update didn't match at iteration break number 2"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/sm.compare_paths.iteration2.txt
if ! diff test-output/sm.compare_paths.iteration2.txt /home/ff/cs186/sp12/hw2/part2/out/sm.compare_paths.iteration2.txt; 
then
echo -e "\e[02;31mERROR:\e[00m compare_paths didn't match at iteration break number 2"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.new_paths.iteration2.txt
if ! diff test-output/sm.new_paths.iteration2.txt /home/ff/cs186/sp12/hw2/part2/out/sm.new_paths.iteration2.txt; 
then
echo -e "\e[02;31mERROR:\e[00m new_paths didn't match at iteration break number 2"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths.iteration2.txt
if ! diff test-output/sm.paths.iteration2.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths.iteration2.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths didn't match at iteration break number 2"
pass=false
fi

if ! $pass ; then
echo -e "\e[02;31mERROR:\e[00m wrong output at iteration break number 2; stopping"
exit
fi

#ITERATION 3
ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-sm.csv 3 2> /dev/null

psql -c "SELECT * FROM paths_to_update ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths_to_update.iteration3.txt
if ! diff test-output/sm.paths_to_update.iteration3.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths_to_update.iteration3.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths_to_update didn't match at iteration break number 3"
pass=false
fi

psql -c "SELECT * FROM compare_paths ORDER BY s, t, existing_cost, new_cost, path;" enron_stats > test-output/sm.compare_paths.iteration3.txt
if ! diff test-output/sm.compare_paths.iteration3.txt /home/ff/cs186/sp12/hw2/part2/out/sm.compare_paths.iteration3.txt; 
then
echo -e "\e[02;31mERROR:\e[00m compare_paths didn't match at iteration break number 3"
pass=false
fi

psql -c "SELECT * FROM new_paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.new_paths.iteration3.txt
if ! diff test-output/sm.new_paths.iteration3.txt /home/ff/cs186/sp12/hw2/part2/out/sm.new_paths.iteration3.txt; 
then
echo -e "\e[02;31mERROR:\e[00m new_paths didn't match at iteration break number 3"
pass=false
fi

psql -c "SELECT * FROM paths ORDER BY s, t, cost, path;" enron_stats > test-output/sm.paths.iteration3.txt
if ! diff test-output/sm.paths.iteration3.txt /home/ff/cs186/sp12/hw2/part2/out/sm.paths.iteration3.txt; 
then
echo -e "\e[02;31mERROR:\e[00m paths didn't match at iteration break number 3"
pass=false
fi

if ! $pass ; then
echo -e "\e[02;31mERROR:\e[00m wrong output at iteration break number 3; stopping"
exit
fi

#Betweenness Centrality

ruby enron_analyze.rb /home/ff/cs186/sp12/hw2/part2/test-sm.csv 2> /dev/null

psql -c "SELECT * FROM between_paths ORDER BY s, v, t, path;" enron_stats > test-output/sm.between_paths.txt
if ! diff test-output/sm.between_paths.txt /home/ff/cs186/sp12/hw2/part2/out/sm.between_paths.txt;
then
echo -e "\e[02;31mERROR:\e[00m between_paths was wrong"
pass=false
fi

psql -c "SELECT * FROM betweenness_centrality ORDER BY sender, centrality;" enron_stats > test-output/sm.betweenness_centrality.txt
if ! diff test-output/sm.betweenness_centrality.txt /home/ff/cs186/sp12/hw2/part2/out/sm.betweenness_centrality.txt;
then
echo -e "\e[02;31mERROR:\e[00m betweenness_centrality was wrong"
pass=false
fi

if ! $pass ; then
echo -e "\e[02;31mERROR:\e[00m centrality table output was wrong; stopping"
exit
fi

echo -e "\e[00;32mSUCCESS:\e[00m Intermediate tables and output matched for test-sm.csv! Nice job."
