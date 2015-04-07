#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Control Script for the CATALINA Server
#
# Environment Variable Prerequisites
#
#   Set the enviroment variables in this script, as recommended in catalina.sh 
#   in to keep our customizations separate. 
#
#   As we want to ship/start the catalina with a defined JRE we set JRE_HOME to 
#   our predefined location.
#-------------------------------------------------------------------------------

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false
darwin=false
os400=false
case "`uname`" in
CYGWIN*) cygwin=true;;
Darwin*) darwin=true;;
OS400*) os400=true;;
esac

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

# Only set CATALINA_HOME if not already set
[ -z "$CATALINA_HOME" ] && CATALINA_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`

# Copy CATALINA_BASE from CATALINA_HOME if not already set
[ -z "$CATALINA_BASE" ] && CATALINA_BASE="$CATALINA_HOME"

#JRE_HOME=${CATALINA_HOME}/jre

CHARMEMAPS_BASE=`cd "$CATALINA_HOME/.." >/dev/null; pwd`
echo Using CHARMEMAPS_BASE:	$CHARMEMAPS_BASE

mkdir $CHARMEMAPS_BASE/.ncWMS
NCWMS_CONFIG=`cd "$CHARMEMAPS_BASE/.ncWMS" >/dev/null; pwd`
echo "configDir=${NCWMS_CONFIG}" > $CATALINA_HOME/webapps/ncWMS/WEB-INF/classes/config.properties
echo Using NCWMS_CONFIG:	$NCWMS_CONFIG

# Set up the CHARMeMaps configuration for ncWMS
if [ ! -e $NCWMS_CONFIG/config.xml ]; then
  if [ -e $NCWMS_CONFIG/CHARMeMaps_config.xml ]; then
    sed "s%&CHARMEMAPS_BASE;%${CHARMEMAPS_BASE}%g" $NCWMS_CONFIG/CHARMeMaps_config.xml.template >  $NCWMS_CONFIG/config.xml
    echo Using NCWMS_CONFIG:$NCWMS_CONFIG
  else
    echo "Warning!!! $NCWMS_CONFIG/CHARMeMaps_config.xml does not exist!"
  fi
fi

# Set up the CHARMeMaps configuration for the tomcat/ncWMS port
if [ -e $CATALINA_HOME/webapps/charme-maps ]; then
    #configure CHARMeMaps
    CHARMEMAPS_APP=$CATALINA_HOME/webapps/charme-maps
    #getting the tomcat-port
    MY_PORT=$(xpath $CATALINA_HOME/conf/server.xml '/Server/Service[@name="Catalina"]/Connector[@protocol="HTTP/1.1"]/@port' 2>&1 | grep port | egrep -o '[[:digit:]]{4}')
    #setting the tomcat-port
    sed "s%&MY_PORT;%${MY_PORT}%g" ${CHARMEMAPS_APP}/WEB-INF/web.xml.template > ${CHARMEMAPS_APP}/WEB-INF/web.xml
else
    echo "Warning!!! $CATALINA_HOME/webapps/charme-maps does not exist!"
fi

