cmake_minimum_required(VERSION 3.20)
project(BiosMenu)

set(CMAKE_CXX_STANDARD 17)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/lib/cmake")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")

include(CTest)

if (WIN32)
	if (MINGW)
		string(APPEND CMAKE_CXX_STANDARD_LIBRARIES
			" -static-libgcc"
			" -static-libstdc++"
		)
		string(APPEND CMAKE_EXE_LINKER_FLAGS
			" -Wl,-Bstatic"
			" -Wl,--whole-archive,-lwinpthread,--no-whole-archive"
		)
		#message("${CMAKE_CXX_STANDARD_LIBRARIES}\n${CMAKE_EXE_LINKER_FLAGS}\n")
	endif ()
endif ()

add_subdirectory(lib)
add_subdirectory(test)

add_executable(menu
	main.cxx
)
target_link_libraries(menu
	PRIVATE
		pdcurses
)
