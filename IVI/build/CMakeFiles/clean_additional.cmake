# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appIVI_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appIVI_autogen.dir/ParseCache.txt"
  "appIVI_autogen"
  )
endif()
