
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name keyboard_test -dir "C:/jiyuan/keyboard_test/planAhead_run_4" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/jiyuan/keyboard_test/KNController.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/jiyuan/keyboard_test} {../myVGA/ipcore_dir} }
add_files [list {../myVGA/ipcore_dir/new_buffer_ram.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "KNController.ucf" [current_fileset -constrset]
add_files [list {KNController.ucf}] -fileset [get_property constrset [current_run]]
link_design
