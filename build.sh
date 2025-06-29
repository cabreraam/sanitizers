#!/usr/bin/env bash

# Author: Anthony Cabrera
# Contact: cabreraam AT ieee DOT org
# Description: This is a quick build script to test the different build
# configurations for the ORNL sanitizers demo from William Godoy

# $1 = build_dir
# $2 = enable_option
# $3 = c compiler
# $4 = cxx compiler
function make_and_build ()
{
  BUILD_DIR="build/${1}"
	cmake -GNinja -B./${BUILD_DIR} -S. -D${2}=ON -DCMAKE_C_COMPILER=${3} -DCMAKE_CXX_COMPILER=${4} ..
	cmake --build ${BUILD_DIR} 
  pushd ./${BUILD_DIR}
	ctest 
  popd
}

# gcc
######make_and_build build_gcc_asan ENABLE_ASAN gcc g++
######make_and_build build_gcc_tsan ENABLE_TSAN gcc g++
######make_and_build build_gcc_ubsan ENABLE_UBSAN gcc g++
######make_and_build build_gcc_msan ENABLE_MSAN gcc g++
#
## clang
make_and_build build_clang_asan ENABLE_ASAN clang clang++
make_and_build build_clang_tsan ENABLE_TSAN clang clang++
make_and_build build_clang_ubsan ENABLE_UBSAN clang clang++
make_and_build build_clang_msan ENABLE_MSAN clang clang++
