file(GLOB optimizer_main_src
        "*.cpp"
        )
file(GLOB optimizer_lib_src
        "*/*.cpp"
        )

add_library(optimizer SHARED ${optimizer_main_src} ${optimizer_lib_src} ValuePropagation/GlobalConstantVariablePropagation.h ValuePropagation/GlobalConstantVariablePropagation.cpp)
target_link_libraries(optimizer Model)