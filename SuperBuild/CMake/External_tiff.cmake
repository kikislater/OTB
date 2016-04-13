if(NOT __EXTERNAL_TIFF__)
set(__EXTERNAL_TIFF__ 1)

message(STATUS "Setup libtiff...")

if(USE_SYSTEM_TIFF)
  find_package ( TIFF )
  message(STATUS "  Using libtiff system version")
else()
  SETUP_SUPERBUILD(PROJECT TIFF)
  message(STATUS "  Using libtiff SuperBuild version")

  # declare dependencies
  ADDTO_DEPENDENCIES_IF_NOT_SYSTEM(TIFF ZLIB JPEG)

  set(TIFF_SB_CONFIG)
  ADD_SUPERBUILD_CMAKE_VAR(ZLIB_INCLUDE_DIR)
  ADD_SUPERBUILD_CMAKE_VAR(ZLIB_LIBRARY)
  ADD_SUPERBUILD_CMAKE_VAR(JPEG_INCLUDE_DIR)
  ADD_SUPERBUILD_CMAKE_VAR(JPEG_LIBRARY)

  if(MSVC)

    STRING(REGEX REPLACE "/$" "" CMAKE_WIN_INSTALL_PREFIX ${SB_INSTALL_PREFIX})
    STRING(REGEX REPLACE "/" "\\\\" CMAKE_WIN_INSTALL_PREFIX ${CMAKE_WIN_INSTALL_PREFIX})
    configure_file(${CMAKE_SOURCE_DIR}/patches/TIFF/nmake.opt ${CMAKE_BINARY_DIR}/nmake_libtiff_extra.opt)

     ExternalProject_Add(TIFF_build
      PREFIX TIFF
      URL "http://download.osgeo.org/libtiff/tiff-4.0.6.tar.gz"
      URL_MD5 d1d2e940dea0b5ad435f21f03d96dd72
      SOURCE_DIR ${TIFF_SB_SRC}
      BINARY_DIR ${TIFF_SB_SRC}
      INSTALL_DIR ${SB_INSTALL_PREFIX}
      DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
      DEPENDS ${TIFF_DEPENDENCIES}
      PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/nmake_libtiff_extra.opt ${TIFF_SB_SRC}/nmake.opt
      CONFIGURE_COMMAND ""
      BUILD_COMMAND nmake /f ${TIFF_SB_SRC}/Makefile.vc
      INSTALL_COMMAND ${CMAKE_COMMAND} -E copy  ${CMAKE_SOURCE_DIR}/patches/TIFF/CMakeLists.txt
      ${CMAKE_BINARY_DIR}/TIFF/_install
    )

    ExternalProject_Add(TIFF
      PREFIX TIFF/_install
      DOWNLOAD_COMMAND ""
      SOURCE_DIR TIFF/_install
      BINARY_DIR ${TIFF_SB_BUILD_DIR}
      INSTALL_DIR ${SB_INSTALL_PREFIX}
      DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    CMAKE_CACHE_ARGS
      -DCMAKE_INSTALL_PREFIX:STRING=${SB_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE:STRING=Release
      -DTIFF_BUILD_DIR:STRING=${TIFF_SB_SRC}/libtiff
      DEPENDS TIFF_build
      CMAKE_COMMAND
    )

  else()
  ExternalProject_Add(TIFF
    PREFIX TIFF
    URL "http://download.osgeo.org/libtiff/tiff-4.0.6.tar.gz"
    URL_MD5 d1d2e940dea0b5ad435f21f03d96dd72
    SOURCE_DIR ${TIFF_SB_SRC}
    BINARY_DIR ${TIFF_SB_BUILD_DIR}
    INSTALL_DIR ${SB_INSTALL_PREFIX}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    DEPENDS ${TIFF_DEPENDENCIES}
    CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_LIBDIR:PATH=lib
    -DCMAKE_INSTALL_BINDIR:PATH=bin
    -DCMAKE_INSTALL_PREFIX:STRING=${SB_INSTALL_PREFIX}
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_TESTING:BOOL=OFF
    -Djpeg:BOOL=TRUE
    -Dlzma:BOOL=FALSE
    -Djbig:BOOL=FALSE
    -Dzlib:BOOL=TRUE
    -Dpixarlog:BOOL=TRUE
    ${TIFF_SB_CONFIG}
    CMAKE_COMMAND ${SB_CMAKE_COMMAND}
    )
endif()
  set(_SB_TIFF_INCLUDE_DIR ${SB_INSTALL_PREFIX}/include)
  if(WIN32)
    set(_SB_TIFF_LIBRARY ${SB_INSTALL_PREFIX}/lib/libtiff_i.lib)
  elseif(UNIX)
    set(_SB_TIFF_LIBRARY ${SB_INSTALL_PREFIX}/lib/libtiff${CMAKE_SHARED_LIBRARY_SUFFIX})
  endif()

endif()
endif()
