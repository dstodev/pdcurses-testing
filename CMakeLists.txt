cmake_minimum_required(VERSION 3.20)
project(BiosMenu)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(lib)

add_executable(menu
	main.cpp
)
target_link_libraries(menu
	PRIVATE
		pdcurses
)
