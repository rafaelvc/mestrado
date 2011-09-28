#!/bin/bash

# GP parameters variations
# ec.pop.size
# ec.term.maxgen
# gp.tree.maxdepth
# gp.mutstd.indpb
# DATASET:IONOSPHERE

# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=100


# Popsize 1000, Gensize=100 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=100,gp.init.maxdepth=12
# DSDIR=pop1000tree12mutsd15cx85gen100
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=100,gp.init.maxdepth=24
# DSDIR=pop1000tree24mutsd15cx85gen100
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=100,gp.init.maxdepth=12
# DSDIR=pop1000tree12mutsd30cx70gen100
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=100,gp.init.maxdepth=24
# DSDIR=pop1000tree24mutsd30cx70gen100
# 
# 
# # Popsize 2000, Gensize=100 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=100,gp.init.maxdepth=12
# DSDIR=pop2000tree12mutsd15cx85gen100
# 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=100,gp.init.maxdepth=24
# DSDIR=pop2000tree24mutsd15cx85gen100
# 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=100,gp.init.maxdepth=12
# DSDIR=pop2000tree12mutsd30cx70gen100
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=100,gp.init.maxdepth=24
# DSDIR=pop2000tree24mutsd30cx70gen100
# 
# 
# # Popsize 1000, Gensize=200 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=200,gp.init.maxdepth=12
# DSDIR=pop1000tree12mutsd15cx85gen200
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=200,gp.init.maxdepth=24
# DSDIR=pop1000tree24mutsd15cx85gen200
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=200,gp.init.maxdepth=12
# DSDIR=pop1000tree12mutsd30cx70gen200
# 
GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=200,gp.init.maxdepth=24
DSDIR=pop1000tree24mutsd30cx70gen200
# 
# 
# # Popsize 2000, Gensize=200 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=200,gp.init.maxdepth=12
# DSDIR=pop2000tree12mutsd15cx85gen200
# 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.15,gp.cx.indpb=0.85,ec.term.maxgen=200,gp.init.maxdepth=24
# DSDIR=pop2000tree24mutsd15cx85gen200
# 
# GPPARAM=ec.pop.size=2000,gp.tree.maxdepth=12,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=200,gp.init.maxdepth=12
# DSDIR=pop2000tree12mutsd30cx70gen200
# 
# GPPARAM=ec.pop.size=1000,gp.tree.maxdepth=24,gp.mutstd.indpb=0.30,gp.cx.indpb=0.70,ec.term.maxgen=200,gp.init.maxdepth=24
# DSDIR=pop2000tree24mutsd30cx70gen200

DIR=ionos_andras-dist3.0-curv0.5-f3_

ssh ct02 "./e/launch_jobs_1-4.sh $DIR $GPPARAM $DSDIR > /dev/null 2>&1 </dev/null &"   
echo "ct02 done" 
ssh ct04 "./e/launch_jobs_5-8.sh $DIR $GPPARAM $DSDIR > /dev/null 2>&1 </dev/null &"  
echo "ct04 done" 
ssh ct06 "./e/launch_jobs_9-12.sh $DIR $GPPARAM $DSDIR > /dev/null 2>&1 </dev/null &" 
echo "ct06 done" 
ssh ag06 "./e/launch_jobs_13-15.sh $DIR $GPPARAM $DSDIR > /dev/null 2>&1 </dev/null &"
echo "ag06 done" 
