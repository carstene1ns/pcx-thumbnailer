cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project("PCX Thumbnailer" VERSION 0.1.0 LANGUAGES NONE)

find_package(ImageMagick 7 COMPONENTS convert REQUIRED)

install(PROGRAMS main.sh RENAME pcx-thumbnailer
	DESTINATION bin)
install(FILES pcx.thumbnailer
	DESTINATION share/thumbnailers)
