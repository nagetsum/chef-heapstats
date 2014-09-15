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
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['heapstats']['heapstatsurl']</tt></td>
    <td>String</td>
    <td>heapstats agent download site</td>
    <td><tt>http://icedtea.wildebeest.org/download/heapstats</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['version']</tt></td>
    <td>String</td>
    <td>heapstats agent version</td>
    <td><tt>1.1.2</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['build']</tt></td>
    <td>String</td>
    <td>heapstats build number</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['file']</tt></td>
    <td>String</td>
    <td>Java heap snapshot filename</td>
    <td><tt>heapstats_snapshot.dat</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['heaplogfile']</tt></td>
    <td>String</td>
    <td>Statistics log file for <a href="http://icedtea.classpath.org/wiki/HeapStats/Informations_to_collect#Normal_mode">normal mode</a></td>
    <td><tt>heapstats_log.csv</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['archivefile']</tt></td>
    <td>String</td>
    <td>Log archive name for <a href="http://icedtea.classpath.org/wiki/HeapStats/Informations_to_collect#All_mode">all mode</a></td>
    <td><tt>heapstats_analyze.zip</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['alert_percentage']</tt></td>
    <td>Integer/td>
    <td>Threshold for sending alert messages about each Java class. This value depends on "rank_order" . If increments from previous snapshot is greater than this threshold (delta), or the heap usage is greater than this threshold (usage), agent shows alert message to stderr and send SNMP trap. If this value is set zero, heap alert is disabled.</td>
    <td><tt>50</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['javaheap_alert_percentage']</tt></td>
    <td>Integer</td>
    <td>Threshold for sending total Java heap alert message. If Java heap usage is greater than this threshold, agent shows alert message to stderr and send SNMP trap. If this value is set zero, this alert is disabled.</td>
    <td><tt>95</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['snmp_send']</tt></td>
    <td>Boolean</td>
    <td>If this value is set true, agent send SNMP trap when agent traps various alerts and errors. Otherwise (false), agent does NOT send any SNMP traps.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['snmp_target']</tt></td>
    <td>String</td>
    <td>Host which SNMP traps are handled.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['snmp_comname']</tt></td>
    <td>String</td>
    <td>SNMP community name.</td>
    <td><tt>public</tt></td>
  </tr>
  <tr>
    <td><tt>['heapstats']['kill_on_error']</tt></td>
    <td>Boolean</td>
    <td>If this value is set true, the agent will kill targeted JVM process when catches OutOfMemoryError or DeadLock.</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Authors
--------
Author: Norito AGETSUMA (https://github.com/n-agetsu)
