if( NOT TARGET Cinder-Cairo )
	
  get_filename_component( CINDER_CAIRO_INCLUDE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../include" ABSOLUTE )
  get_filename_component( CINDER_CAIRO_SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../src" ABSOLUTE )

	list( APPEND CINDER_CAIRO_SOURCES ${CINDER_CAIRO_SOURCE_PATH}/Cairo.cpp )

	add_library( Cinder-Cairo ${CINDER_CAIRO_SOURCES} )

  if( NOT TARGET cinder )
  	include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
 		find_package( cinder REQUIRED PATHS
 		 	"${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
  		"$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
  endif()

	target_include_directories( Cinder-Cairo PUBLIC 
		${CINDER_CAIRO_INCLUDE_PATH}/${CINDER_TARGET_LOWER}/cairo 
		${CINDER_CAIRO_INCLUDE_PATH}/cinder/cairo 
		${CINDER_CAIRO_INCLUDE_PATH} 
    /usr/include/cairo
	)
  target_include_directories( Cinder-Cairo PRIVATE BEFORE "${CINDER_PATH}/include" )

  find_library(CAIRO_LIBS cairo)
  find_library(PIXMAN_LIBS pixman-1)
  find_library(PNG_LIBS png)
	target_link_libraries( Cinder-Cairo 
    PUBLIC ${CAIRO_LIBS} ${PIXMAN_LIBS} ${PNG_LIBS}
    PRIVATE cinder
	)
endif()
