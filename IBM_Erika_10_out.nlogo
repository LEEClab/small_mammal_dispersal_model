Extensions [gis
pathdir]

globals[ ;varibles used by all agents
  count_mort
  x
  ;objects used to create names to directory.
  file0
  file1
  file

  resolution ;how much each pixel represents - landscape resolution
  oriented ;orientation variable

  ;import landscape cover
  directory ; define directory where is the landscapes
  direct_list ; list files in directory
  landscape ;landscape choose from list
  new_landscape ;directory and landscape together to import
  landscape-dataset ;import the raster cover

  ;import landscape ID_PATCHES
  directory_ID_PATCHES
  direct_list_ID_PATCHES
  landscape_ID_PATCHES
  new_landscape_ID_PATCHES
  landscape-ID_PATCHES-dataset ; raster ID

  ;import landscape ID_SS
  directory_ID_SS
  direct_list_ID_SS
  landscape_ID_SS
  new_landscape_ID_SS
  landscape-ID_SS-dataset ; raster ID

  ;import landscape ID_TREES
  directory_ID_TREES
  direct_list_ID_TREES
  landscape_ID_TREES
  new_landscape_ID_TREES
  landscape-ID_TREES-dataset ; raster ID

  ;import landscape DIST_PATCHES
  directory_DIST_PATCHES
  direct_list_DIST_PATCHES
  landscape_DIST_PATCHES
  new_landscape_DIST_PATCHES
  landscape-DIST_PATCHES-dataset ; raster ID

  ;import landscape DIST_SS
  directory_DIST_SS
  direct_list_DIST_SS
  landscape_DIST_SS
  new_landscape_DIST_SS
  landscape-DIST_SS-dataset ; raster ID

  ;import landscape DIST_TREES
  directory_DIST_TREES
  direct_list_DIST_TREES
  landscape_DIST_TREES
  new_landscape_DIST_TREES
  landscape-DIST_TREES-dataset ; raster ID

  directory_base

  ;sets of pixels according with cover type
  fragment_set

  ;sets of pixels around patches, trees and ss
  initial_border_patches
  border_patches
  border_ss
  border_trees
]

patches-own [
  cover ;vegetal cover (pasture or forest)
  ;ID variables
  PATCHES_ID
  SS_ID
  TREES_ID
  ;DIST variables
  PATCHES_DIST
  SS_DIST
  TREES_DIST
  ]

turtles-own[
  time1
  PR ; perceptual range(meters)
  start-patch ;initial patch
  new-xcor ;new coordenate x to movement
  new-ycor ;new coordenate y to movement

  ;---------------variables to step lenght
  ;Truncated Pareto Distribution
  l ; step lenght
  RAN ; random number between 0 and 1

  ;---------------variables to turning angle
  turning_angle ; turning angle
  ang ;angle + turning angle

  life ;  dead = 0 alive = 1
  rand_num_mort

  source ; fragment initial
  end_frag
  distance_total;
  distance_mort; distance to calculate mortality
  initial_frag
  actual_cover

  ID
  prev_ID
]

;submodels to import landscape data

to base
  set directory_base "/home/kekuntu/Documentos/Banco de dados de paisagens/New_landscape_1000/"
end

to import_TREES_SS ;import landscape with all elements (patches, ss and trees)
  ;-----------------------LANDSCAPE WITH ALL ELEMENTS
  set directory word directory_base "exported_ascii_MS_HABMAT_ALL_TREES_2P_SS_5HA_PATCH/" ;define directory
  set direct_list pathdir:list word directory_base "exported_ascii_MS_HABMAT_ALL_TREES_2P_SS_5HA_PATCH" ;list of files in directory
  set direct_list sort direct_list
  set landscape item num_lands direct_list ;get one of the landscape from the list and define as landscape
  set new_landscape word directory landscape ;set the new_landscape with the directory to import
end

to import_SS ; import landscape with patches and ss
;-----------------------LANDSCAPE WITH PATCHES AND SS
  set directory word directory_base "exported_ascii_MS_HABMAT_NO_TREES/" ;define directory
  set direct_list pathdir:list word directory_base "exported_ascii_MS_HABMAT_NO_TREES" ;list of files in directory
  set direct_list sort direct_list
  set landscape item num_lands direct_list ;get one of the landscape from the list and define as landscape
  set new_landscape word directory landscape ;set the new_landscape with the directory to import
end

to import_TREES ; import landscape with patches and ss
;-----------------------LANDSCAPE WITH PATCHES AND SS
  set directory word directory_base "exported_ascii_MS_HABMAT_NO_SS/" ;define directory
  set direct_list pathdir:list word directory_base "exported_ascii_MS_HABMAT_NO_SS" ;list of files in directory
  set direct_list sort direct_list
  set landscape item num_lands direct_list ;get one of the landscape from the list and define as landscape
  set new_landscape word directory landscape ;set the new_landscape with the directory to import
end

to import_PATCHES_ONLY ;import landscape with patches only
;-----------------------LANDSCAPE WITH ONLY PATCHES
  set directory word directory_base "exported_ascii_MS_HABMAT_PATCHES_ONLY/" ;define directory
  set direct_list pathdir:list word directory_base "exported_ascii_MS_HABMAT_PATCHES_ONLY" ;list of files in directory
  set direct_list sort direct_list
  set landscape item num_lands direct_list ;get one of the landscape from the list and define as landscape
  set new_landscape word directory landscape ;set the new_landscape with the directory to import
end

to import_ID_PATCHES ;import ID of patches
;-----------------------LANDSCAPE ID_PATCHES
  set directory_ID_PATCHES word directory_base "/exported_ascii_MS_HABMAT_PATCHES_ONLY_PID/" ;define directory
  set direct_list_ID_PATCHES pathdir:list word directory_base "exported_ascii_MS_HABMAT_PATCHES_ONLY_PID" ;list of files in directory
  set direct_list_ID_PATCHES sort direct_list_ID_PATCHES
  set landscape_ID_PATCHES item num_lands direct_list_ID_PATCHES ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_ID_PATCHES word directory_ID_PATCHES landscape_ID_PATCHES
end

to import_ID_SS ;import ID of ss
;-----------------------LANDSCAPE ID_SS
  set directory_ID_SS word directory_base "exported_ascii_MS_HABMAT_SS_5HA_PID/" ;define directory
  set direct_list_ID_SS pathdir:list word directory_base "exported_ascii_MS_HABMAT_SS_5HA_PID" ;list of files in directory
  set direct_list_ID_SS sort direct_list_ID_SS
  set landscape_ID_SS item num_lands direct_list_ID_SS ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_ID_SS word directory_ID_SS landscape_ID_SS
end

to import_ID_TREES ;import ID of trees
;-----------------------LANDSCAPE ID_TREES
  set directory_ID_TREES word directory_base "exported_ascii_MS_HABMAT_2PIX_TREES_PID/" ;define directory
  set direct_list_ID_TREES pathdir:list word directory_base "exported_ascii_MS_HABMAT_2PIX_TREES_PID" ;list of files in directory
  set direct_list_ID_TREES sort direct_list_ID_TREES
  set landscape_ID_TREES item num_lands direct_list_ID_TREES ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_ID_TREES word directory_ID_TREES landscape_ID_TREES
end

to import_DIST_PATCHES ;import DIST from patches
;-----------------------LANDSCAPE DIST OF PATCHES
  set directory_DIST_PATCHES word directory_base "exported_ascii_MS_HABMAT_PATCHES_ONLY_DIST/" ;define directory
  set direct_list_DIST_PATCHES pathdir:list word directory_base "exported_ascii_MS_HABMAT_PATCHES_ONLY_DIST" ;list of files in directory
  set direct_list_DIST_PATCHES sort direct_list_DIST_PATCHES
  set landscape_DIST_PATCHES item num_lands direct_list_DIST_PATCHES ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_DIST_PATCHES word directory_DIST_PATCHES landscape_DIST_PATCHES
end

to import_DIST_SS ;import DIST from ss
;-----------------------LANDSCAPE DIST OF SS
  set directory_DIST_SS word directory_base "exported_ascii_MS_HABMAT_SS_5HA_DIST/" ;define directory
  set direct_list_DIST_SS pathdir:list word directory_base "exported_ascii_MS_HABMAT_SS_5HA_DIST" ;list of files in directory
  set direct_list_DIST_SS sort direct_list_DIST_SS
  set landscape_DIST_SS item num_lands direct_list_DIST_SS ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_DIST_SS word directory_DIST_SS landscape_DIST_SS
end

to import_DIST_TREES ;import DIST from trees
;-----------------------LANDSCAPE DIST OF TREES
  set directory_DIST_TREES word directory_base "exported_ascii_MS_HABMAT_2PIX_TREES_DIST/" ;define directory
  set direct_list_DIST_TREES pathdir:list word directory_base "exported_ascii_MS_HABMAT_2PIX_TREES_DIST" ;list of files in directory
  set direct_list_DIST_TREES sort direct_list_DIST_TREES
  set landscape_DIST_TREES item num_lands direct_list_DIST_TREES ;get one of the landscape from the list and define as landscape_ID
  set new_landscape_DIST_TREES word directory_DIST_TREES landscape_DIST_TREES
end

;submodels to define landscape data

to define_landscape ;define landscape
;------------------------------------------------------Set landscape
  set landscape-dataset gis:load-dataset new_landscape
  gis:set-world-envelope-ds gis:envelope-of landscape-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-dataset cover ;get values of the landscape to variable cover
  ask patches with [cover = 0] [ set pcolor brown ] ; Brown = Matrix
  ask patches with [cover = 1] [ set pcolor green ] ; Green = Fragments
  ask patches with [cover = 2] [ set pcolor 26 ] ; Orange = Stepping Stones
  ask patches with [cover = 3] [ set pcolor 104 ] ; Violet = Trees
end

to define_ID_PATCHES ;define ID of patches
;------------------------------------------------------Set landscape ID_PATCHES
  set landscape-ID_PATCHES-dataset gis:load-dataset new_landscape_ID_PATCHES
  gis:set-world-envelope-ds gis:envelope-of landscape-ID_PATCHES-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-ID_PATCHES-dataset PATCHES_ID ;get values of the landscape to variable cover

end

to define_ID_SS ;define ID of ss
;------------------------------------------------------Set landscape ID_SS
  set landscape-ID_SS-dataset gis:load-dataset new_landscape_ID_SS
  gis:set-world-envelope-ds gis:envelope-of landscape-ID_SS-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-ID_SS-dataset SS_ID ;get values of the landscape to variable cover
end

to define_ID_TREES ;define ID of trees
;------------------------------------------------------Set landscape ID_TREES
  set landscape-ID_TREES-dataset gis:load-dataset new_landscape_ID_TREES
  gis:set-world-envelope-ds gis:envelope-of landscape-ID_TREES-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-ID_TREES-dataset TREES_ID ;get values of the landscape to variable cover
end

to define_DIST_PATCHES ;define DIST from patches
;------------------------------------------------------Set landscape PATCHES_DIST
  set landscape-DIST_PATCHES-dataset gis:load-dataset new_landscape_DIST_PATCHES
  gis:set-world-envelope gis:envelope-of landscape-DIST_PATCHES-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-DIST_PATCHES-dataset PATCHES_DIST ;get values of the landscape to variable cover
end

to define_DIST_SS ;define DIST from ss
;------------------------------------------------------Set landscape SS_DIST
  set landscape-DIST_SS-dataset gis:load-dataset new_landscape_DIST_SS
  gis:set-world-envelope gis:envelope-of landscape-DIST_SS-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-DIST_SS-dataset SS_DIST ;get values of the landscape to variable cover
end

to define_DIST_TREES ;define DIST from trees
;------------------------------------------------------Set landscape TREES_DIST
  set landscape-DIST_TREES-dataset gis:load-dataset new_landscape_DIST_TREES
  gis:set-world-envelope gis:envelope-of landscape-DIST_TREES-dataset ;define the world size similar to the landscape imported
  gis:apply-raster landscape-DIST_TREES-dataset TREES_DIST ;get values of the landscape to variable cover
end

to setup ;;---------------------------------------CREATE LANDSCAPE AND TURTLES------------------------------------------------
  clear-all
  reset-ticks
  set-current-directory "/home/kekuntu/Documentos/Mestrado/TESTE_RES_30"
  ;Set file and file name
  set file0 word specie "_"
  set file1 word file0 num_lands
  if TREES = true and SS = false
  [set file word file1 "_TREES_ONLY"]
  if TREES = true and SS = true
  [set file word file1 "_TREES_SS"]
  if TREES = false and SS = true
  [set file word file1 "_SS_ONLY"]
  if SS = false and TREES = false
  [set file word file1 "_PATCHES_ONLY"]
  set x 0
  file-close
  while [file-exists? word file "_data.txt"]
  [set file word file x]
 ;---------------------------------------------------CREATE ENVIRONMENT----------------------------------------------------
  resize-world -512 512 -512 512 ;Definir a paisagem como 1024x1024.
  ;set resolution 10 ;ou seja cada pixel é equivalente à 10m
  set resolution 30 ;ou seja cada pixel é equivalente à 30m
  set-patch-size 0.2

  ;--------------------------------------------Shuffle landscape from directory

  base

  if TREES = true and SS = true ;(patches, ss and trees)
  [
    import_TREES_SS ;import landscape with all elements
    ;import ID of all elements
    import_ID_PATCHES
    import_ID_SS
    import_ID_TREES
    ;import DIST from all elements
    import_DIST_PATCHES
    import_DIST_SS
    import_DIST_TREES

    ;define all
    define_landscape
    define_ID_PATCHES
    define_ID_SS
    define_ID_TREES
    define_DIST_PATCHES
    define_DIST_SS
    define_DIST_TREES
  ]
  if SS = true and TREES = false;(patches and ss)
  [
    import_SS ;import landscape with patches and ss
    ;import ID of patches and ss
    import_ID_PATCHES
    import_ID_SS
    ;import DIST from patches and ss
    import_DIST_PATCHES
    import_DIST_SS

    ;define all
    define_landscape
    define_ID_PATCHES
    define_ID_SS
    define_DIST_PATCHES
    define_DIST_SS
  ]
  if SS = false and TREES = true;(patches and trees)
  [
    import_TREES ;import landscape with patches and ss
    ;import ID of patches and ss
    import_ID_PATCHES
    import_ID_TREES
    ;import DIST from patches and ss
    import_DIST_PATCHES
    import_DIST_TREES

    ;define all
    define_landscape
    define_ID_PATCHES
    define_ID_TREES
    define_DIST_PATCHES
    define_DIST_TREES
  ]
  if SS = false and TREES = false
  [;(only patches
    import_PATCHES_ONLY ;import landscape with patches
    import_ID_PATCHES ;import ID of patches
    import_DIST_PATCHES ;import DIST from patches
    ;define all
    define_landscape
    define_ID_PATCHES
    define_DIST_PATCHES
  ]

  ;create patch-sets
  set fragment_set patch-set patches with [cover = 1]

  set border_patches patch-set patches with [cover = 0 and count neighbors with [cover = 1] >= 1 and count neighbors with [cover = 1] <= 2]
  set border_ss patch-set patches with [cover = 0 and count neighbors with [cover = 2] >= 1 and count neighbors with [cover = 2] <= 2]
  set border_trees patch-set patches with [cover = 0 and count neighbors with [cover = 3] >= 1 and count neighbors with [cover = 3] <= 2]

  set initial_border_patches patch-set patches with [cover = 0 and PATCHES_DIST > (perceptual_range) and PATCHES_DIST < (perceptual_range) + 10]

;------------------------------------------------------CREATE AGENTS---------------------------------------------------------
  create-turtles individuals [setxy random-xcor random-ycor]
   ask turtles [
    set count_mort 0
    set color yellow
    set size 10
    set PR perceptual_range / resolution ;100m represent 10 pixels, because each pixel = 10m
    set time1 0 ;set start time at 0
    set life 1 ; all turtles alive
    set distance_total 0 ;set start distance at 0
    set distance_mort 0 ;distance of mortality - each 100m --> chance of mortality
    set oriented 0
    set actual_cover 1
    ;define where the turtle will start
    ;;start in matrix
    set start-patch one-of initial_border_patches ;get a random patch of border_patches
    setxy ([pxcor] of start-patch) ([pycor] of start-patch) ;set start-patch
    ;;initial_frag is the nearest fragment
    set initial_frag min-one-of fragment_set [distance myself]
    set source [PATCHES_ID] of initial_frag ;define fragment initial for each turtle
    ;;define coordinates of initial_fragments to save in the output
    let initial_xcor [pxcor] of initial_frag
    let initial_ycor [pycor] of initial_frag
    ;set ID
    set ID source
    ;face matrix to initiate movement
    face initial_frag
    set heading heading + 180

    ;register values when turtle is in the fragment
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 actual_cover ID life initial_xcor initial_ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 actual_cover ID life initial_xcor initial_ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;register values when turtle is in the matrix
    set time1 time1 + 1
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life xcor ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life xcor ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close
  ]
end

;;-------------------------------------MOVEMENT------------------------------------------
;observer procedure
to go ;;Start simulation

  tick
  ask turtles
  [
    if [cover] of patch-here = 0
    [move]
    if [cover] of patch-here = 1
    [in_patch]
    if [cover] of patch-here = 2
    [in_ss]
    if [cover] of patch-here = 3
    [in_trees]

    if life = 0
    [die]
  ]


  if ticks = 10000
  [
    ask turtles [
      set time1 time1 + 1
      if [cover] of patch-here = 0
      [set life 0]

      ;register last step
      file-open word file "_data.txt"
      ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life xcor ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
      file-print (list who time1 cover ID life xcor ycor oriented l turning_angle ang source end_frag distance_total count_mort)
      file-close

      if [cover] of patch-here = 0
      [die]
    ]
    stop
  ]
 end

;turtle procedure
to move ;Se o indivíduo decidir sair, então vai dispersar pela matriz.
  ;pen-down ;função para criar linhas das trajetórias na paisagem durante a simulação
  ;set color yellow;

  ;;;we don't define ID because turtle is within matrix, and it is important to keep the last ID to avoid turtle to come back.

  ;Define next step
  ifelse not any? patches in-radius PR with [cover != 0 and PATCHES_ID != [ID] of myself and SS_ID != [ID] of myself and TREES_ID != [ID] of myself and PATCHES_ID != [prev_ID] of myself and SS_ID != [prev_ID] of myself and TREES_ID != [prev_ID] of myself] ;se tem nenhuma floresta com ID diferente do ID anterior
  [
    ;movimento não orientado
    set oriented 0
    ;step lenght
    set RAN random-float 1
    set l ((Xmax-no ^ (expo-no + 1) - Xmin-no ^ (expo-no + 1)) * RAN + Xmin-no ^ (expo-no + 1)) ^ (1 / (expo-no + 1))
    ;turning angle and absolute angle
    set turning_angle random-normal mean-ang-no sd-ang-no
    set ang (heading + turning_angle) ; angulo de virada.

    ;-----Calcular as coordenadas using l and turning angle----
    set new-xcor (xcor + (l / resolution * sin(ang))) ;definir a nova coordenada x
    set new-ycor (ycor + (l / resolution * cos(ang))) ;definir a nova coordenada y

    ;define total distance realized
    set distance_total distance_total + l
    set distance_mort distance_mort + l

    ;-----Testar mortalidade proporcional ao step lenght (l)
    mortality

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;-----Definir novas coordenadas
    setxy new-xcor new-ycor ; define as novas coordenadas
  ]
  [ ;near_cover - patchset of all patches that are in the radius of PR and might be tree,ss or patch different for the one before.
    let near_cover patch-set patches in-radius PR with [cover != 0 and PATCHES_ID != [ID] of myself and SS_ID != [ID] of myself and TREES_ID != [ID] of myself and PATCHES_ID != [prev_ID] of myself and SS_ID != [prev_ID] of myself and TREES_ID != [prev_ID] of myself]
    let goal_pixel one-of near_cover

    if ([cover] of goal_pixel = 1) or ([cover] of goal_pixel = 2) ;if that goal is patch or ss
    [
      ;movimento orientado
      set oriented 1
      face goal_pixel  ;pcolor = green]; and patchID != source]
      ;l step lenght
      set RAN random-float 1
      set l ((Xmax-o ^ (expo-o + 1) - Xmin-o ^ (expo-o + 1)) * RAN + Xmin-o ^ (expo-o + 1)) ^ (1 / (expo-o + 1))
      ;turning angle and absolute angle
      set turning_angle random-normal mean-ang-o sd-ang-o
      set ang (heading + turning_angle) ; angulo de virada.
      ;set color black

      ;-----Calcular as coordenadas----goal_pixel with [cover = 1 or cover = 2]
      set new-xcor (xcor + (l / resolution * sin(ang))) ;definir a nova coordenada x
      set new-ycor (ycor + (l / resolution * cos(ang))) ;definir a nova coordenada y

      ;define total distance realized
      set distance_total distance_total + l
      set distance_mort distance_mort + l

      ;-----Testar mortalidade proporcional ao step lenght (l)
      mortality

      set time1 time1 + 1

      ;register values with all data update but before turtle move
      file-open word file "_data.txt"
      ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
      file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
      file-close

      ;-----Definir novas coordenadas
      setxy new-xcor new-ycor ; define as novas coordenadas
    ]

    if ([cover] of goal_pixel = 3) ;if that goal is tree
    [
      set oriented 1
      ;define new_patch to move
      let new-patch goal_pixel

      ;define l - step lenght
      set l [distance myself] of new-patch
      ;turning angle and absolute angle
      let actual_heading heading
      face new-patch
      let new_heading heading
      set turning_angle (new_heading - actual_heading)
      set ang new_heading

       ;-----Calcula novas coordenadas
      set new-xcor [pxcor] of new-patch
      set new-ycor [pycor] of new-patch

      ;define total distance realized
      set distance_total distance_total + l
      set distance_mort distance_mort + l

      ;-----Testar mortalidade proporcional ao step lenght (l)
      mortality

      set time1 time1 + 1

      ;register values with all data update but before turtle move
      file-open word file "_data.txt"
      ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
      file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
      file-close

      ;move
      setxy new-xcor new-ycor ; define as novas coordenadas
    ]
  ]; bracket de fechamento do if
end

to in_patch
  set prev_ID ID
  set ID [PATCHES_ID] of patch-here
  ;set distance_mort 0 DUVIDA?

  ;define next step
  ifelse [PATCHES_ID] of patch-here = [PATCHES_ID] of initial_frag and distance_total < 1000 ;If the individual arrive at the same source fragment, he might stop if he had walked already more than 10000, or he should go to matrix again
  [
    let near_patch min-one-of border_patches [distance myself]

    ;-----Calcula novas coordenadas
    set new-xcor [pxcor] of near_patch
    set new-ycor [pycor] of near_patch

    ;define l distance (should be calculated before the turtle move)
    set l [distance myself] of near_patch
    ;define total distance realized
    set distance_total distance_total + l

    ;define turning angle and absolute angle
    let actual_heading heading
    face near_patch
    let new_heading heading
    set turning_angle (new_heading - actual_heading)
    set ang new_heading

    ;-----Testar mortalidade proporcional ao step lenght (l) - testar pq a turtle está na matriz
    mortality

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;move
    setxy new-xcor new-ycor ; define as novas coordenadas

    ;face against source fragment
    let source_f source
    face min-one-of patches with [PATCHES_ID = source_f] [distance myself]
    rt 180

  ]
  [set end_frag [PATCHES_ID] of patch-here
    set time1 time1 + 1
    stop

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close
  ]
end

to in_ss
  ;set color blue
  set prev_ID ID
  set ID [SS_ID] of patch-here
  set distance_mort 0

  ;Define new step
  ifelse count neighbors with [cover = 2] >= 5 ;should have at least 3 pixels of matrix as neighbors (due to the isolated matrix pixel inside the small patch, we consider that the individual reaches the borders when at least three neighbors pixels are matrix
  [let near_patch one-of neighbors with [cover = 2] ; move in SS

    ;-----Calcula novas coordenadas
    set new-xcor [pxcor] of near_patch
    set new-ycor [pycor] of near_patch

    ;define distance - Step lenght
    set l 10 ;Each pixel is equal to 10m, move one pixel, means 10m.
    ;define total distance realized
    set distance_total distance_total + l
    ;there is no addition to distance_mort because the turtle is within the SS

    ;define turning angle and absolute angle
    let actual_heading heading
    face near_patch
    let new_heading heading
    set turning_angle (new_heading - actual_heading)
    set ang new_heading

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;move
    setxy new-xcor new-ycor ; define as novas coordenadas
  ]
  [let near_patch min-one-of border_ss [distance myself]; Get of SS and go to matriz

    ;-----Calcula novas coordenadas
    set new-xcor [pxcor] of near_patch
    set new-ycor [pycor] of near_patch

    ;define distance - step lenght
    set l [distance myself] of near_patch ;não anda apenas um pixel, mas alguns, e é necessário calcular essa distancia
    ;define total distance realized
    set distance_total distance_total + l
    set distance_mort distance_mort + l ; calcula dist_mort pq saiu da SS e foi pra matriz

    ;define turning angle and absolute angle
    let actual_heading heading
    face near_patch
    let new_heading heading
    set turning_angle (new_heading - actual_heading)
    set ang new_heading

    mortality

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;move
    setxy new-xcor new-ycor ; define as novas coordenadas
  ]

end

to in_trees
  ;set color red
  set prev_ID ID
  set ID [TREES_ID] of patch-here
  set distance_mort 0

  ;;ERRO - TURTLE CHEGAVA NA ÁRVORE E TODOS OS NEIGHBORS TAMBÉM TINHA COVER = 3, NÃO ENTENDI PORQUE. MAS FUNCIONOU DESSA MANEIRA, CASO TENHA ALGUM VIZINHO COM COVER IGUAL, ENTÃO SE MOVE APENAS PRO VIZINHO.
  ;Define new step
  ifelse count neighbors with [cover = 3] >= 5
  [let near_patch one-of neighbors with [cover = 3] ;move to neighbor

    ;-----Calcula novas coordenadas
    set new-xcor [pxcor] of near_patch
    set new-ycor [pycor] of near_patch

    ;define distance - Step lenght
    set l 10 ;Each pixel is equal to 10m, move one pixel, means 10m.
    ;define total distance realized
    set distance_total distance_total + l
    ;there is no addition to distance_mort because the turtle is within the trees

    ;define turning angle and absolute angle
    let actual_heading heading
    face near_patch
    let new_heading heading
    set turning_angle (new_heading - actual_heading)
    set ang new_heading

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;move
    setxy new-xcor new-ycor ; define as novas coordenadas
  ]
  [let near_patch one-of neighbors with [cover = 0]

    ;-----Calcula novas coordenadas
    set new-xcor [pxcor] of near_patch
    set new-ycor [pycor] of near_patch

    ;define distance - step lenght
    set l [distance myself] of near_patch ;não anda apenas um pixel, mas alguns, e é necessário calcular essa distancia
    ;define total distance realized
    set distance_total distance_total + l
    set distance_mort distance_mort + l ; calcula dist_mort pq saiu da SS e foi pra matriz

    ;define turning angle and absolute angle
    let actual_heading heading
    face near_patch
    let new_heading heading
    set turning_angle (new_heading - actual_heading)
    set ang new_heading

    mortality

    set time1 time1 + 1

    ;register values with all data update but before turtle move
    file-open word file "_data.txt"
    ;file-print (list landscape specie perceptual_range SS TREES who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total distance_mort count_mort)
    file-print (list who time1 cover ID life new-xcor new-ycor oriented l turning_angle ang source end_frag distance_total count_mort)
    file-close

    ;move
    setxy new-xcor new-ycor ; define as novas coordenadas
  ]
  set time1 time1 + 1
end

to mortality ;Taxa de mortalidade constante enquanto o indivíduo anda pela matriz.
  if distance_mort > 100
  [
    ;test mortality risk
    set rand_num_mort random-float 1
    if rand_num_mort < mortality_rate
    [set life 0]
    ;recalculate dist_mort and count_mort
    set distance_mort (distance_mort - 100)
    set count_mort count_mort + 1
  ]

end
@#$#@#$#@
GRAPHICS-WINDOW
380
10
1405
1044
-1
-1
0.2
1
10
1
1
1
0
1
1
1
-512
512
-512
512
0
0
1
ticks
30.0

BUTTON
200
85
263
118
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
20
80
155
113
individuals
individuals
0
1000
100.0
1
1
NIL
HORIZONTAL

BUTTON
200
126
263
159
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
20
120
155
153
perceptual_range
perceptual_range
0
1000
200.0
50
1
NIL
HORIZONTAL

SLIDER
20
165
315
198
mortality_rate
mortality_rate
0
1
0.01
0.001
1
NIL
HORIZONTAL

INPUTBOX
20
240
90
300
Xmin-no
0.2
1
0
Number

INPUTBOX
20
305
90
365
Xmax-no
16.8
1
0
Number

INPUTBOX
20
370
90
430
Expo-no
-1.54405444071
1
0
Number

INPUTBOX
100
240
175
300
mean-ang-no
-0.74
1
0
Number

INPUTBOX
100
305
175
365
sd-ang-no
55.81
1
0
Number

INPUTBOX
205
235
275
295
Xmin-o
0.25
1
0
Number

INPUTBOX
205
300
275
360
Xmax-o
26.0
1
0
Number

INPUTBOX
205
365
275
425
Expo-o
-1.16574079902
1
0
Number

INPUTBOX
285
235
360
295
mean-ang-o
0.34
1
0
Number

INPUTBOX
285
300
360
360
sd-ang-o
50.45
1
0
Number

TEXTBOX
20
210
245
236
Non-oriented move
12
0.0
1

TEXTBOX
205
210
395
236
Oriented move
12
0.0
1

INPUTBOX
15
10
80
70
num_lands
28.0
1
0
Number

INPUTBOX
85
10
310
70
specie
DA
1
0
String

SWITCH
25
450
128
483
SS
SS
0
1
-1000

SWITCH
150
450
277
483
TREES
TREES
0
1
-1000

PLOT
85
525
285
675
Mortality
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count turtles"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="didelphis_TREES_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;DA&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-0.74"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="55.81"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="0.34"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="50.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.54405444071"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="16.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.16574079902"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="philander_TREES_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;PF&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="54.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="3.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="58.19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.71113207331"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="20.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.46996251381"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="marmosa_TREES_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;MP&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-2.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="60.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="-1.09"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="56.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.98307373966"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="19.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.45759352553"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="didelphis_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;DA&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-0.74"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="55.81"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="0.34"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="50.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.54405444071"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="16.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.16574079902"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="philander_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;PF&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="54.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="3.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="58.19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.71113207331"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="20.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.46996251381"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="marmosa_SS_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;MP&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-2.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="60.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="-1.09"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="56.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.98307373966"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="19.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.45759352553"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="didelphis_PATCHES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;DA&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-0.74"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="55.81"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="0.34"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="50.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.54405444071"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="16.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.16574079902"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="philander_PATCHES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;PF&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="54.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="3.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="58.19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.71113207331"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="20.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.46996251381"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="marmosa_PATCHES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;MP&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-2.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="60.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="-1.09"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="56.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.98307373966"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="19.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.45759352553"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="didelphis_TREES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;DA&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-0.74"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="55.81"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="0.34"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="50.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.54405444071"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="16.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.16574079902"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="philander_TREES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;PF&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="54.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="3.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="58.19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.71113207331"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="20.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.46996251381"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.25"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="marmosa_TREES_ONLY_0.01" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="specie">
      <value value="&quot;MP&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="perceptual_range">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mortality_rate">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="individuals">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-no">
      <value value="-2.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-no">
      <value value="60.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-ang-o">
      <value value="-1.09"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sd-ang-o">
      <value value="56.11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-no">
      <value value="-1.98307373966"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-no">
      <value value="19.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-no">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Expo-o">
      <value value="-1.45759352553"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmax-o">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Xmin-o">
      <value value="0.1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_lands" first="0" step="1" last="28"/>
    <enumeratedValueSet variable="TREES">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SS">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
