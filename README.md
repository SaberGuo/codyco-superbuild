CoDyCo Project Superbuild
---------------
| Linux/OS X | 
|:----------:|
| [![Build Status](https://travis-ci.org/robotology/codyco-superbuild.png?branch=master)](https://travis-ci.org/robotology/codyco-superbuild) | 
The CoDyCo project is a four-years long project that started in March 2013. At the end of each year a scenario will be used to validate on the iCub the theoretical advances of the project.

More info at http://codyco.eu/

Code documentation automatically generated: http://wiki.icub.org/codyco/dox/html/index.html

This is a meta repository (so-called "superbuild") that uses [YCM](https://github.com/robotology/ycm) to compile CoDyCo software. 
A YCM Superbuild is a CMake project whose only goal is to download and build several other projects. You can read more about the superbuild concept in [YCM documentation](http://robotology.github.io/ycm/gh-pages/master/manual/ycm-superbuild.7.html).

Superbuild structure
====================

codyco-superbuild will download and build a number of projects, divided in components.
For each project, the repository will be downloaded in the `component/project` subdirectory
of the superbuild root. The build directory for a given project will be instead the `component/project` subdirectory
of the superbuild build directory. 

###`external`

The `external` component contains software not developed inside the CoDyCo consortium, but that is a dependency of CoDyCo software. 

###`libraries`

The `libraries` component contains librares developed by the CoDyCo consortium, that could be used also by external software. 

The projects downloaded in the `libraries` component are:

* `codyco-commons`: A collection of functions and utilities used in the other projects [Project page](https://github.com/robotology-playground/codyco-commons)
* `idyntree`: YARP-based Floating Base Robot Dynamics Library [Project Page](https://github.com/robotology-playground/idyntree)
* `paramHelp`: Library for simplifying the management of the parameters of YARP modules [Project page](https://github.com/robotology-playground/paramHelp)
* `wholebodyinterface`: C++ Interfaces to sensor measurements, state estimations, kinematic/dynamic model and actuators for a floating base robot [Project Page](https://github.com/robotology-playground/wholebodyinterface)
* `yarp-wholebodyinterface`: Implementation of the wholeBodyInterface for YARP robots [Project Page](https://github.com/robotology-playground/yarp-wholebodyinterface)

###`main`

The `main` component contains executable software developed by the CoDyCo consortium, for example YARP modules, 
Simulink models or Lua scripts. 

The projects downloaded in the `main` component are:

* `WBI-Toolbox`: Simulink Toolbox for rapid prototyping of Whole Body Robot Controllers [Project Page](https://github.com/robotology-playground/WBI-Toolbox)
* `codyco-modules`: YARP modules and controllers developed within the European Project CoDyCo [project Page](https://github.com/robotology/codyco-modules)

Update
======
For updating the codyco-superbuild repository it is possible to just fetch the last changes using the usual 
git command:
~~~
git pull
~~~
However, for running the equivalent of `git pull` on all the repositories managed by
the codyco-superbuild, you have to execute in your build system the appropriate target, for example:
~~~
make update-all
~~~

Installation
============
**The [`gazebo-yarp-plugins`](https://github.com/robotology/gazebo_yarp_plugins), that are usually used for testing CoDyCo software simulating the iCub in Gazebo, are not installed by the `codyco-superbuild`. If you want to simulate the iCub in Gazebo you have to follow the instruction in [gazebo-yarp-plugins README](https://github.com/robotology/gazebo_yarp_plugins).**


We provide different instructions on how to install codyco-superbuild, depending on your operating system:
* [**Windows**](#windows): use the superbuild with Microsoft Visual Studio
* [**OS X**](#os-x): use the superbuild with Xcode or GNU make
* [**Linux**](#linux): use the superbuild with make 

##Windows

###System Dependencies 

####CMake
To install CMake you can use the official installer available at http://www.cmake.org/cmake/resources/software.html .

####Eigen
You can install Eigen from source code available from the [Eigen official website](http://eigen.tuxfamily.org).
You can simply extract the Eigen source code in a directory, and then define the `EIGEN3_ROOT` environment variable to the path of the directory that contains the file `signature_of_eigen3_matrix_library` (it should be the first directory contained in the compressed file.  

####Boost 
The easy way to install Boost on Windows is to use the [Boost binaries installers](http://sourceforge.net/projects/boost/files/boost-binaries/1.55.0/). Pay attention to 
download a release that matches your Visual Studio version. Furthermore as iCub software does not 
support 64bit compilation at the moment we reccomend to compile the codyco-superbuild as 32bit software, and
thus you have to downalod 32bit binaries for Boost. 

After downloading and installing the Boost libraries, you then need to set the following two environment variables to point respectively to the path of the libraries and the headers, for example:
~~~
BOOST_LIBRARYDIR=C:\path\where\boost\is\libboost_1_54_0\lib32-msvc-10.0
BOOST_INCLUDEDIR=C:\path\where\boost\is\libboost_1_54_0
~~~

####YARP & iCub
For installing the latest version of YARP and ICUB software, please refer to [the official iCub documentation](http://wiki.icub.org/wiki/ICub_Software_Installation).

###Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
After that you can clone the superbuild repository as any other git repository, and generate the Visual Studio solution
using the CMake gui. Then you open the generated solution with Visual Studio and build the target `all`. 
Visual Studio will then download, build and install in a local directory all the CoDyCo software and its dependencies.

###Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `codyco-superbuild/build/install/bin` and all libraries in `codyco-superbuild/build/install/lib`.

To use this binaries and libraries, you should update the necessary environment variables.

Set the environment variable CODYCO\_SUPERBUILD\_DIR so that it points to the  directory where you clone the codyco-superbuild repository.

Append $CODYCO\_SUPERBUILD\_DIR/build/install/bin to your PATH

Append $CODYCO\_SUPERBUILD\_ROOT/build/install/share/codyco to your [YARP\_DATA\_DIRS](http://wiki.icub.org/yarpdoc/yarp_data_dirs.html) environment variable.


##OS X

###System Dependencies 
To install Eigen and CMake, it is possible to use [Homebrew](http://brew.sh/):
```
brew install eigen cmake boost tinyxml
```

For installing the latest version of YARP and ICUB software, please refer to [the official iCub documentation](http://wiki.icub.org/wiki/ICub_Software_Installation).

###Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
Finally it is possible to install CoDyCo software using the YCM superbuild:
```bash
git clone https://github.com/robotology-playground/codyco-superbuild.git
cd codyco-superbuild
mkdir build
cd build
```
To use GNU Makefile generators:
```bash
cmake ../
make
```
To use Xcode project generators
```bash
cmake ../ -G Xcode
xcodebuild -configuration Release
```

###Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `codyco-superbuild/build/install/bin` and all libraries in `codyco-superbuild/build/install/lib`.

To use this binaries you should update the `PATH` environment variables.

An easy way is to add these lines to the `.bashrc` or `.bash_profile` file in your home directory:
```bash
CODYCO_SUPERBUILD_ROOT=/directory/where/you/downloaded/codyco-superbuild
export PATH=$PATH:$CODYCO_SUPERBUILD_ROOT/build/install/bin
export YARP_DATA_DIRS=$YARP_DATA_DIRS:$CODYCO_SUPERBUILD_ROOT/build/install/share/codyco
```

Most of the modules in the codyco-superbuild are correctly configured to automatically find the libraries.
If you create a new application or library that need to be linked to codyco-superbuild libraries (or if you are having issues with the dynamic loader) add also the following line to your `.bashrc` or `.bash_profile`.

```bash
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CODYCO_SUPERBUILD_ROOT/build/install/lib
```

To use the updated `.bashrc` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bashrc
```
or for the `.bash_profile` file
```bash
user@host:~$ source ~/.bash_profile
```
or simply open a new terminal.

##Linux 
###System Dependencies 
On Debian based systems (as Ubuntu) you can install CMake and Eigen (and other dependencies necessary for the codyco-superbuild) using `apt-get`:
```
sudo apt-get install libeigen3-dev cmake cmake-curses-gui libboost-system-dev libboost-thread-dev libtinyxml-dev libace-dev libgtkmm-2.4-dev libglademm-2.4-dev libgsl0-dev libcv-dev libhighgui-dev libcvaux-dev libode-dev
```
The packages provided in the official distro repositories work out of the box for **Ubuntu 14.04** (`trusty`), **Ubuntu 13.10** (`saucy`) and **Debian 8** (`jessie`).
For older distros the included CMake and Eigen are too old, and is necessary to find a way to install them from an alternative
source:
* In **Debian 7** (`wheezy`) it is sufficient to [enable the `wheezy-backports` repository](http://backports.debian.org/Instructions/) to get recent versions of CMake and Eigen.
* In **Ubuntu 12.04** (`precise`) a [PPA is available to easily install CMake 2.8.11](https://launchpad.net/~kalakris/+archive/cmake). To install a recent version of Eigen the easiest solution is [to get Eigen from source](http://eigen.tuxfamily.org/index.php?title=Main_Page#Download).

If for some reason you are bound to use Eigen 3.0.5 (for example for XDE compatibility) you can just set to off the `CODYCO_USES_EIGEN_320` CMake variable. In this way you will compile just the software that is compatible with Eigen 3.0.5 .  

For installing the latest version of YARP and ICUB software, please refer to [the official iCub documentation](http://wiki.icub.org/wiki/Linux:Installation_from_sources). Please note that at the moment 
the codyco-superbuild only supports YARP and ICUB installed from sources.

###Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
Finally it is possible to install CoDyCo software using the YCM superbuild:
```bash
git clone https://github.com/robotology-playground/codyco-superbuild.git
cd codyco-superbuild
mkdir build
cd build
ccmake ../
make
```
###Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `codyco-superbuild/build/install/bin` and all libraries in `codyco-superbuild/build/install/lib`.

To use this binaries and libraries, you should update the `PATH` and `LD_CONFIG_PATH` environment variables.

An easy way is to add this lines to the '.bashrc` file in your home directory:
```
CODYCO_SUPERBUILD_ROOT=/directory/where/you/downloaded/codyco-superbuild
export PATH=$PATH:$CODYCO_SUPERBUILD_ROOT/build/install/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CODYCO_SUPERBUILD_ROOT/build/install/lib
export YARP_DATA_DIRS=$YARP_DATA_DIRS:$CODYCO_SUPERBUILD_ROOT/build/install/share/codyco
```
To use the updated `.bashrc` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bashrc
```
If may also be necessary to updates the cache of the dynamic linker:
```bash
user@host:~$ sudo ldconfig
```
