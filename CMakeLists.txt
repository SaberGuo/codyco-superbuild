cmake_minimum_required(VERSION 2.8.11)
project(codyco-superbuild NONE)

## we have to enable C because it is currently used
## by CMake to describe packages (in Config*.cmake files)
enable_language(C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CODYCO-SUPERBUILD_MAJOR_VERSION 0)
set(CODYCO-SUPERBUILD_MINOR_VERSION 2)
set(CODYCO-SUPERBUILD_PATCH_VERSION 0)
set(CODYCO-SUPERBUILD_VERSION ${CODYCO-SUPERBUILD_MAJOR_VERSION}.${CODYCO-SUPERBUILD_MINOR_VERSION}.${CODYCO-SUPERBUILD_PATCH_VERSION})

include(CTest)
include(FeatureSummary)

set(YCM_USE_CMAKE_PROPOSED TRUE CACHE BOOL "Use files including unmerged cmake patches")

#Compilation options

#options to build specific software or use a reduced set of dependencies
option(CODYCO_USES_WBI_TOOLBOX "Whole Body Interface Toolbox - Simulink library" FALSE)
option(CODYCO_USES_WBI_TOOLBOX_CONTROLLERS "Controllers and Simulink models created/used with the WBI-Toolbox" FALSE)
option(CODYCO_USES_URDFDOM "Enable support for URDF input in iDynTree" TRUE)
option(CODYCO_BUILD_ICUB_MODEL_GENERATOR "Enable compilation of the icub-model-generator" FALSE)
option(CODYCO_USES_EIGEN_320 "Enable compilation of software that depends on Eigen 3.2.0 (if false just depend on Eigen 3.0.5)" TRUE)
option(CODYCO_BUILD_ISIR_MODULES "Enable compilation of ISIR controllers" FALSE)
option(CODYCO_USES_MEX_WHOLEBODYMODEL "Enable to compile the matlab mex inteface for iWholeBodyModel" FALSE)
# option(CODYCO_DISABLE_RPATH "Disable installation with RPATH" FALSE) ##TODO: how to control all the RPATH variables of sub-projects?
# mark_as_advanced(CODYCO_DISABLE_RPATH)
option(USE_SYSTEM_TINYXML "Use system TinyXML instead of superbuild one" FALSE)

#options for testing
option(CODYCO_TRAVIS_CI "Set if build is done with Travis-CI flags" FALSE)

# Optionally load a file named ProjectsTags
# for overwriting the desired branch/tag/commit
# of the included subprojects of the superbuild
# Useful for having superbuild "branches"
include(ProjectsTags OPTIONAL)

# Bootstrap YCM
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Required system dependencies
find_package(Boost REQUIRED system thread)

if(CODYCO_USES_EIGEN_320)
    find_package(Eigen3 3.2)
endif()

find_or_build_package(YARP 2.3.63.2)
find_or_build_package(ICUB)
find_or_build_package(yarpWholeBodyInterface)

#build codyco-modules and codycoCommons library only if the use of Eigen 3.2 is enabled
find_or_build_package(codyco-modules)

#codyco isir modules
if( ${CODYCO_BUILD_ISIR_MODULES} )
    find_or_build_package(codyco-isir)
endif()

#additional modules
find_or_build_package(comStepper)

#WBI-Toolbox
if( ${CODYCO_USES_WBI_TOOLBOX} )
    find_or_build_package(WBIToolbox)
endif()

#WBI-Toolbox-controllers
if( ${CODYCO_USES_WBI_TOOLBOX_CONTROLLERS} )
    find_or_build_package(WBIToolboxControllers)
endif()

#mex wholeBodyModel interface
if( ${CODYCO_USES_MEX_WHOLEBODYMODEL} )
   find_or_build_package(mexWholeBodyModel)
endif()

#icub-model-generator
if(${CODYCO_BUILD_ICUB_MODEL_GENERATOR})
    find_or_build_package(icub-model-generator)
endif()

#Documentation
add_subdirectory(doc)

set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
