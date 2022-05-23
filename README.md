
# Sanitizers


Mini examples to illustrate the use of `Clang` and `GCC` sanitizers


## Run tests with CMake

To run Address Sanitizers examples with `CMake`:  

```bash
$ cd asan
$ mkdir build
$ cd build 
$ cmake ..
$ make -j 
$ ctest
```

To disable configuration with sanitizers modify the step above:

```bash
$ cmake -DENABLE_ASAN=OFF ..
```

To enable other sanitizers (e.g. TSAN):

```bash
$ cmake -DENABLE_TSAN=ON ..
```

To see verbose information modify the step above:

```bash
$ ctest -VV
```

## Run tests with Meson

```bash
$ cd asan
$ mkdir build
$ cd build 
$ meson -Db_sanitize=address ..
$ ninja 
$ ninja test
```


