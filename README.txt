================================================================================

===================================================
Running CHARMeMaps on a Apache Tomcat 7.0 Servlet/JSP Container
===================================================


PROLOG
CHARMeMaps is WebApplication running on a preconfigured Apache Tomcat  7.0 Servlet/JSP Container.

HOW TO START CHARMeMaps
After starting the shipped and preconfigured Apache Tomcat, please look at 
the RUNNING.txt file in the Apache Tomcat home-directory, the CHARMeMaps 
WebApplication is available under http://localhost:8080/charme-maps.

PREREQUISITES:
The Apache Tomcat 7.0.x requires a Java Standard Edition Runtime Environment (JRE) 
version 6 or later. For more information on how to run the Apache Tomcat please 
look at the RUNNING.txt file in the Apache Tomcat home-directory.

THE PRE-CONFIGURATION OF THE APACHE TOMCAT
The CHARMeMaps WebApplication is shipped alongside a preconfigured ncWMS,
running on the same apache-tomcat instance. 

In the CHARMEMAPS_HOME  the files
and directories are split as following:

  * .ncWMS		the confiration and log-files for the shipped ncWMS instance
  * apache-tomcat*	Home of the preconfigured  Apache Tomcat 7.0 Servlet/JSP Container 
			which hosts the CHARMeMaps WebApplication
  * data		root directory for the CMSAF data shipped together with CHARMeMaps
			and visualized by the ncWMS

All customizations of the apache-tomcat on behalf of the CHARMeMaps web-application
are set during the start of the apache-tomcat, please look at the apache-tomcat*/bin/setenv.sh
for further details.



