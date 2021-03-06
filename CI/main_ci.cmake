#
# Copyright (C) 2005-2019 Centre National d'Etudes Spatiales (CNES)
#
# This file is part of Orfeo Toolbox
#
#     https://www.orfeo-toolbox.org/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This script is a prototype for the future CI, it may evolve rapidly in a near future
get_filename_component(OTB_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
set (ENV{LANG} "C") # Only ascii output

# Build Configuration : Release, Debug..
set (CTEST_BUILD_CONFIGURATION "Release")
set (CTEST_CMAKE_GENERATOR "Ninja")

# detect short sha
if(NOT DEFINED ENV{CI_COMMIT_SHORT_SHA})
  execute_process(COMMAND git log -1 --pretty=format:%h
                  WORKING_DIRECTORY ${OTB_SOURCE_DIR}
                  OUTPUT_VARIABLE ci_short_sha)
else()
  set(ci_short_sha "$ENV{CI_COMMIT_SHORT_SHA}")
endif()

# Find the build name and CI profile
set(ci_profile wip)
set(ci_mr_source "$ENV{CI_MERGE_REQUEST_SOURCE_BRANCH_NAME}")
set(ci_mr_target "$ENV{CI_MERGE_REQUEST_TARGET_BRANCH_NAME}")
set(ci_mr_iid "$ENV{CI_MERGE_REQUEST_IID}")
set(ci_ref_name "$ENV{CI_COMMIT_REF_NAME}")
set (CTEST_BUILD_NAME ${ci_short_sha})
if(ci_mr_source AND ci_mr_target AND ci_mr_iid)
  set (CTEST_BUILD_NAME "${ci_mr_source} (MR ${ci_mr_iid})")
  set(ci_profile mr)
elseif(ci_ref_name)
  set (CTEST_BUILD_NAME "${ci_ref_name}")
  if("${ci_ref_name}" STREQUAL "develop")
    set(ci_profile develop)
  elseif("${ci_ref_name}" MATCHES "^release-[0-9]+\\.[0-9]+\$")
    set(ci_profile release)
  endif()
endif()

# set pipelines to enable documentation
set(ci_cookbook_profiles mr develop release)
set(ci_doxygen_profiles mr develop release)
list(FIND ci_cookbook_profiles ${ci_profile} ci_do_cookbook)
list(FIND ci_doxygen_profiles ${ci_profile} ci_do_doxygen)

# Detect site
if(NOT DEFINED IMAGE_NAME)
  if(DEFINED ENV{IMAGE_NAME})
    set(IMAGE_NAME $ENV{IMAGE_NAME})
  endif()
endif()
set (CTEST_SITE "${IMAGE_NAME}")

# Directory variable
set (CTEST_SOURCE_DIRECTORY "${OTB_SOURCE_DIR}")
if(BUILD_DIR)
  set (CTEST_BINARY_DIRECTORY "${BUILD_DIR}")
else()
  set (CTEST_BINARY_DIRECTORY "${OTB_SOURCE_DIR}/build/")
endif()
if(INSTALL_DIR)
  set (CTEST_INSTALL_DIRECTORY "${INSTALL_DIR}")
else()
  set (CTEST_INSTALL_DIRECTORY "${OTB_SOURCE_DIR}/install/")
endif()
set (PROJECT_SOURCE_DIR "${OTB_SOURCE_DIR}")

# Ctest command value
set (CMAKE_COMMAND "cmake")

# Data directory setting
set (OTB_LARGEINPUT_ROOT "") # todo

message(STATUS "CI profile : ${ci_profile}")

#The following file set the CONFIGURE_OPTIONS variable
set (ENABLE_DOXYGEN OFF)
set (CONFIGURE_OPTIONS  "")
include ( "${CMAKE_CURRENT_LIST_DIR}/configure_option.cmake" )

# Sources are already checked out : do nothing for update
set(CTEST_GIT_UPDATE_CUSTOM echo No update)

# Look for a GIT command-line client.
find_program(CTEST_GIT_COMMAND NAMES git git.cmd)

# End of configuration


ctest_start (Experimental TRACK Experimental)

ctest_update()

ctest_configure(BUILD "${CTEST_BINARY_DIRECTORY}"
    SOURCE "${OTB_SOURCE_DIR}"
    OPTIONS "${CONFIGURE_OPTIONS}"
    RETURN_VALUE _configure_rv
    CAPTURE_CMAKE_ERROR _configure_error
    )

if ( NOT _configure_rv EQUAL 0 )
  # stop processing here
  ctest_submit()
  message( FATAL_ERROR "An error occurs during ctest_configure.")
endif()

ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}"
            RETURN_VALUE _build_rv
            CAPTURE_CMAKE_ERROR _build_error
            )

if ( NOT _build_rv EQUAL 0 )
  message( SEND_ERROR "An error occurs during ctest_build.")
endif()

ctest_test(PARALLEL_LEVEL 8
           RETURN_VALUE _test_rv
           CAPTURE_CMAKE_ERROR _test_error
           )

if ( NOT _test_rv EQUAL 0 )
  message( SEND_ERROR "An error occurs during ctest_test.")
endif()

ctest_submit()

if(ENABLE_DOXYGEN)
  # compile doxygen
  ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}"
              TARGET Documentation
              RETURN_VALUE _doxy_rv
              CAPTURE_CMAKE_ERROR _doxy_error
              )
endif()
