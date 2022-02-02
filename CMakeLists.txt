cmake_minimum_required(VERSION 3.12)

project(get_box_status)

if(MSVC)
add_executable(get_box_status get_box_status.cpp)
SET_TARGET_PROPERTIES(get_box_status PROPERTIES LINK_FLAGS 
"/MANIFESTUAC:\"level='requireAdministrator' uiAccess='false'\"")
else()
message(FATAL_ERROR "Not MSVC")
endif()
