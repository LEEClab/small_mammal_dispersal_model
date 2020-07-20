# Landscapes 

This folder contains all the simulated landscape files used on this model. These landscapes are composed of four elements: habitat patches (> 5 hectares), small patches used as stepping stones (< 5 hectares), scattered trees used as stepping stones (< 20m2 - 2 cells), and a matrix composed of pasture. Besides the maps with the landscape elements, we also use maps of distance from these landscape elements and the identification of each lansdcape element. The maps are described below.
 
-  Layer files with the landscape elements. We generated four different landscape scenarios, as follows:  
    - Only habitat patches - Exported_ascii_MS_HABMAT_PATCHES_ONLY
    - Habitat patches and Stepping stones - Exported_ascii_MS_HABMAT_NO_TREES
    - Habitat patches and Scattered trees - Exported_ascii_MS_HABMAT_NO_SS
    - Habitat patches, Stepping stones, and Scattered trees - Exported_ascii_MS_HABMAT_ALL_TREES_2P_SS_5HA_PATCH
- Layer files with the distance of each pixel of the matrix to the nearest landscape element (habitat patches, small patches and scattered trees):  
    - Distance from Habitat patches - Exported_ascii_MS_HABMAT_PATCHES_ONLY_DIST
    - Distance from Stepping stones - Exported_ascii_MS_HABMAT_SS_5HA_DIST
    - Distance from Scattered trees - Exported_ascii_MS_HABMAT_2PIX_TREES_DIST
- Layer files of identification (ID) of all landscape elements (habitat patches, small patches and scattered trees): 
    - ID of Habitat patches - Exported_ascii_MS_HABMAT_PATCHES_ONLY_PID
    - ID of Stepping stones - Exported_ascii_MS_HABMAT_SS_5HA_PID 
    - ID of Scattered trees - Exported_ascii_MS_HABMAT_2PIX_TREES_PID
    
## Using your own landscapes

In the code, each landscape elements has a unique value for the state variable called cover, which qualify them. The values is defined as following:
- Matrix - cover = 0
- Habitat patches - cover = 1
- Stepping stones - cover = 2
- Scattered trees - cover = 3

Besides the cover variable, each landscape element has an ID value, which refers to a identification of it element. 

In our model, we considered a cell grid of 1024x1024 and each cell size representing 10m² based on the resolution of the landscapes used. Both of this configuration may be edited in the code depending on the landscapes imported. 

