#!/bin/bash

#N.B.: This is hardly a pretty bash script.

rm -rf test-output 2> /dev/null
mkdir test-output 2>/dev/null

psql USASpending < hw2_warmup.sql;

pass=true

psql -c "SELECT * FROM q1 ORDER BY contractorname, obligatedamount;" USASpending > test-output/p1.q1.txt
if ! diff test-output/p1.q1.txt /home/ff/cs186/sp12/hw2/part1/out/p1.q1.txt; 
then
pass=false
echo -e "\e[02;31mERROR:\e[00m q1 output differed!"
fi

psql -c "SELECT * FROM q2 ORDER BY contractorname, obligatedamount;" USASpending > test-output/p1.q2.txt
if ! diff test-output/p1.q2.txt /home/ff/cs186/sp12/hw2/part1/out/p1.q2.txt; 
then
pass=false
echo -e "\e[02;31mERROR:\e[00m q2 output differed!"
fi

psql -c "SELECT * FROM q3 ORDER BY cnt;" USASpending > test-output/p1.q3.txt
if ! diff test-output/p1.q3.txt /home/ff/cs186/sp12/hw2/part1/out/p1.q3.txt; 
then
pass=false
echo -e "\e[02;31mERROR:\e[00m q3 output differed!"
fi

psql -c "SELECT * FROM q4 ORDER BY majagency_tr, current_agency_head;" USASpending > test-output/p1.q4.txt
if ! diff test-output/p1.q4.txt /home/ff/cs186/sp12/hw2/part1/out/p1.q4.txt; 
then
pass=false
echo -e "\e[02;31mERROR:\e[00m q4 output differed!"
fi

psql -c "SELECT * FROM q5 ORDER BY recip_id, recipient_name, cnt;" USASpending > test-output/p1.q5.txt
if ! diff test-output/p1.q5.txt /home/ff/cs186/sp12/hw2/part1/out/p1.q5.txt; 
then
pass=false
echo -e "\e[02;31mERROR:\e[00m q5 output differed!"
fi

if $pass; then
echo -e "\e[00;32mSUCCESS:\e[00m Your queries worked on this data set!"
fi
