#!/bin/bash
cd /opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-release-1.1
rm ./config/currentView
./startReplica.sh $NUMBER