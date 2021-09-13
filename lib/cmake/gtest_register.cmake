include(GoogleTest)

function (gtest_register target)
	target_link_libraries(${target}
		PRIVATE
			gtest_main
	)
	gtest_discover_tests(${target})
endfunction ()
