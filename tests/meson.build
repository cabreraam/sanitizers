

# ASAN/LSAN
tests = [ 'heap_overflow', 'leak', 'no_leak', 'use_after_free' ]

foreach test : tests
  test_name = 'test-' + test
  source = meson.current_source_dir() / test + '.c'
  exe = executable(test_name, source)
  test(test_name, exe, timeout: 10, suite:['asan'])
endforeach

# TSAN
thread_dep = dependency('threads')
source = meson.current_source_dir() / 'tiny_race.c'
exe = executable('test-tiny_race', source, dependencies: thread_dep)
test('test-tiny_race', exe, timeout: 10, suite:['tsan'])

# UBSAN 
source = meson.current_source_dir() / 'tiny_ubsan.cpp'
exe = executable('test-tiny_ubsan', source)
test('test-tiny_ubsan', exe, timeout: 10, suite:['ubsan'])

# MSAN
source = meson.current_source_dir() / 'tiny_msan.c'
exe = executable('test-tiny_msan', source)
test('test-tiny_msan', exe, timeout: 10, suite:['msan'])
