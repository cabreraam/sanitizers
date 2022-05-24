
cmake_minimum_required(VERSION 3.16)
project(san-tests VERSION 0.0.1 LANGUAGES C CXX)

# Fail immediately if not using an out-of-source build
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_CURRENT_BINARY_DIR)
  message(FATAL_ERROR
    "In-source builds are not supported.  Please create a build directory "
    "separate from the source directory")
endif()

find_package(Threads REQUIRED)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

option(ENABLE_ASAN  "ENABLE_ASAN" OFF)
option(ENABLE_TSAN  "ENABLE_TSAN" OFF)
option(ENABLE_UBSAN "ENABLE_UBSAN" OFF)
option(ENABLE_MSAN  "ENABLE_MSAN" OFF)

if(ENABLE_ASAN AND ENABLE_TSAN)
  message(FATAL_ERROR "Sanitizers are currently mutually exclusive. Only use one at a time: -ENABLE_ASAN=ON")
endif()

if(${ENABLE_MSAN}) 
	#if(NOT COMPILERS MATCHES "clang")
	if(NOT "${CMAKE_C_COMPILER};${CMAKE_CXX_COMPILER}" MATCHES "clang")
		message(
			FATAL_ERROR 
			"-ENABLE_MSAN=ON is only supported by Clang compilers. Use CC=clang cmake -DENABLE_MSAN=ON .."
		)
	endif()
endif()

set(ASAN_FLAGS
	"-fsanitize=address"
	"-fno-optimize-sibling-calls"
	"-fsanitize-address-use-after-scope"
	"-fno-omit-frame-pointer"
	CACHE
	STRING
	"Compiler flags for adding address sanitizers"
)

set(TSAN_FLAGS 
	-fsanitize=thread 
	CACHE 
	STRING 
	"Compiler flags for adding thread sanitizers"
)

set(UBSAN_FLAGS 
	-fsanitize=undefined 
	-fno-sanitize-recover=all
	CACHE 
	STRING 
	"Compiler flags for undefined behavior sanitizers"
)

set(MSAN_FLAGS 
	-fsanitize=memory
	-fno-omit-frame-pointer
	CACHE 
	STRING 
	"Compiler flags for memory sanitizers"
)

add_compile_options(
	"$<$<BOOL:${ENABLE_ASAN}>:${ASAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_TSAN}>:${TSAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_UBSAN}>:${UBSAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_MSAN}>:${MSAN_FLAGS}>"
)
add_link_options(
	"$<$<BOOL:${ENABLE_ASAN}>:${ASAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_TSAN}>:${TSAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_UBSAN}>:${UBSAN_FLAGS}>"
	"$<$<BOOL:${ENABLE_MSAN}>:${MSAN_FLAGS}>"
)

enable_testing()
add_subdirectory(tests)

