Visual Search of an Image Collection
====================================
[Use README.md if you want better readability]

This document helps you use the code built for this course work. After unzipping the package, ensure you have the following files.

.
├── README.md
├── README.txt
|── data
|   <All data files and ground truth goes here>
├── bag_of_visual_words.m
├── cvpr_compare.m
├── cvpr_computedescriptors.m
├── cvpr_visualsearch.m
├── descriptors
│   ├── edge_orientation_and_color_descriptor.m
│   ├── edge_orientation_descriptor.m
│   ├── feature_descriptor.m
│   ├── grid_based_image_descriptor.m
│   └── rgb_hist_descriptor.m
├── detectors
│   └── harris_corner_detector.m
├── extractRandom.m
├── inference
│   ├── distances
│   │   ├── l1_norm.m
│   │   ├── l2_norm.m
│   │   ├── mahalanobis.m
│   │   └── minkowski.m
│   └── evaluation
│       ├── calculate_average_precision.m
│       └── calculate_mean_average_precision.m
├── output
├── pca
│   ├── Eigen_Build.m
│   ├── Eigen_Deflate.m
│   ├── Eigen_Mahalanobis.m
│   ├── Eigen_PCA.m
│   ├── Eigen_Plot2D.m
│   ├── Eigen_Project.m
│   └── Eigen_Test.m
└── utils
    ├── display_pr_curve.m
    ├── format_flatten_pixels.m
    ├── imgshow.m
    ├── imgshowgrid.m
    ├── imgshowkeypoint.m
    └── monochrome.m

Note that you might have to add this folder to your Matlab's source code path. Also, the "pca" folder you see above is from the lab excersices.
You may want to use those methods, in which case make sure you get rid of these files as it may cause conflicts.

Descriptors built
-----------------
* Global Colour Histogram (rgb_hist_descriptor.m)
* Grid Based Colour Descriptor (grid_based_image_descriptor.m)
* Grid Based Edge Orientation Descriptor (edge_orientation_descriptor.m)
* Grid based Colour and Edge Orientation Descriptor (edge_orientation_and_color_descriptor.m)

Bag of Visual Words
-------------------
* Process to run the bag of visual words technique (bag_of_visual_words.m) using Harris Corner Detector

Distance Measures
-----------------
* L1 Norm (l1_norm.m)
* L2 Norm (l2_norm.m)
* Mahalanobis Distance (mahalanobis.m)
* Minkowski Distance (minkowski.m)

task 0) Default settings
-------------------
* Make sure the root folder and all sub folders are included in Matlab's path of executable files
* update the paths in DATASET_FOLDER (cvpr_computedescriptors.m : line 18) and OUT_FOLDER (cvpr_computedescriptors.m : line 21) as you see fit. 
The current locations are left to my working directory
* update the DATASET_FOLDER (cvpr_visualsearch.m : line 24) and DESCRIPTOR_FOLDER variable (cvpr_visualsearch.m : Line 27) as you see fit


task 1) How to run Global Colour Histogram?
--------------------------------------

Step 1: Create descriptors
..........................

* Perform task 0
* Change the OUT_SUBFOLDER (cvpr_computedescriptors.m : line 25) to 'rgb_hist_descriptor'. so it should not look like this:
(cvpr_computedescriptors.m : line 25) -> OUT_SUBFOLDER = 'rgb_hist_descriptor';
* Update (cvpr_computedescriptors.m : line 45) to use 'rgb_hist_descriptor' descriptor. You can find all API docs in the header section of the rgb_hist_descriptor.m file
(cvpr_computedescriptors.m : line 45) -> res = rgb_hist_descriptor(img, 4);
In the above command the second argument "4" is the quantisation factor and this hyper parameter can be updated as needed.
Check the API docs in the header of the descriptor file for more info
* run the following command in the Matlab's command line
Command line ->>   cvpr_computedescriptors
* All values will be persisted to ${OUT_FOLDER}/${OUT_SUBFOLDER}

Step 2: Run Query
.................

* Ensure task 0 is performed
* Change DESCRIPTOR_SUBFOLDER (cvpr_visualsearch.m : line 30) to 'rgb_hist_descriptor'. This the sub folder where all the descriptors are stored
DESCRIPTOR_SUBFOLDER='rgb_hist_descriptor';
* [OPTIONAL] Choose if you want to run PCA or not by setting PCA.run = true (cvpr_visualsearch.m : line 32). Defaults to false;
* [OPTIONAL] Use PCA.energy (cvpr_visualsearch.m : line 34) to determine what energy should be retained in the over all dimentionality. Defaults to PCA.energy = 0.8;
* [OPTIONAL] if you want to run multiple queries which can then be used to perform MAP. Then set NumberOfQueriesToRun = 100; (cvpr_visualsearch.m : line 36) for running the query 100 times. Defaulted to 1;
* [OPTIONAL] Choose which distance measure to use (cvpr_visualsearch.m : line 94). All distance measure API info is available in the respective files header section. Defaults to l2_norm;
(cvpr_visualsearch.m : line 94) -> thedst=l2_norm(query,candidate);
if PCA is enabled then Mahalanobis distance is calculated by default.
* run the following command in the Matlab's command line
Command line ->>  cvpr_computedescriptors
* All Average precision values for every query will be persisted to ${OUT_FOLDER}/${DESCRIPTOR_SUBFOLDER}/evaluation. This will be used to calculate MAP in the next step.
* Uncomment line number 113 or 114 in cvpr_visualsearch.m to view the search results visually

Step 3: Calculate MAP
.....................

* If step 1 and step 2 are performed. Go ahead and calculate the MAP by running the following command
Command line ->>  calculate_mean_average_precision(strcat(DESCRIPTOR_FOLDER, '/', DESCRIPTOR_SUBFOLDER))
This will give you the MAP for all the queries you have ran so far.

task 2) How to run Grid Based Colour Descriptor?
------------------------------------------------

Step 1: Create descriptors
..........................

* Perform task 0
* Change the OUT_SUBFOLDER (cvpr_computedescriptors.m : line 25) to 'grid_based_image_descriptor'. so it should not look like this:
(cvpr_computedescriptors.m : line 25) -> OUT_SUBFOLDER = 'grid_based_image_descriptor';
* Update (cvpr_computedescriptors.m : line 45) to use 'grid_based_image_descriptor' descriptor. You can find all API docs in the header section of the grid_based_image_descriptor.m file
(cvpr_computedescriptors.m : line 45) -> res = grid_based_image_descriptor(img, 6, 6);
In the above command the second argument and the third argument represent the rows and columns used for gridding.
Check the API docs in the header of the descriptor file for more info
* run the following command in the Matlab's command line
Command line ->>   cvpr_computedescriptors
* All values will be persisted to ${OUT_FOLDER}/${OUT_SUBFOLDER}

Step 2: Run Query
.................

* Ensure task 0 is performed
* Change DESCRIPTOR_SUBFOLDER (cvpr_visualsearch.m : line 30) to 'grid_based_image_descriptor'. This the sub folder where all the descriptors are stored
DESCRIPTOR_SUBFOLDER='grid_based_image_descriptor';
* [OPTIONAL] Choose if you want to run PCA or not by setting PCA.run = true (cvpr_visualsearch.m : line 32). Defaults to false;
* [OPTIONAL] Use PCA.energy (cvpr_visualsearch.m : line 34) to determine what energy should be retained in the over all dimentionality. Defaults to PCA.energy = 0.8;
* [OPTIONAL] if you want to run multiple queries which can then be used to perform MAP. Then set NumberOfQueriesToRun = 100; (cvpr_visualsearch.m : line 36) for running the query 100 times. Defaulted to 1;
* [OPTIONAL] Choose which distance measure to use (cvpr_visualsearch.m : line 94). All distance measure API info is available in the respective files header section. Defaults to l2_norm;
(cvpr_visualsearch.m : line 94) -> thedst=l2_norm(query,candidate);
if PCA is enabled then Mahalanobis distance is calculated by default.
* run the following command in the Matlab's command line
Command line ->>  cvpr_computedescriptors
* All Average precision values for every query will be persisted to ${OUT_FOLDER}/${DESCRIPTOR_SUBFOLDER}/evaluation. This will be used to calculate MAP in the next step.
* Uncomment line number 113 or 114 in cvpr_visualsearch.m to view the search results visually

Step 3: Calculate MAP
.....................

* If step 1 and step 2 are performed. Go ahead and calculate the MAP by running the following command
Command line ->>  calculate_mean_average_precision(strcat(DESCRIPTOR_FOLDER, '/', DESCRIPTOR_SUBFOLDER))
This will give you the MAP for all the queries you have ran so far.

task 3) How to run Grid Based Edge Orientation Descriptor?
----------------------------------------------------------

Step 1: Create descriptors
..........................

* Perform task 0
* Change the OUT_SUBFOLDER (cvpr_computedescriptors.m : line 25) to 'edge_orientation_descriptor'. so it should not look like this:
(cvpr_computedescriptors.m : line 25) -> OUT_SUBFOLDER = 'edge_orientation_descriptor';
* Update (cvpr_computedescriptors.m : line 45) to use 'edge_orientation_descriptor' descriptor. You can find all API docs in the header section of the edge_orientation_descriptor.m file
(cvpr_computedescriptors.m : line 45) -> res = edge_orientation_descriptor(img, 8, 8, 8, 0.1);
In the above command the second argument and the third argument represent the rows and columns used for gridding. Argument 4 is used for angular quantisation and argument 5 is used for magnitude threshold.
Check the API docs in the header of the descriptor file for more info
* run the following command in the Matlab's command line
Command line ->>   cvpr_computedescriptors
* All values will be persisted to ${OUT_FOLDER}/${OUT_SUBFOLDER}

Step 2: Run Query
.................

* Ensure task 0 is performed
* Change DESCRIPTOR_SUBFOLDER (cvpr_visualsearch.m : line 30) to 'edge_orientation_descriptor'. This the sub folder where all the descriptors are stored
DESCRIPTOR_SUBFOLDER='edge_orientation_descriptor';
* [OPTIONAL] Choose if you want to run PCA or not by setting PCA.run = true (cvpr_visualsearch.m : line 32). Defaults to false;
* [OPTIONAL] Use PCA.energy (cvpr_visualsearch.m : line 34) to determine what energy should be retained in the over all dimentionality. Defaults to PCA.energy = 0.8;
* [OPTIONAL] if you want to run multiple queries which can then be used to perform MAP. Then set NumberOfQueriesToRun = 100; (cvpr_visualsearch.m : line 36) for running the query 100 times. Defaulted to 1;
* [OPTIONAL] Choose which distance measure to use (cvpr_visualsearch.m : line 94). All distance measure API info is available in the respective files header section. Defaults to l2_norm;
(cvpr_visualsearch.m : line 94) -> thedst=l2_norm(query,candidate);
if PCA is enabled then Mahalanobis distance is calculated by default.
* run the following command in the Matlab's command line
Command line ->>  cvpr_computedescriptors
* All Average precision values for every query will be persisted to ${OUT_FOLDER}/${DESCRIPTOR_SUBFOLDER}/evaluation. This will be used to calculate MAP in the next step.
* Uncomment line number 113 or 114 in cvpr_visualsearch.m to view the search results visually

Step 3: Calculate MAP
.....................

* If step 1 and step 2 are performed. Go ahead and calculate the MAP by running the following command
Command line ->>  calculate_mean_average_precision(strcat(DESCRIPTOR_FOLDER, '/', DESCRIPTOR_SUBFOLDER))
This will give you the MAP for all the queries you have ran so far.

task 4) How to run Grid based Colour and Edge Orientation Descriptor?
---------------------------------------------------------------------

Step 1: Create descriptors
..........................

* Perform task 0
* Change the OUT_SUBFOLDER (cvpr_computedescriptors.m : line 25) to 'edge_orientation_and_color_descriptor'. so it should not look like this:
(cvpr_computedescriptors.m : line 25) -> OUT_SUBFOLDER = 'edge_orientation_and_color_descriptor';
* Update (cvpr_computedescriptors.m : line 45) to use 'edge_orientation_and_color_descriptor' descriptor. You can find all API docs in the header section of the edge_orientation_and_color_descriptor.m file
(cvpr_computedescriptors.m : line 45) -> res = edge_orientation_and_color_descriptor(img, 8, 8, 8, 0.1);
In the above command the second argument and the third argument represent the rows and columns used for gridding. Argument 4 is used for angular quantisation and argument 5 is used for magnitude threshold.
Check the API docs in the header of the descriptor file for more info
* run the following command in the Matlab's command line
Command line ->>   cvpr_computedescriptors
* All values will be persisted to ${OUT_FOLDER}/${OUT_SUBFOLDER}

Step 2: Run Query
.................

* Ensure task 0 is performed
* Change DESCRIPTOR_SUBFOLDER (cvpr_visualsearch.m : line 30) to 'edge_orientation_and_color_descriptor'. This the sub folder where all the descriptors are stored
DESCRIPTOR_SUBFOLDER='edge_orientation_and_color_descriptor';
* [OPTIONAL] Choose if you want to run PCA or not by setting PCA.run = true (cvpr_visualsearch.m : line 32). Defaults to false;
* [OPTIONAL] Use PCA.energy (cvpr_visualsearch.m : line 34) to determine what energy should be retained in the over all dimentionality. Defaults to PCA.energy = 0.8;
* [OPTIONAL] if you want to run multiple queries which can then be used to perform MAP. Then set NumberOfQueriesToRun = 100; (cvpr_visualsearch.m : line 36) for running the query 100 times. Defaulted to 1;
* [OPTIONAL] Choose which distance measure to use (cvpr_visualsearch.m : line 94). All distance measure API info is available in the respective files header section. Defaults to l2_norm;
(cvpr_visualsearch.m : line 94) -> thedst=l2_norm(query,candidate);
if PCA is enabled then Mahalanobis distance is calculated by default.
* run the following command in the Matlab's command line
Command line ->>  cvpr_computedescriptors
* All Average precision values for every query will be persisted to ${OUT_FOLDER}/${DESCRIPTOR_SUBFOLDER}/evaluation. This will be used to calculate MAP in the next step.
* Uncomment line number 113 or 114 in cvpr_visualsearch.m to view the search results visually

Step 3: Calculate MAP
.....................

* If step 1 and step 2 are performed. Go ahead and calculate the MAP by running the following command
Command line ->>  calculate_mean_average_precision(strcat(DESCRIPTOR_FOLDER, '/', DESCRIPTOR_SUBFOLDER))
This will give you the MAP for all the queries you have ran so far.

task 5) How to run Bag of Visual Words?
---------------------------------------

Step 1: Create descriptors
..........................

* Perform task 0
* run the following command with the first paramter being the location to the data directory and the second to the output directory of the Bag of Visual Words
Command line ->>  bag_of_visual_words('/Users/sanred/Documents/masters/MATLAB/cwork/data', '/Users/sanred/Documents/masters/MATLAB/cwork/output/bovw')
* [OPTIONAL] Change the hyper paramter topn for identifiying the top n key points with the maximum corner strength with local maxima. This can be done in feature_descriptor.m : line 23, argument 2. Defaulted to 200;
* [OPTIONAL] Change the hyper paramter number of clusters for K-Means. This can be done in bag_visual_words.m : line 53. Defaulted to 128;
* [OPTIONAL] Change the hyper paramter local descriptor to be used . This can be done in feature_descriptor.m : line 36. Defaulted to rgb_hist_descriptor; 
You can use rgb_hist_descriptor, grid_based_image_descriptor, edge_orientation_descriptor and edge_orientation_and_color_descriptor with appropriate paramters as described above
* All values will be persisted to OUT_FOLDER specified as the second argument

Step 2: Run Query
.................

* Ensure task 0 is performed
* Change DESCRIPTOR_SUBFOLDER (cvpr_visualsearch.m : line 30) to 'bovw'. This the sub folder where all the descriptors are stored
DESCRIPTOR_SUBFOLDER='bovw';
* [OPTIONAL] Choose if you want to run PCA or not by setting PCA.run = true (cvpr_visualsearch.m : line 32). Defaults to false;
* [OPTIONAL] Use PCA.energy (cvpr_visualsearch.m : line 34) to determine what energy should be retained in the over all dimentionality. Defaults to PCA.energy = 0.8;
* [OPTIONAL] if you want to run multiple queries which can then be used to perform MAP. Then set NumberOfQueriesToRun = 100; (cvpr_visualsearch.m : line 36) for running the query 100 times. Defaulted to 1;
* [OPTIONAL] Choose which distance measure to use (cvpr_visualsearch.m : line 94). All distance measure API info is available in the respective files header section. Defaults to l2_norm;
(cvpr_visualsearch.m : line 94) -> thedst=l2_norm(query,candidate);
if PCA is enabled then Mahalanobis distance is calculated by default.
* run the following command in the Matlab's command line
Command line ->>  cvpr_computedescriptors
* All Average precision values for every query will be persisted to ${OUT_FOLDER}/${DESCRIPTOR_SUBFOLDER}/evaluation. This will be used to calculate MAP in the next step.
* Uncomment line number 113 or 114 in cvpr_visualsearch.m to view the search results visually

Step 3: Calculate MAP
.....................

* If step 1 and step 2 are performed. Go ahead and calculate the MAP by running the following command
Command line ->>  calculate_mean_average_precision(strcat(DESCRIPTOR_FOLDER, '/', DESCRIPTOR_SUBFOLDER))
This will give you the MAP for all the queries you have ran so far.

Notes:
------ 
* Change hyper paramters 
* Any doubts? Please shoot an email to sd01356@surrey.ac.uk
