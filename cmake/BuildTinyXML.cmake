#.rst:
# BuildTinyXML
# ------------
#
# TinyXML

#=============================================================================
# Copyright 2013-2014 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of YCM, substitute the full
# License text for the above reference.)

include(YCMEPHelper)

ycm_ep_helper(TinyXML TYPE GIT
                      STYLE GITHUB
                      REPOSITORY traversaro/tinyxml.git)
