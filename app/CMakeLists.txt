add_executable(admp_app "main.cpp")

# All users of this library will need at least C++14
set_target_properties(admp_app PROPERTIES CXX_STANDARD 14)

target_link_libraries(admp_app
    PUBLIC
    "--coverage"
    "$<$<CONFIG:Debug>:-lasan>"
    "$<$<CONFIG:Debug>:-lubsan>"
)