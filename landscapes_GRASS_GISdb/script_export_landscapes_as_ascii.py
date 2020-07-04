#---------------------------------------------------------------------
#
# Script to export landscape rasters from GRASS GIS as ASCII and
#   change them into the ASCII format from ArcGIS
#
# Bernardo Niebuhr
# Jul 2017
#---------------------------------------------------------------------

#python 

# Import modules
import os
import grass.script as grass

# Output folder (where to save the ASCII maps)
outdir = 'path/to/output_folder'

# Change to output folder
os.chdir(outdir)

# List maps inside a mapset
mapset_name = 'MS_HABMAT_2PIX_TREES' 
#The follow MAPSETS: 
	#MS_HABMAT_PATCHES_ONLY --> only 1
	#MS_HABMAT_SS_5HA --> only 2
	#MS_HABMAT_2PIX_TREES --> only 3
map_list = grass.list_grouped ('rast', pattern = '*edge_dist') [mapset_name]

for rast in map_list:

	# Defining the GRASS GIS region as the map extension
	grass.run_command('g.region', raster = rast)
	
	# Divide map distance per 3 as a temporary map
	rast_d3 = rast+'_div3'
	grass.mapcalc(rast_d3+' = '+rast+' / 3', overwrite = True)

	# Exporting maps from GRASS GIS as ASCII
	grass.run_command('r.out.ascii', input = rast_d3+'@'+mapset_name, output = rast+'.asc', overwrite = True)
	
	# Delete temporary map (and keep only the original one with 30m resolution)
	grass.run_command('g.remove', type = 'raster', name = rast_d3)
	
	# Reading the GRASS ASCII header
	mapa = open(rast+'.asc', 'r') # Open ASCII map
	lines = mapa.readlines() # Read lines of information from ASCII file
	mapa.close() # Close ASCII map
	
	header = lines[0:6] # First 6 lines are the GRASS ASCII header
	map_aux = lines[6:] # The rest of lines are the map information itself - this won't be changed
	
	# Extracting information from the header
	header_list = [i.replace('\n','').split(": ") for i in header]
	
	# Information for the new header
	nrows = header_list[4][1] # Number of rows
	ncols = header_list[5][1] # Number of cols
	xllcorner = header_list[3][1] # x left corner (East)
	yllcorner = header_list[1][1] # y low corner (South)
	cellsize = (int(header_list[0][1]) - int(header_list[1][1]))/int(nrows) # Calculate resolution/cell size
	last_line = 'NODATA_value  -99\n' # the last line of header does not change
	
	# New header
	new_header = []
	# Line 1
	new_header.append('ncols         '+ncols+'\n')
	# Line 2
	new_header.append('nrows         '+nrows+'\n')
	# Line 3
	new_header.append('xllcorner     '+xllcorner+'\n')
	# Line 4
	new_header.append('yllcorner     '+yllcorner+'\n')
	# Line 5
	new_header.append('cellsize      '+str(cellsize)+'\n')
	# Line 6
	new_header.append(last_line)
	
	# New File: concatenating new header with the original map information
	new_file = new_header + map_aux
	
	# Exporting it again
	mapa = open(rast+'_modified.asc', 'w')
	for i in new_file:
		mapa.write(i)
	mapa.close()
	
	# Remove the original ASCII file exported by GRASS
	os.remove(rast+'.asc')
	


