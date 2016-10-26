#!/bin/ksh

# Script for determining total, free and used space per Veritas DG as well as free chunks per disk
# Robert Dawson
# Fujitsu Services
# 24/10/2015


for DG in `vxdg list | grep -v NAME | awk '{ print $1 }'`
do
                echo "DG = $DG"
                TOTAL=`vxprint -g $DG -dF "%publen" | awk 'BEGIN {s = 0} {s += $1} END {print s/2097152}'`
                echo "Total Size (GB): $TOTAL"
                UNUSED_GB=`vxdg -g $DG free | grep -v OFFSET | awk 'BEGIN {s = 0} {s += $5} END {print s/2097152}'`
                echo "Free Space (GB): $UNUSED_GB"
                USED=`echo "scale=4\n$TOTAL - $UNUSED_GB" | bc`
                echo "Used Space (GB): $USED"
                #comment out the command below when running on cluster nodes due to its history of causing issues on cluster nodes.
                vxassist -g $DG maxsize
                echo "Breakdown of free space per disk:"
                vxdg -g $DG free | nawk '
                {
                if ($5/2/1024 > 0)
                print ". . .  Free chunk on "$1"("$2")"" " $5/2/1024, "MB"
                }'
                echo "#######################################################"
done
