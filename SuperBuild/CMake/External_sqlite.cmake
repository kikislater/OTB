if(NOT __EXTERNAL_SQLITE__)
set(__EXTERNAL_SQLITE__ 1)

message(STATUS "Setup SQLite...")

if(USE_SYSTEM_SQLITE)
  # TODO
  #find_package ( SQLite )
  add_custom_target(SQLITE)
  message(STATUS "  Using SQLite system version")
else()
  SETUP_SUPERBUILD(PROJECT SQLITE)
  message(STATUS "  Using SQLite SuperBuild version")

  ExternalProject_Add(SQLITE
    PREFIX SQLITE
    URL "http://www.sqlite.org/2015/sqlite-amalgamation-3080801.zip"
    URL_MD5 b1cbcbd710bdfd762dc169f1676053b5
    SOURCE_DIR ${SQLITE_SB_SRC}
    BINARY_DIR ${SQLITE_SB_BUILD_DIR}
    INSTALL_DIR ${SB_INSTALL_PREFIX}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/patches/SQLITE ${SQLITE_SB_SRC}
    CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:STRING=${SB_INSTALL_PREFIX}
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DBUILD_SHARED_LIBS:BOOL=ON
    CMAKE_COMMAND ${SB_CMAKE_COMMAND}
    )

  set(_SB_SQLITE_INCLUDE_DIR ${SB_INSTALL_PREFIX}/include)
  if(WIN32)
    set(_SB_SQLITE_LIBRARY ${SB_INSTALL_PREFIX}/lib/sqlite3.lib)
  elseif(UNIX)
    set(_SB_SQLITE_LIBRARY ${SB_INSTALL_PREFIX}/lib/libsqlite3${CMAKE_SHARED_LIBRARY_SUFFIX})
  endif()

endif()
endif()
