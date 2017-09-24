find_program(GLSLANG_EXE NAMES "glslangValidator")
if (GLSLANG_EXE)
    message(STATUS "Found glslang: ${GLSLANG_EXE}")
else()
    message(FATAL_ERROR "glslang compiler not found. Please install it.")
endif()
set(CMAKE_INCLUDE_CURRENT_DIR ON)
add_custom_target(compile-shaders)
macro(compile_glsl SRC_FILE_PATH GEN_VAR_NAME GEN_FILE_NAME)
    set(OUTPUT_FILE "${CMAKE_CURRENT_BINARY_DIR}/${GEN_FILE_NAME}")
    get_filename_component(SRC_FILE_NAME ${SRC_FILE_PATH} NAME)
    get_filename_component(SHADER_DIR ${OUTPUT_FILE} DIRECTORY)
    file(MAKE_DIRECTORY ${SHADER_DIR})
    add_custom_command(OUTPUT ${OUTPUT_FILE}
        COMMAND "${GLSLANG_EXE}" -V "${SRC_FILE_PATH}" --variable-name "${GEN_VAR_NAME}" -o "${OUTPUT_FILE}"
        MAIN_DEPENDENCY "${SRC_FILE_PATH}"
        COMMENT "Compiling GLSL file ${SRC_FILE_NAME}"
        )
    add_custom_target("compile-${SRC_FILE_NAME}" DEPENDS ${OUTPUT_FILE})
    add_dependencies(compile-shaders "compile-${SRC_FILE_NAME}")
endmacro(compile_glsl)
