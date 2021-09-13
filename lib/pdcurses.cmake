set(pdcurses_root "third-party/pdcurses")
get_filename_component(pdcurses_root "${pdcurses_root}" REALPATH)

if (WIN32)
	if (MINGW)
		set(pdcurses_platform_root "${pdcurses_root}/wincon")
		set(pdcurses_makefile "${pdcurses_platform_root}/Makefile")
	endif ()
endif ()
if (NOT DEFINED pdcurses_makefile)
	message(FATAL_ERROR "PDCurses makefile not specified for current system/compiler.")
endif ()

set(pdcurses_build_dir "pdcurses_build")
set(pdcurses_build_artifact "${pdcurses_build_dir}/pdcurses.a")

add_custom_command(OUTPUT "${pdcurses_build_dir}"
	COMMAND ${CMAKE_COMMAND} -E make_directory "${pdcurses_build_dir}"
)
add_custom_target(pdcurses_lib
	COMMAND ${CMAKE_COMMAND} -E env "PDCURSES_SRCDIR=${pdcurses_root}"
	        ${CMAKE_MAKE_PROGRAM} -f "${pdcurses_makefile}"
	BYPRODUCTS "${pdcurses_build_artifact}"
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
