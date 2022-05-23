
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

if(ENABLE_ASAN)
  set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS}
      "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer")
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}
      "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer")

elseif(ENABLE_TSAN)
  set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-fsanitize=thread")
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-fsanitize=thread")

elseif(ENABLE_UBSAN)
  # Important -fno-sanitize-recover=all to error out
  set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-fsanitize=undefined -fno-sanitize-recover=all")
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-fsanitize=undefined -fno-sanitize-recover=all")

elseif(ENABLE_MSAN)
  if (CMAKE_CXX_COMPILER_ID NOT STREQUAL "Clang")
    message(FATAL_ERROR "-ENABLE_MSAN=ON is only supported by Clang compilers. Use CC=clang cmake -DENABLE_MSAN=ON ..")
  endif()
  set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-fsanitize=memory -fno-omit-frame-pointer")
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-fsanitize=memory -fno-omit-frame-pointer")
endif()

enable_testing()
add_subdirectory(tests)
