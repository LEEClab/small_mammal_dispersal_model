#---------------------------------------------------------------------
#
# Script to generate scenarios for BioDIM random landscapes
# 
# Scenario 1: all habitat is considered
# Scenario 2: exclude isolated trees (< 2 pixels) 
#             (only patches and stepping stones)
# Scenario 3: exclude isolated trees and stepping stones (< 6 ha) 
#             (only patches)
# Scenario 4: exclude stepping stones 
#             (only patches and isolated trees)
#
# Bernardo Niebuhr
# 2017-2018
#---------------------------------------------------------------------

#----------------------------------
# Input:
#
# - binary habitat maps
# Binary maps with 1 = habitat and 2 = matrix
# It can also be adapted for 1 = habitat and 0 = matrix
# This map should be loaded in a mapset called MS_HABMAT
# 
# - patch ID maps 
# Maps with a different ID for each habitat patch, to be
# used to calculate patch area and classify the landscape elements
# This map is the result of r.clump in GRASS, but can also be calculated
# using tools like LSMetrics in python-GRASS GIS or the package
# landscapemetrics in R
# This map should be loaded in a mapset called MS_HABMAT_PID
#
# Parameters:
# It is necessary to describe the size, in pixels, of the landscape 
# elements (scattered trees, stepping stones, patches)
#
# Output:
# The script will create different mapsets, for each of the scenarios,
# and create the maps for these scenarios (and the ID of the landscape
# elements) within them. 
# Another script is available for exporting these maps from GRASS GIS.
#----------------------------------

#----------------------------------
# OBS:
# This script needs the GRASS add-on r.area to run
# Before running the script, please make sure to install r.area
#
# In the GRASS prompt, you can type (with internet connection):
# g.extension extension=r.area
#----------------------------------

python

# Import modules
import os
import grass.script as grass
import grass.script.raster as r

# Change here the folder where the scripts are!!!
folder_scripts = r'path/to/folder'

# List maps inside a mapset

# Binary class maps - HABITAT/MATRIX
habmat_mapset_name = 'MS_HABMAT'
grass.run_command('g.mapset', mapset = habmat_mapset_name)
habmat_map_list = grass.list_grouped ('rast') [habmat_mapset_name] # list maps inside the mapset

# Patch ID maps
pid_mapset_name = 'MS_HABMAT_PID'
grass.run_command('g.mapset', mapset = pid_mapset_name)
pid_map_list = grass.list_grouped ('rast') [pid_mapset_name] # list maps inside the mapset

# Parameters
# Define here the size of stepping stones and isolated trees
size_tr = 2 # Maximum size in PIXELS of isolated trees (in pixels!!)
size_ss = 5 # Maximum size in HECTARES for stepping stones (in hectares!!)

# Create several new mapsets

# Scenario 1: original - just export it as it is
# Scenario 2: exclude only isolated trees (< 2 pixels in size)
# Scenario 3: exclude both isolated trees and stepping stones
# Scenario 4: exclude only stepping stones (2 pixels < size < 6 ha)

# Mapset with only isolated trees, with size <= 2 pixels (trees are 3, the rest is null)
mapset_name_trees = 'MS_HABMAT_2PIX_TREES'
grass.run_command('g.mapset', mapset = mapset_name_trees, flags = 'c')

# Mapset with only stepping stones, with size > 2 pixels and <= 5 ha (ss are 2, the rest is null)
mapset_name_ss = 'MS_HABMAT_SS_5HA'
grass.run_command('g.mapset', mapset = mapset_name_ss, flags = 'c')

# Scenario 4: Mapset with patches and isolated trees, but no stepping stones
mapset_no_ss = 'MS_HABMAT_NO_SS'
grass.run_command('g.mapset', mapset = mapset_no_ss, flags = 'c')

# Scenario 3: Mapset with only forest patches (no isolated trees or stepping stones) (patches are 1, the rest is 0)
mapset_patch_only = 'MS_HABMAT_PATCHES_ONLY'
grass.run_command('g.mapset', mapset = mapset_patch_only, flags = 'c')

# Scenario 2: Mapset with patches and stepping stones, but no trees
mapset_no_trees = 'MS_HABMAT_NO_TREES'
grass.run_command('g.mapset', mapset = mapset_no_trees, flags = 'c')

# Scenario 1: Mapset with all (patches, ss, and trees)
mapset_all = 'MS_HABMAT_ALL_TREES_2P_SS_5HA_PATCH'
grass.run_command('g.mapset', mapset = mapset_all, flags = 'c')

# Mapset with isolated trees ID
mapset_tree_pid = 'MS_HABMAT_2PIX_TREES_PID'
grass.run_command('g.mapset', mapset = mapset_tree_pid, flags = 'c')

# Mapset with stepping stone ID
mapset_ss_pid = 'MS_HABMAT_SS_5HA_PID'
grass.run_command('g.mapset', mapset = mapset_ss_pid, flags = 'c')

# Mapset with patch(>5ha) ID
mapset_patch_only_PID = 'MS_HABMAT_PATCHES_ONLY_PID'
grass.run_command('g.mapset', mapset = mapset_patch_only_PID, flags = 'c')

# Change to the folder where the script is
os.chdir(folder_scripts)

# For each map, generate 3 scenarios
for i in range(len(habmat_map_list)):
    
    # Name of the habitat(1)/matrix(2) map
    habmat_map_name = habmat_map_list[i]
    # Name of the initial Patch ID map (considering all patches, ss, and trees)
    pid_map_name = pid_map_list[i]
    
    # Resolution of maps
    map_info = r.raster_info(habmat_map_name+'@'+habmat_mapset_name)  
    pixel_area = float(map_info['ewres'])*float(map_info['nsres']) # in m2
    
    #------------------------
    # Map of trees
    grass.run_command('g.mapset', mapset = mapset_name_trees)
    
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p')       
    
    # Map of patch size in number of cells
    grass.run_command('r.area', input = pid_map_name+'@'+pid_mapset_name, output = habmat_map_name+'_patch_size_cells', overwrite = True)
    
    # Map of isolated trees (3 = trees, null in the rest)  
    expression1 = habmat_map_name+'_trees_'+str(size_tr)+'pix = if('+habmat_map_name+'_patch_size_cells <= '+str(size_tr)+' &&& '+habmat_map_name+'_patch_size_cells > 0, 3, null())'
    print expression1
    grass.mapcalc(expression1, overwrite = True)
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_trees_'+str(size_tr)+'pix', rules = 'colors_pattern.txt')
    
    #------------------------
    # Map of stepping stones
    grass.run_command('g.mapset', mapset = mapset_name_ss)    
        
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p')      
    
    # Map of stepping stones (2 = stepping stones, null in the rest)
    size_ss_cells = int(size_ss * 10000 / pixel_area)
    expression2 = habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix = if('+habmat_map_name+'_patch_size_cells@'+mapset_name_trees+' > '+str(size_tr)+' &&& '+habmat_map_name+'_patch_size_cells@'+mapset_name_trees+' <= '+str(size_ss_cells)+', 2, null())'
    print expression2
    grass.mapcalc(expression2, overwrite = True)
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix', rules = 'colors_pattern.txt')
    
    #------------------------
    # Map of patches only
    grass.run_command('g.mapset', mapset = mapset_patch_only)
    
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p') 
    
    # Map of fragments (patches are 1, the rest is 0)
    expression3 = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix = if('+habmat_map_name+'_patch_size_cells@'+mapset_name_trees+' > '+str(size_ss_cells)+', 1, 0)'
    print expression3
    grass.mapcalc(expression3, overwrite = True)
    
    # Set null cells as zero
    grass.run_command('r.null', map = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix', null = 0)
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix', rules = 'colors_pattern.txt')
    
    #------------------------
    # Map of all
    grass.run_command('g.mapset', mapset = mapset_all)
        
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p') 
    
    # Map of fragments
    maps = [habmat_map_name+'_trees_'+str(size_tr)+'pix@'+mapset_name_trees, 
            habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix@'+mapset_name_ss,
            habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix@'+mapset_patch_only]
    grass.run_command('r.patch', input = maps, output = habmat_map_name+'_all', overwrite = True)
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_all', rules = 'colors_pattern.txt')
    
    #------------------------
    # Map removing trees
    grass.run_command('g.mapset', mapset = mapset_no_trees)
            
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p') 
        
    # Map of fragments
    maps = [habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix@'+mapset_name_ss,
            habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix@'+mapset_patch_only]
    grass.run_command('r.patch', input = maps, output = habmat_map_name+'_no_trees', overwrite = True)  
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_no_trees', rules = 'colors_pattern.txt')
    
    #------------------------
    # Map removing stepping stones
    grass.run_command('g.mapset', mapset = mapset_no_ss)
    
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p') 
        
    # Map of fragments
    maps = [habmat_map_name+'_trees_'+str(size_tr)+'pix@'+mapset_name_trees, 
            habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix@'+mapset_patch_only]
    grass.run_command('r.patch', input = maps, output = habmat_map_name+'_no_ss', overwrite = True)  
    
    # Set colors
    grass.run_command('r.colors', map = habmat_map_name+'_no_ss', rules = 'colors_pattern.txt')    
        
    #------------------------
    # Removing temp map of patch size in pixels
    grass.run_command('g.mapset', mapset = mapset_name_trees)
            
    # Map of patch size in number of cells
    grass.run_command('g.remove', type = 'raster', pattern = habmat_map_name+'_patch_size_cells', flags = 'f')    
    
    #------------------------
    # Map of tree PID
    grass.run_command('g.mapset', mapset = mapset_tree_pid)
        
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p')       
        
    # Clump of isolated trees
    grass.run_command('r.clump', input = habmat_map_name+'_trees_'+str(size_tr)+'pix@'+mapset_name_trees, output = habmat_map_name+'_trees_'+str(size_tr)+'pix_pid', overwrite = True, flags = 'd')
            
    #------------------------
    # Map of stepping stone PID
    grass.run_command('g.mapset', mapset = mapset_ss_pid)    
            
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p')
        
    # Clump of stepping stones
    grass.run_command('r.clump', input = habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix@'+mapset_name_ss, output = habmat_map_name+'_ss_'+str(size_tr)+'_to_'+str(size_ss_cells)+'pix_pid', overwrite = True, flags = 'd')    
        
    #------------------------
    # Map of patches (>5ha) PID
    grass.run_command('g.mapset', mapset = mapset_patch_only_PID)
        
    # Defining the GRASS GIS region as the map extension
    grass.run_command('g.region', raster = habmat_map_name+'@'+habmat_mapset_name, flags = '') #'p') 
        
    # Transforms map of patches only in 1/null
    expression4 = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix_1null = if('+habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix@'+mapset_patch_only+' == 1, 1, null())'
    grass.mapcalc(expression4, overwrite = True)
        
    # Clump of stepping stones
    grass.run_command('r.clump', input = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix_1null', output = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix_pid', overwrite = True, flags = 'd')
            
    # Remove temp map
    grass.run_command('g.remove', type = 'raster', pattern = habmat_map_name+'_patch_more_'+str(size_ss_cells)+'pix_1null', flags = 'f')            
    
