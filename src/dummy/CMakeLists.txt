set(HEADER_LIST "${PROJECT_SOURCE_DIR}/include/dummy/dummy.h")

# Make an automatic library - will be static or dynamic based on user setting
add_library(dummy_lib dummy.cpp ${HEADER_LIST})

# We need this directory, and users of our library will need it too
target_include_directories(dummy_lib PUBLIC ../../include)

# All users of this library will need at least C++14
set_target_properties(dummy_lib PROPERTIES CXX_STANDARD 14)

if (NOT MSVC)
target_link_libraries(dummy_lib
    PUBLIC
    "--coverage"
    "$<$<CONFIG:Debug>:-lasan>"
    "$<$<CONFIG:Debug>:-lubsan>"
)
endif(NOT MSVC)