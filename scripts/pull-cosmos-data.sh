#!/bin/bash

# this script overwrite the following xml tag in config file and keeps launching processes
# need this start condition
# <add key="fileNumber" value="-1"/>
# <add key="date" value="-1"/>
# <add key ="storecosmosfilelocation" value ="-1"/>"
# <add key="sourcedir" value="-1"/>"

# change the user only (and path if needed)
LOGGED_IN_USER="ksgaipal"
BASE_COSMOS_APP_DIR="C://Users//${LOGGED_IN_USER}//Documents//Cosmos"
COSMOS_DATA_DIR_PREFIX="C:\/Users\/${LOGGED_IN_USER}\/Downloads\/CosmosData_201712"

# pull cosomos data into xml files specific
SCOPE_APP="${BASE_COSMOS_APP_DIR}//PullDataFromCosmos//iscopeTool.exe"
SCOPE_APP_CONFIG_FILE=${SCOPE_APP}".config"

# push xml files to SQL specific
SCOPE_SQL_APP="${BASE_COSMOS_APP_DIR}//XportCosmosXMLToDB//ScopeXmlUpdate.exe"
SCOPE_SQL_APP_CONFIG_FILE=${SCOPE_SQL_APP}".config"

# terminal to launch (windows, bash, etc)
TERMINAL_APP="C://msys64//mingw64.exe"

# all 24 hours
MAX_HOUR=23
PAUSE_DURATION_BEFORE_NEW_HOUR_JOB=5m

function create_day_format
{
    echo `printf "%02d" $1`
}

function create_hour_format
{
    echo `printf "%02d" $1`
}

function create_scope_file_number_xml_tag
{
    echo "<add key=\"fileNumber\" value=\"$1\"\/>"
}

function create_scope_file_date_xml_tag
{
    echo "<add key=\"date\" value=\"$1\"\/>"
}

function create_scope_file_save_location_xml_tag
{
    echo "<add key =\"storecosmosfilelocation\" value =\"${COSMOS_DATA_DIR_PREFIX}$1\"\/>"
}

function create_scope_file_read_location_xml_tag
{
    echo "<add key=\"sourcedir\" value=\"${COSMOS_DATA_DIR_PREFIX}$1\"\/>"
}

function print_variables
{
    echo "Script variables:"
    echo -e "* SCOPE_APP:        " $SCOPE_APP
    echo -e "* SCOPE_APP_CONFIG: " $SCOPE_APP_CONFIG_FILE
    echo -e "* TERMINAL:         " $TERMINAL_APP
    echo -e "* COSMOS_DATA_DIR:  " $COSMOS_DATA_DIR_PREFIX
    echo
}

# launch program for each hour every x seconds
function launch_hour_job
{
    echo -n "starting for $1 hour..."

    eval $TERMINAL_APP $SCOPE_APP
    sleep $PAUSE_DURATION_BEFORE_NEW_HOUR_JOB

    echo " done"
}

function launch_day_job
{
    echo -n "starting for $1 day..."

    pull_for_a_day

    echo " done"
}

function replace_hour
{
    local prev_hour=$1
    local hour=$2

    # replace hour
    local search_text=`create_scope_file_number_xml_tag $prev_hour`
    local replace_text=`create_scope_file_number_xml_tag $hour`
    sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE
}

function replace_day
{
    local prev_day=$1
    local day=$2

    # replace date
    local search_text=`create_scope_file_date_xml_tag $prev_day`
    local replace_text=`create_scope_file_date_xml_tag $day`
    sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE
}

function replace_downloaded_file_location
{
    local prev_day=$1
    local day=$2

    # replace downloaded file location
    local search_text=`create_scope_file_save_location_xml_tag $prev_day`
    local replace_text=`create_scope_file_save_location_xml_tag $day`
    sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE
}

function pull_for_a_day
{
    local prev_hour=-1

    for num in `seq 0 1 $MAX_HOUR`
    do
        local hour=`create_hour_format $num`

        replace_hour $prev_hour $hour
        launch_hour_job $hour

        # update counter
        prev_hour=$hour
    done
}

function pull_for_days_in_range
{
    local prev_day=-1
    local start_day=$1
    local end_day=$2

    for num in `seq $start_day 1 $end_day`
    do
        local day=`create_day_format $num`

        replace_day $prev_day $day
        replace_downloaded_file_location $prev_day $day
        launch_day_job $day

        # update counter
        prev_day=$day
    done
}

function push_to_sql
{
    echo "**TODO**"
}

print_variables

# pull data from days inclusive in range [start, end]
#pull_for_days_in_range 29 29
pull_for_a_day

# push to sql
push_to_sql
