# At the moment, this only works for Windows using MinGW.

set(pdcurses_root "third-party/pdcurses")
get_filename_component(pdcurses_root "${pdcurses_root}" REALPATH)

set(pdcurses_platform_root "${pdcurses_root}/wincon")
set(pdcurses_makefile "${pdcurses_platform_root}/Makefile")

set(pdcurses_build_dir "pdcurses_build")
set(pdcurses_build_artifact "${pdcurses_build_dir}/pdcurses.a")

add_custom_command(OUTPUT "${pdcurses_build_dir}"
	COMMAND ${CMAKE_COMMAND} -E make_directory "${pdcurses_build_dir}"
)
add_custom_target(pdcurses_lib
	BYPRODUCTS "${pdcurses_build_artifact}"
	COMMAND ${CMAKE_COMMAND} -E env "PDCURSES_SRCDIR=${pdcurses_root}"
	        ${CMAKE_MAKE_PROGRAM} -f "${pdcurses_makefile}"
	DEPENDS "${pdcurses_build_dir}"
	WORKING_DIRECTORY "${pdcurses_build_dir}"
)

add_library(pdcurses STATIC IMPORTED GLOBAL)
add_dependencies(pdcurses pdcurses_lib)
set_target_properties(pdcurses
	PROPERTIES
		IMPORTED_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${pdcurses_build_artifact}"
)
target_include_directories(pdcurses
	INTERFACE
		"${pdcurses_root}"
)
