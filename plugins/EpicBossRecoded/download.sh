#!/bin/bash
varPath="../../function/var.sh"
if [ -f $varPath ]; then
    source $varPath
else
    exit;
fi
pluginName='EpicBossRecoded'

cd $thisServerPath/plugins/$pluginName
scp -r $pluginServerPath/plugins/$pluginName ../
