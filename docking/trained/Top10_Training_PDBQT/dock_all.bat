@echo off

if not exist results mkdir results

for %%f in (*.pdbqt) do (
    if not "%%~nxf"=="itk_receptor.pdbqt" (
        vina.exe ^
        --config config.txt ^
        --ligand "%%f" ^
        --out "results\%%~nf_out.pdbqt"
    )
)

pause