#!/bin/bash
source ./cymeteo/scripts/functions.sh
source ./cymeteo/scripts/var.sh

# Checking the options
source ./cymeteo/scripts/opts.sh

# Filtering data by date and location
source ./cymeteo/scripts/filter.sh

# Sorting the data according to the chosen option(s)
# Edit the CSV file sorted in DAT
# Generate graphics with gnuplot
source ./cymeteo/scripts/run_c.sh

printf "Processing complete!\n\n"
printf $COLOR_GRAY"Note: All generated graphics are in the 'graph' folder.\n"$COLOR_NC

exit 0
