# Fix libltdl search path for MacPorts
export LTDL_LIBRARY_PATH="/opt/local/lib"
# Fix chicken scheme compiler/linker paths
export CSC_OPTIONS="-I/opt/local/include -L/opt/local/lib"
