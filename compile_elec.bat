@echo off
echo Starting complete LaTeX compilation for Electronic Version (Single-Sided)...

echo.
echo Step 1: First XeLaTeX compilation...
xelatex -interaction=nonstopmode bjtu_template_elec.tex
rem Check if PDF was generated successfully
if not exist bjtu_template_elec.pdf (
    echo Error in first XeLaTeX compilation - PDF not generated
    pause
    exit /b 1
)

echo.
echo Step 2: BibTeX compilation for bibliography...
bibtex bjtu_template_elec
if %errorlevel% neq 0 (
    echo Error in BibTeX compilation
    pause
    exit /b 1
)

echo.
echo Step 3: Second XeLaTeX compilation for cross-references...
xelatex -interaction=nonstopmode bjtu_template_elec.tex
rem Check if PDF still exists after second compilation
if not exist bjtu_template_elec.pdf (
    echo Error in second XeLaTeX compilation - PDF not found
    pause
    exit /b 1
)

echo.
echo Step 4: Final XeLaTeX compilation for table of contents...
xelatex -interaction=nonstopmode bjtu_template_elec.tex
rem Check if PDF still exists after final compilation
if not exist bjtu_template_elec.pdf (
    echo Error in final XeLaTeX compilation - PDF not found
    pause
    exit /b 1
)

echo.
echo Compilation completed successfully!
echo Generated files:
if exist bjtu_template_elec.pdf (
    echo - bjtu_template_elec.pdf ^(final electronic document^)
)

echo.
echo Opening PDF file...
if exist bjtu_template_elec.pdf (
    start bjtu_template_elec.pdf
) else (
    echo PDF file not found!
)

pause