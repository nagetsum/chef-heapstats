# general
default[:heapstats][:heapstatsurl] = "http://icedtea.wildebeest.org/download/heapstats"
default[:heapstats][:version] = "1.1.2"
default[:heapstats][:build] = "0"

# heapstats.conf
# Output file setting
default[:heapstats][:file] = "heapstats_snapshot.dat"
default[:heapstats][:heaplogfile] = "heapstats_log.csv"
default[:heapstats][:archivefile] = "heapstats_analyze.zip"

# Alert setting
default[:heapstats][:alert_percentage] = 50
default[:heapstats][:javaheap_alert_percentage] = 95

# Snmp setting
default[:heapstats][:snmp_send] = false
default[:heapstats][:snmp_target] = "localhost"
default[:heapstats][:snmp_comname] = "public" 

default[:heapstats][:kill_on_error] = false
