add_executable(links
	links.cxx
)

target_link_libraries(links
	PRIVATE
		pdcurses
)

include(gtest_register)
gtest_register(links)
