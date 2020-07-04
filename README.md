# Individual-based model for modeling small mammal dispersal

This is a repository for sharing an individual-based model developed for simulating the dispersal patterns of small mammals with specific perceptual range and movement parameters across heterogeneous landscapes. This model was developed in the NetLogo environment. 

![Model interface](https://github.com/LEEClab/small_mammal_dispersal_model/blob/master/Model_figure.jpg)

This repository is organized as it follows.
- [code](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/code): Here you find the main NetLogo code to run the model. 
- [landscapes](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/landscapes): Here you find the landscape files used in the model. 
- [landscapes_GRASS_GISdb](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/landscapes_GRASS_GISdb): Here you find the scripts to export the landscape files from a database of simulated landscapes in GRASS GISS. 

# How to use

- Basic steps to run this model: 
1. Download and install NetLogo 6.0.3. You can find the download and installation procedures for NetLogo [here](http://ccl.northwestern.edu/netlogo/index.shtml). 
2. Download the code file. 
3. Create a folder with the landscape layers.
Obs: you can download the [landscapes folder](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/landscapes) in this Github, which contain 100 simulated landscapes, or you can use your own landscapes and export the needed ASCII layers files using the scripts in the [landscapes_GRASS_GISdb](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/landscapes_GRASS_GISdb). If you use your own landscapes, please note the codes of the landscape elements should be the same as the ones used here. Please see the [description of the landscape layers](https://github.com/LEEClab/small_mammal_dispersal_model/tree/master/landscapes) for more information.
4. You should install the [gis](https://github.com/NetLogo/GIS-Extension) and [pathdir](https://github.com/cstaelin/Pathdir-Extension/releases/tag/3.1.0) extensions. [Here](http://ccl.northwestern.edu/netlogo/docs/extensions.html) and [here](https://github.com/NetLogo/NetLogo/wiki/Extensions) you can see more information about how install these extensions. 
5. Open the code file within NetLogo environment. 

*Within NetLogo:*

6. In the code tab, you should check where to define the directory to import landscape files and the directory to save the output. 
7. In the interface tab, you should set all the parameters. Information about each parameter is availabe in the info tab. 

Then, you should be able to run the model. 

# Authors

Érika Garcez da Rocha, Edgardo Brigatti, Bernardo Brandão Niebuhr, Milton Cezar Ribeiro and Marcus Vinícius Vieira

# Citation

If you are going to use and cite this model in your study or report, please refer to:

Rocha, EG; Brigatti, E; Niebuhr, BB; Ribeiro, MC; Vieira, MV. Dispersal movement through disturbed landscapes: the role of stepping stones and perceptual range. Under review. 

If you have trouble running the model or any suggestion, please open an [issue](https://github.com/LEEClab/small_mammal_dispersal_model/issues) or send an email to erika.garcez.rocha@gmail.com. 

