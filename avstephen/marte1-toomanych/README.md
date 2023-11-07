# Build Notes for Debian Buster (10)

Using the reference docker image avstephen/gcc-cint:buster-slim the first attempt to build 
generated the following issues.

'''
./compile.MARTe linux config.MARTe
- BaseLib2 clean build
- MARTe clean build

WebStatisticGAM error file is non-empty
- BaseLib2/Level0/EventSem.h:142 control reaches end of non-void function
- [-Wreturn-type]
In MakeDefaults/MakeStdDefs.linux 
CFLAGS have no Warnings flags
CPPFLAGS likewise
See note below on compiler settings.
The warning is not an error and WebStatisticGAM.gam has built.

IOGAMs compiled OK : GenericTimerDriver

Interfaces that did not compile cleanly
ConfigurationLibrary
HTTP-CFGUploader
HTTP-FlotPlot
HTTP-MATLABHandler
HTTP-SignalHandler
Logger-JTLogger
TimeServiceActivities-MessageTriggeringTimeService
- All warnings only

6 Interfaces ignored
BaseLib2Adapter
EPICSLib
Logger-RelayLogger
MDSInterface
RTAIConsole
SimulinkInterface

'''

## Runtime Checks

### WaterTank Example

Running the watertank example gives a large volume of 'LoadableLibrary Failed loading'

We will take these one at a time.

'''
PIDGAM : no source for PIDGAM found
Assume this is a branch issue, because by default the code is checked out at master branch level.

git checkout develop
./compile.MARTe linux config.MARTe
Examples/WaterTank
Fails to start.
'''

Now - in MARTe/1 the log messages are sent to a UDP logging port and must be caught by 
either a RelayLogger instance which can route them to syslog, or to a java log viewer.

Within the docker image, we need the ability to run such a service.  If as a java 
application, this needs to run graphically.  OR - we need to route the UDP traffic
off the host (which can be tricky for Docker networking potentially).

The gui java application is found in Interfaces/Logger/JTLogger

'''
This did not build because there is no javac java compiler,
in spite of having installed default jre. The solution is to install 
a JDK which is necessary to get the co piler.

The RelayLogger java application is found in Interfaces/Logger/RelayLogger
but was not built because it is commented out in the config.MARTe file.

Compilting the RelayLogger : o

'''
Unable to create linux/UDPLoggerReceiver.o : no such file or directory.
Manually create this directory
To run the RelayLogger.ex needs a configuration file
such as RelayLoggerLinux.cfg
or RelayLoggerLinuxOnlySyslog.cfg
'''

To summarise; we need to adapt the gcc-cint image in order to add

1. git to clone the MARTe sources
1. JDK to provide javac
1. tmux to be able to run more than one process in the container
1. git clone then checkout the develop branch
1. edit the config.linux to enable building RelayLogger
1. ensure we have gdb
1. try installing vscode - might help the ease of use

# RelayLogger Builds

No "ps" command in the image, and no sign of syslog.
Also no strace - so rebuild again.
Specifically we need

'''
apt-get install -y procps
apt-get install -y strace
apt-get install -y syslog-ng
apt-get install -y netcat 
apt-get install -y snapd
snap install code --classic



## Compiler Settings

To check how a compiler was built.

'''
gcc -Q -v
or
g++ -Q -v
'''

For gcc 8.3.0-6 the build flags for both C and C++ compiler included '--disable-werror' which should
mean that warnings are NOT trated as errors.

## Running Under strace

'''
Clue that CollectionGAMs.gam  may be one of the last loaded objects before bail.
ldd shows that this depends on libMARTeSupLib.so
Check the naming : 
MARTe/MARTeSupportLib/linux/MARTeSupLib.so exists
Seems OK.

Try patching out the data collection.
NBG
Try paytching out the PlottingGAM
NBG
Try patching out the WebStatisticMGAM.gam
NBG
Try patching out the Waveform GAM ?

WaveformGAM is feeling like a contender.
AND indeed : it is not compiled.o
FRom the errors
linux/WaveformGenericClass.o : no such file or directory

FIXED
'''
## Logging and Syslog
i
https://www.loggly.com/blog/centralize-logs-docker-containers/

https://github.com/balabit/syslog-ng-docker/issues/21
