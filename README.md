HeapStats Cookbook
====================
This cookbook install java monitoring and analysis tool <a href="http://icedtea.classpath.org/wiki/HeapStats">HeapStats</a>.


Requirements
--------------

- Java Opscode Community Cookbook
- Chef Client 11+

Platform
----------

- CentOS6+ 
- Fedora

Tested on:
- CentOS6.5


Usage
-----

Include `heapstats` in your node's `run_list` or roll.
By default, heapstats collects java heap statics on full gc, after that logging to target java process current directory.
When you would like to change log directory, you override attributes as follows.

note:
HeapStats depends on debug symbol.
If java runtime use OpenJDK, you should install debuginfo package. 

### example
Install OpenJDK, HeapStats agent, Wildfly that attached HeapStats agent (JAVA_OPTS add -agentlib:heapstats).

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[heapstats]",
    "recipe[wildfly]"
  ],
  "java": {
    "install_flavor":"openjdk",
    "jdk_version":"7",
    "openjdk_packages":["java-1.7.0-openjdk", "java-1.7.0-openjdk-devel", "java-1.7.0-openjdk-debuginfo"]
  },
  "wildfly": {
    "jpda": {
      "enabled":false
    },
    "java_opts": {
      "other": ["-agentlib:heapstats"]
    }
  },
  "heapstats": {
    "file":"/opt/wildfly/standalone/log/heapstats_snapshot.dat",
    "heaplogfile":"/opt/wildfly/standalone/log/heapstats_log.csv",
    "archivefile":"/opt/wildfly/standalone/log/heapstats_analyze.zip"
  }
}
```


Attributes
----------

- `['heapstats']['heapstatsurl']`: heapstats agent download site. (default http://icedtea.wildebeest.org/download/heapstats)
- `['heapstats']['version']`: heapstats agent version. (default 1.1.2)
- `['heapstats']['build']`: heapstats build number (default 0)
- `['heapstats']['file']`: Java heap snapshot filename. By default, write snapshot file to java process current directory.  (default heapstats_snapshot.dat)
- `['heapstats']['heaplogfile']`: Statistics log file for <a href="http://icedtea.classpath.org/wiki/HeapStats/Informations_to_collect#Normal_mode">normal mode</a>
  (default heapstats_log.csv)
- `['heapstats']['archivefile']`: Log archive name for <a href="http://icedtea.classpath.org/wiki/HeapStats/Informations_to_collect#All_mode">all mode</a>
  (default heapstats_analyze.zip)
- `['heapstats']['alert_percentage']`: Threshold for sending alert messages about each Java class. This value depends on "rank_order" . If increments from previous snapshot is greater than this threshold (delta), or the heap usage is greater than this threshold (usage), agent shows alert message to stderr and send SNMP trap. If this value is set zero, heap alert is disabled. (default 50)
- `['heapstats']['javaheap_alert_percentage']`: Threshold for sending total Java heap alert message. If Java heap usage is greater than this threshold, agent shows alert message to stderr and send SNMP trap. If this value is set zero, this alert is disabled. (default 95)
- `['heapstats']['snmp_send']`: If this value is set true, agent send SNMP trap when agent traps various alerts and errors. Otherwise (false), agent does NOT send any SNMP traps. (default false)
- `['heapstats']['snmp_target']`: Host which SNMP traps are handled. (default localhost)
- `['heapstats']['snmp_comname']`: SNMP community name. (default public)
- `['heapstats']['kill_on_error']`: If this value is set true, the agent will kill targeted JVM process when catches OutOfMemoryError or DeadLock. (default false)


Authors
--------
Author: Norito AGETSUMA (https://github.com/n-agetsu)
