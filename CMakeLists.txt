cmake_minimum_required(VERSION 3.12)

project(box_status)

find_package(Boost 1.78.0 REQUIRED)
# https://stackoverflow.com/a/3917033/12291425
INCLUDE_DIRECTORIES( ${Boost_INCLUDE_DIR} )

if(MSVC)
add_executable(box_status box_status.cpp)
add_executable(power_keep power_keep.cpp)
# 参考：https://stackoverflow.com/a/1655378/12291425
SET_TARGET_PROPERTIES(box_status PROPERTIES LINK_FLAGS 
"/MANIFESTUAC:\"level='requireAdministrator' uiAccess='false'\"")
else()
message(FATAL_ERROR "Not MSVC")
endif()
