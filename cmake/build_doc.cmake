#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#------------------------------------------------------------------------------
# Generate Doxygen API documentation
#------------------------------------------------------------------------------

find_package(Doxygen)
if(DOXYGEN_FOUND STREQUAL "NO")
  message(STATUS "Doxygen not found. Cannot generate API documentation.")
else()
  configure_file(${CMAKE_CURRENT_LIST_DIR}/doc/Doxyfile.in
    ${PROJECT_BINARY_DIR}/Doxyfile
    @ONLY)

  add_custom_target(doxydoc ALL
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

  add_custom_target(pdfdoc ALL
    COMMAND make pdf
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/doc/latex
    DEPENDS doxydoc
    COMMENT "Generating PDF version of API documentation"
    VERBATIM)

  install(FILES ${PROJECT_BINARY_DIR}/doc/latex/refman.pdf
    RENAME ${PROJECT_NAME}-v${PROJECT_VERSION}.pdf
    DESTINATION doc)

endif()

#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

