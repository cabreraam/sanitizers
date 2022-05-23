
# ASAN/LSAN, MSAN
function(add_test_helper target)
  add_executable(${target} ${target}.c)
  add_test(NAME test-${target} COMMAND $<TARGET_FILE:${target}>)
endfunction()

# ASAN/LSAN
add_test_helper(heap_overflow)
add_test_helper(leak)
add_test_helper(no_leak)
add_test_helper(use_after_free)
# MSAN
add_test_helper(tiny_msan)

# TSAN
add_executable(tiny_race tiny_race.c)
target_link_libraries(tiny_race PRIVATE Threads::Threads)
add_test(NAME test-tiny_race COMMAND $<TARGET_FILE:tiny_race>)

# UBSAN (only clang++?)
add_executable(tiny_ubsan tiny_ubsan.cpp)
add_test(NAME test-tiny_ubsan COMMAND $<TARGET_FILE:tiny_ubsan>)
