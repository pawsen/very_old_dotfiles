#!/bin/bash
while true
do
	sshpass -p lE3B2QYr ssh -T -l vjkpm fw2.k-net.dk -o ServerAliveInterval=15 -o ServerAliveCountMax=1
	sleep 15
done
