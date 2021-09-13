#include <gtest/gtest.h>

#include <curses.h>

TEST(Links, pdcurses) {
	ASSERT_EQ(stdscr, initscr());
	ASSERT_EQ(OK, endwin());
}
