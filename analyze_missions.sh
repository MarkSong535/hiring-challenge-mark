#!/bin/bash

# Analysis with AWK for the longest successful Mars mission

awk -F'|' '
BEGIN {
    max_duration = 0
    security_code = ""
}

# Skip comment lines
/^#/ { next }
/^SYSTEM:/ { next }
/^CONFIG:/ { next }
/^CHECKSUM:/ { next }

# Process data lines
{
    # Remove whitespace
    for (i=1; i<=NF; i++) {
        gsub(/^[ \t]+|[ \t]+$/, "", $i)
    }
    
    destination = $3
    status = $4
    duration = $6
    code = $8
    
    # Filter for completed Mars missions
    if (destination == "Mars" && status == "Completed") {
        # Convert duration to number and compare
        if (duration + 0 > max_duration) {
            max_duration = duration + 0
            security_code = code
        }
    }
}

END {
    if (security_code != "") {
        print "Duration " max_duration
        print "Security Code " security_code
    } else {
        print "No completed Mars missions found."
    }
}
' space_missions.log
