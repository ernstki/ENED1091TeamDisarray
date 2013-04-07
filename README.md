TEAM DISARRAY'S ENED1091 FINAL PROJECT
========================================

A repository for Team Disarray's 13SS\_ENED091 group project: an animated demonstration of various sort algorithms implemented using a MATLAB GUI.

References
----------
1. [Animations and pseudo-code](http://www.sorting-algorithms.com) for common sorting algorithms [[sorting-algorithms.com](sorting-algorithms.com)]
2. "[Sorting Out Sorting](http://youtu.be/SJwEwA5gOkM)" (video) by the Computer Systems Research Group, U. of Toronto (1981)

Planned Features
----------------
* Visualization of each iteration of at least 3 different CS I-level sort algorithms (planned bubble, selection, quick) using bar plots and array contents (for small values of n).
  * Drill-down menus for under-the-hood tweaks for several algorithms (<em>e.g.</em>, quick sort with different methods for choosing a pivot; 3-way merge sort)
* Timed head-to-head race of up to three algorithms, with results in a bar plot format.


Feature Wish List
-----------------
* Compare built-in MATLAB sort routine to the ones implemented as .m scripts
* Compare our sort algorithms to one implemented in C (MEX interface) - _see the '[qsort-mex](https://github.com/ernstki/ENED1091TeamDisarray/tree/master/qsort-mex)' folder in the master repo_
* Benchmarking - record system information and allow upload/comparison of results from different machines/architectures for a standard suite of sort performance tests.
