using CircuitscapeUI
using Circuitscape
w = run_ui()
oldpwd = pwd()
cd(CircuitscapeUI.TESTPATH)
Circuitscape.runtests()
cd(oldpwd)
