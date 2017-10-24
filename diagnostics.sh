#!/bin/bash

# Copyright (c) 2017 All Rights Reserved, http://www.threatstack.com
if [ $EUID -gt 0 ] ; then
    echo "You must be root to run diagnostics.sh"
    exit
fi
echo "/* BEGINNING THREAT STACK DIAGNOSTICS **********************************/"
current_date="$(date +'%m-%d-%Y')"
name=ts_logs_$(hostname)_${current_date}
mkdir /tmp/$name
bash system/gather_system_info.sh | sudo tee /tmp/$name/system_info.txt
bash docker/gather_docker_info.sh | sudo tee /tmp/$name/docker_info.txt
bash agent/gather_agent_info.sh | sudo tee /tmp/$name/agent_info.txt
bash agent/gather_fim_info.sh | sudo tee /tmp/$name/fim_info.txt
echo "/* Copying threat stack log files **************************************/"
cp /opt/threatstack/cloudsight/logs/cloudsight.log /tmp/$name/cloudsight.log
cp /opt/threatstack/cloudsight/logs/install.log /tmp/$name/install.log
cp /opt/threatstack/cloudsight/logs/error.log /tmp/$name/error.log
cp /opt/threatstack/cloudsight/logs/threatstack-audit.log /tmp/$name/threatstack-audit.log
cp /opt/threatstack/cloudsight/logs/threatstack-tsfim.log /tmp/$name/threatstack-tsfim.log
echo "/* Tarring log files ***************************************************/"
tar -czvf $name.tar.gz -C /tmp/ $name || ( echo "Failed to generate tarball! Exiting" ; exit 1 )
echo "/* Done tarring log files **********************************************/"
security_setting=${1:-"--send-safe"}
if [ $security_setting != "--send-unsafe"  ] ; then
    gpg --import support.pub
    gpg --encrypt --trust-model always -r support@threatstack.com $name.tar.gz
fi
rm -rf /tmp/$name 
echo "/* ENDING THREAT STACK DIAGNOSTICS *************************************/"

