#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#------------------------------------------------------------------------------
# Generate Doxygen API documentation
#------------------------------------------------------------------------------
find_package(Doxygen)
if(DOXYGEN_FOUND STREQUAL "NO")
  message(STATUS "Doxygen not found. Cannot generate API documentation.")
else()
  configure_file(${CMAKE_CURRENT_LIST_DIR}/Doxyfile.in
    ${PROJECT_BINARY_DIR}/Doxyfile
    @ONLY)
  add_custom_target(doxydoc
    COMMAND ${DOXYGEN_EXECUTABLE} ${PROJECT_BINARY_DIR}/Doxyfile
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT "Generating API documentation"
    VERBATIM)
endif()

#------------------------------------------------------------------------------
# Generate PDF version of documentation
#------------------------------------------------------------------------------
find_package(LATEX COMPONENTS PDFLATEX)
if(LATEX_PDFLATEX_FOUND STREQUAL "NO")
  message(STATUS "PDFLatex not found. Cannot generate PDF.")
else()
  add_custom_target(pdfdoc
    COMMAND make pdf
    COMMAND ${CMAKE_COMMAND} -E make_directory
      ${PROJECT_BINARY_DIR}/doc/userguide 
    COMMAND ${CMAKE_COMMAND} -E copy
      ${PROJECT_BINARY_DIR}/doc/latex/refman.pdf
      ${PROJECT_BINARY_DIR}/doc/userguide/${PROJECT_NAME}_user_guide.pdf
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/doc/latex
    DEPENDS doxydoc
    COMMENT "Generating PDF version of API documentation"
    VERBATIM)
endif()

#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

