MATLAB Script for performance characterization of a full-scale horizontal axis MHK turbine (DOE RM1)
====================

This repository includes the MATLAB script and sample of input files for it to calculate 3D AOA, CL and CD along the blade of a full-scale model horizontal axis MHK turbine. This script was specifically developed for performance characterization of the DOE RM1 turbine design, a two-bladed horizontal axis MHK turbine developed by US Department of Energy &amp; US National Labs. The MATLAB script takes it's inputs from RANS simulation of the turbine and report variables to characterize the blade performnace. This general script can be modified for performance characterization of other horizontal axis MHK and/or Wind turbines simulated via other RANS-solver packages (i.e. OPEN FOAM, STAR CCM and etc.)

This script was developed as a part of the Ph.D. dissertation of [Teymour Javaherchi] at [UW-NNMREC] under supervision of professor [Alberto Aliseda].

Steps to run the script
=========

Follow the steps below to run the script:
  - Download all the files into one folder:
  
  ```
  git clone https://github.com/teymourj/scaled-model-MHK.git
  ```
  - Open the source script in MATLAB.
  - ! To run the script with set of new generated inputs, the name of input files need to be matched within the body of the MATLAB script.
  - ! To run the script for a new turbine design and/or new input format the script needs to be modified.
  - Run the code.
  
Publications
===========
The generated data via this script was used in the following [publication]:

```
@CONFERENCE{Javaherchi_METS_2013,
  author = {T. Javaherchi, N. Stelzenmuller and A. Aliseda},
  title = {Experimental and Numerical Analysis of the DOE Reference Model 1
  Horizontal Axis Hydrokinetic Turbine},
  booktitle = {The 1st Marine Energy Technology Symposium},
  year = {April 2013},
}
```

ANSYS FLUENT .cas &amp; .dat files
============
The link to download ANSYS FLUENT .cas &amp; .dat of RANS simulations will be available soon.

License
======
This work is licensed under the MIT license

[Teymour Javaherchi]:http://staff.washington.edu/teymourj/
[UW-NNMREC]:http://depts.washington.edu/nnmrec/
[Alberto Aliseda]:https://www.me.washington.edu/research/faculty/aaliseda/index.html
[publication]:http://www.foroceanenergy.org/wp-content/uploads/2013/07/EXPERIMENTAL-AND-NUMERICAL-ANALYSIS-OF-THE-DOE-REFERENCE-MODEL-1.pdf
