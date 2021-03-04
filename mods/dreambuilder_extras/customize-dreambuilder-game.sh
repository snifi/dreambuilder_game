#!/bin/bash

# This script manages all of the various individual changes
# for dreambuilder, e.g. updating mods, copying file components,
# making changes to the code, etc.

upstream_mods_path="/home/vanessa/Minetest-related/mods"
minetest_game_path="/home/vanessa/Minetest-related/games/minetest_game/"
game_path=$upstream_mods_path"/my_mods/dreambuilder_game"

workdir="/run/shm/dreambuilder_game"

echo -e "\nSetting up..."

rm -rf $game_path/* $workdir*
mkdir $workdir
rm -f /tmp/herefile*

echo -e "\nAdding minetest_game as the base..."

cp -a $minetest_game_path/* $workdir

echo -e "\nConfiguring it..."

rm -rf $workdir/mods/bones \
       $workdir/mods/tnt \
       $workdir/mods/mtg_craftguide \
       $workdir/mods/sethome \
       $workdir/mods/farming

cp -a $upstream_mods_path"/my_mods/dreambuilder_extras" $workdir/mods

rm	$workdir"/README.md" \
	$workdir"/mods/default/README.txt" \
	$workdir"/game.conf" \
	$workdir"/minetest.conf" \
	$workdir"/minetest.conf.example" \
	$workdir"/settingtypes.txt" \
	$workdir"/screenshot.png" \
	$workdir"/menu/icon.png" \
	$workdir"/menu/header.png"

mv $workdir"/mods/dreambuilder_extras/README.md"                        $workdir
mv $workdir"/mods/dreambuilder_extras/default_README.txt"               $workdir"/mods/default/README.txt"
mv $workdir"/mods/dreambuilder_extras/game.conf"                        $workdir
mv $workdir"/mods/dreambuilder_extras/minetest.conf.example"            $workdir
mv $workdir"/mods/dreambuilder_extras/settingtypes.txt"                 $workdir
mv $workdir"/mods/dreambuilder_extras/dreambuilder_screenshot.png"      $workdir"/screenshot.png"
mv $workdir"/mods/dreambuilder_extras/dreambuilder_menu_icon.png"       $workdir"/menu/icon.png"
mv $workdir"/mods/dreambuilder_extras/dreambuilder_menu_overlay.png"    $workdir"/menu/background.png"

# Convert fake "apple" trees back into just normal default trees,
# and don't let them spawn with apples.  Ever.

mv $workdir"/mods/dreambuilder_extras/default_tree.mts"               $workdir"/mods/default/schematics/"
mv $workdir"/mods/dreambuilder_extras/default_tree_from_sapling.mts"  $workdir"/mods/default/schematics/"

mv $workdir"/mods/default/schematics/apple_log.mts" \
   $workdir"/mods/default/schematics/default_log.mts"

rm $workdir"/mods/default/schematics/apple_tree.mts"
rm $workdir"/mods/default/schematics/apple_tree_from_sapling.mts"

sed -i "s:/schematics/apple_tree_from_sapling.mts:/schematics/default_tree_from_sapling.mts:g" $workdir"/mods/default/trees.lua"
sed -i "s:/schematics/apple_tree.mts:/schematics/default_tree.mts:" $workdir"/mods/default/mapgen.lua"
sed -i "s:/schematics/apple_log.mts:/schematics/default_log.mts:" $workdir"/mods/default/mapgen.lua"

sed -i 's/local c_apple = minetest.get_content_id("default:apple")/local c_apple = minetest.get_content_id("default:leaves")/' $workdir"/mods/default/trees.lua"

sed -i 's/Apple Wood Planks/Wood Planks/g' $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree Leaves/Leaves/'       $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree Sapling/Sapling/'     $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree/Tree/'                $workdir"/mods/default/nodes.lua"

sed -i "s/apple_tree.mts/default_tree.mts/"                           $workdir"/mods/default/README.txt"
sed -i "s/apple_log.mts/default_log.mts/"                             $workdir"/mods/default/README.txt"
sed -i "s/apple_tree_from_sapling.mts/default_tree_from_sapling.mts/" $workdir"/mods/default/README.txt"

echo -e "\nBring all mods up-to-date from "$upstream_mods_path

cd $upstream_mods_path

# No trailing slashes on these items' paths!
LINK_MODS_LIST="my_mods/biome_lib \
my_mods/coloredwood \
my_mods/currency \
my_mods/gloopblocks \
my_mods/ilights \
my_mods/moretrees \
my_mods/nixie_tubes \
my_mods/led_marquee \
my_mods/signs_lib \
my_mods/basic_signs \
my_mods/street_signs \
my_mods/unifieddyes \
my_mods/simple_streetlights \
my_mods/basic_materials \
my_mods/dreambuilder_hotbar \
Calinous_mods/bedrock \
Calinous_mods/maptools \
Calinous_mods/moreores \
Sokomines_mods/cottages \
Sokomines_mods/locks \
Sokomines_mods/travelnet \
Sokomines_mods/windmill \
RBAs_mods/datastorage \
RBAs_mods/framedglass \
Mossmanikins_mods/memorandum \
cheapies_mods/plasticbox \
cheapies_mods/prefab_redo \
cheapies_mods/invsaw \
cheapies_mods/unifiedmesecons \
cheapies_mods/digistuff \
cheapies_mods/rgblightstone \
cheapies_mods/solidcolor \
cheapies_mods/arrowboards \
cheapies_mods/digidisplay \
cheapies_mods/display_blocks_redo \
Jeijas_mods/digilines \
Jeijas_mods/jumping \
TenPlus1s_mods/farming \
TenPlus1s_mods/bees \
TenPlus1s_mods/bakedclay \
TenPlus1s_mods/cblocks \
TenPlus1s_mods/bonemeal \
TenPlus1s_mods/ambience \
tumeninodes-mods/facade \
Zeg9s_mods/steel \
DonBatmans_mods/mymillwork \
HybridDogs_mods/titanium \
HybridDogs_mods/function_delayer \
quartz \
stained_glass \
gardening \
caverealms_lite \
deezls_mods/extra_stairsplus \
blox \
new_campfire \
item_drop \
Zeg9s_mods/ufos/ufos"

COPY_MODS_LIST="
nekogloops_mods/glooptest \
Calinous_mods/moreblocks \
CWzs_mods/replacer \
CWzs_mods/player_textures \
bobblocks \
unifiedbricks \
my_mods/pipeworks \
RBAs_mods/unified_inventory"

LINK_MODPACKS_LIST="$(ls -d my_mods/home_workshop_modpack/*/) \
$(ls -d my_mods/plantlife_modpack/*/) \
$(ls -d cheapies_mods/roads_modpack/*/) \
$(ls -d cool_trees_modpack/*/)"

COPY_MODPACKS_LIST="$(ls -d my_mods/homedecor_modpack/*/) \
$(ls -d RBAs_mods/technic_modpack/*/) \
$(ls -d Philipbenrs_mods/castle-modpack/*/) \
$(ls -d worldedit_modpack/*/) \
$(ls -d Jeijas_mods/mesecons_modpack/*/)"

for i in $LINK_MODS_LIST; do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $(echo $LINK_MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $COPY_MODS_LIST; do
	rsync -a $upstream_mods_path"/"$i $workdir/mods --exclude .git*
done

for i in $(echo $COPY_MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	rsync -a $upstream_mods_path"/"$i $workdir/mods --exclude .git*
done

# above, all the stuff of the form $(ls -d foo/*/) are modpacks
# those special commands copy out just the folders from within.

echo -e "\nConfiguring the rest of Dreambuilder..."

# Disable some components

rm -f  $workdir/mods/dreambuilder_extras/models/character.b3d

rm -rf $workdir/mods/orbs_of_time

rm -f  $workdir/mods/bobblocks/trap.lua
touch  $workdir/mods/bobblocks/trap.lua

rm -f  $workdir/mods/replacer/inspect.lua
touch  $workdir/mods/replacer/inspect.lua

rm -rf $workdir/mods/wrench

sed -i "s/bucket//" \
    $workdir/mods/unifiedbricks/depends.txt

sed -i "s/mesecons =/foo =/" \
    $workdir/mods/bobblocks/blocks.lua

sed -i "s/LOAD_OTHERGEN_MODULE = true/LOAD_OTHERGEN_MODULE = false/" \
    $workdir/mods/glooptest/module.cfg

rm -rf $workdir/mods/worldedit_brush

# Create the standard in-game lightly-shaded theme, expand on it, make it user-configurable

cat > /tmp/listcolors << 'EOF'
			"listcolors["..dreambuilder_theme.listcolor_slot_bg_normal..
				";"..dreambuilder_theme.listcolor_slot_bg_hover..
				";"..dreambuilder_theme.listcolor_slot_border..
				";"..dreambuilder_theme.tooltip_bgcolor..
				";"..dreambuilder_theme.tooltip_fontcolor.."]"..
EOF

cat > /tmp/herefileA << 'EOF'
			"style_type[button;bgcolor="..dreambuilder_theme.btn_color.."]"..
			"style_type[button_exit;bgcolor="..dreambuilder_theme.btn_color.."]"..
			"style_type[image_button;bgcolor="..dreambuilder_theme.btn_color..
				";border="..dreambuilder_theme.image_button_borders.."]"..
			"style_type[image_button_exit;bgcolor="..dreambuilder_theme.btn_color..
				";border="..dreambuilder_theme.image_button_borders.."]"..
			"style_type[item_image_button;bgcolor="..dreambuilder_theme.btn_color..
				";border="..dreambuilder_theme.image_button_borders.."]"
EOF

echo '		"listcolors[#00000000;"..dreambuilder_theme.listcolor_slot_bg_hover..";#00000000;"..
			dreambuilder_theme.tooltip_bgcolor..";"..
			dreambuilder_theme.tooltip_fontcolor.."]"..' > /tmp/LISTCOLORS_HIDE_SLOTS

mv $workdir"/mods/dreambuilder_extras/minetest.conf" $workdir

sed -i "s/bgcolor\[.*\]//" \
        $workdir"/mods/beds/init.lua"

sed -i '/local formspec = \[\[/ , /\]\]/ {d}' \
        $workdir"/mods/default/init.lua"

sed -i '/Set formspec prepend/ {
	a \\t\tlocal formspec = 
	r /tmp/listcolors
	r /tmp/herefileA
	}' $workdir"/mods/default/init.lua"

sed -i '/default.gui_survival_form/ {
	i default.gui_bg = "bgcolor["..dreambuilder_theme.form_bgcolor..";"..dreambuilder_theme.window_darken.."]"\n
	a \\t\t\tdefault.gui_bg..
	}' $workdir"/mods/default/init.lua"

sed -i '/tableoptions/d' $workdir"/mods/default/craftitems.lua"

echo "depends = dreambuilder_gui_theming" >> $workdir"/mods/default/mod.conf"

sed -i 's/"style_type\[.*\]"/"style_type[label,textarea;font=mono]" \
\t\t.."style_type[textarea;textcolor="..dreambuilder_theme.editor_text_color..";border="..dreambuilder_theme.editor_border.."]"/' \
       $workdir"/mods/mesecons_luacontroller/init.lua"

sed -i "0,/depends =/s//depends = dreambuilder_gui_theming, /" $workdir"/mods/mesecons/mod.conf"

sed -i '/size\[8,9\]/ {
	a \\t\t"image[-0.12,4.73;10.03,4.95;default_standard_inventory_bg.png]"..
	a \\t\t"image[-0.12,0.15;10.03,4.79;default_chest_upper_slots_bg.png]"..
	r /tmp/LISTCOLORS_HIDE_SLOTS
	}' $workdir"/mods/pipeworks/compat-chests.lua"

sed -i '/size\[8,8.5\]/ {
	a \\t\t"image[-0.1,4.15;10.03,4.95;default_standard_inventory_bg.png]"..
	a \\t\t"image[2.65,0.37;1.254,3.59;default_furnace_upper_middle_slots_bg.png]"..
	a \\t\t"image[4.64,0.83;2.52,2.44;default_furnace_upper_right_slots_bg_2x2.png]"..
	r /tmp/LISTCOLORS_HIDE_SLOTS
	}' $workdir"/mods/pipeworks/compat-furnaces.lua"

sed -i "0, /depends = /s//depends = dreambuilder_gui_theming, /" $workdir"/mods/pipeworks/mod.conf"


sed -i '/size\[8,7;\]/ {
	a \\t\t"image[-0.1,2.75;10.03,4.95;default_standard_inventory_bg.png]"..
	a \\t\t"image[-0.1,0.23;10.03,2.37;vessels_upper_slots_bg.png]"..
    }' $workdir"/mods/vessels/init.lua"

#	r /tmp/LISTCOLORS_HIDE_SLOTS

sed -i "0, /depends = /s//depends = dreambuilder_gui_theming, /" $workdir"/mods/vessels/mod.conf"

sed -i 's/"field\[.*\]"/ \
\t\t\t"formspec_version[4]".. \
\t\t\t"size[8,4]".. \
\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t"field[1.75,1.5;4.5,0.5;channel;Channel;$\{channel\}]" \
\t\t/' \
       $workdir"/mods/technic/machines/switching_station.lua"

# the inv and slots images below are exactly 192x192 and 512x256 pixels
# and meant to cover inv areas of 3x3 and 8x4 inv slots
# but with an 8x9 formspec size, it takes a declared size of [10.03, 4.65]
# to make the 8x4 grid image fit right
# [10.03, 4.65] / [8, 4] = [1.254, 1.163]
#
# so a 3x3 inv grid should be about 3.762x3.488 real size

sed -i '/size\[8,9\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[2.9,0.93;3.762,3.488;technic_battery_box_upper_slots.png]"..
	}' $workdir"/mods/technic/machines/register/battery_box.lua"


sed -i 's/"field\[.*")/ \
\t\t\t\t\t\t"formspec_version[4]".. \
\t\t\t\t\t\t"size[8,4]".. \
\t\t\t\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t\t\t\t"field[1.75,1.5;4.5,0.5;channel;Digiline Channel;"..meta:get_string("channel").."]" \
\t\t\t\t\t)/' \
       $workdir"/mods/technic/machines/register/battery_box.lua"

sed -i '/size\[8,9;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[2.9,0.93;5.016,2.326;technic_base_machine_upper_bg.png]"..
	}' $workdir"/mods/technic/machines/register/machine_base.lua"

sed -i '/formspec = formspec/ {
	a \\t\t\t"image[0.91,2.93;2.508,1.163;technic_base_machine_upgrade_slots_bg.png]"..
	}' $workdir"/mods/technic/machines/register/machine_base.lua"

sed -i '/size\[8,9;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[2.9,0.93;1.254,1.163;technic_single_slot.png]"..
	}' $workdir"/mods/technic/machines/register/generator.lua"

# this alloy furnace change will match in two places, on purpose.
sed -i '/size\[8,9\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[1.9,0.93;6.27,3.49;technic_coal_alloy_furnace_upper_slots.png]"..
	}' $workdir"/mods/technic/machines/other/coal_alloy_furnace.lua"

sed -i '/size\[8,9;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[-0.1,1.92;10.03,2.375;technic_injector_upper_slots.png]"..
	}' $workdir"/mods/technic/machines/other/injector.lua"

sed -i '/size\[8,9;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[2.9,0.93;1.254,1.163;technic_single_slot.png]"..
	a \\t\t"image[0.91,2.93;2.508,1.163;technic_base_machine_upgrade_slots_bg.png]"..
	}' $workdir"/mods/technic/machines/MV/tool_workshop.lua"

sed -i '/size\[8,9\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[1.9,0.93;3.76,2.325;technic_reactor_upper_slots.png]"..
	}' $workdir"/mods/technic/machines/HV/nuclear_reactor.lua"

sed -i '/size\[8,9;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t\t\t"image[-0.1,4.93;10.03,4.65;technic_main_inventory.png]"..
	}' $workdir"/mods/technic/machines/other/constructor.lua"

sed -i '/list\[current_name/ {
	i \\t\t\t\t\t.."image[5.89,"..(i*0.998-1.07)..";1.254,1.163;technic_single_slot.png]"
	}' $workdir"/mods/technic/machines/other/constructor.lua"

sed -i '/size\[9,11;\]/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,6.92;10.03,4.65;technic_main_inventory.png]"..
	a \\t\t"image[-0.1,5.42;11.28,1.163;technic_cnc_upper_slots.png]"..
	}' $workdir"/mods/technic_cnc/cnc.lua"

sed -i "0, /depends = /s//depends = dreambuilder_gui_theming, /" $workdir"/mods/technic/mod.conf"

sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/internal.lua"
sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/bags.lua"
sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/register.lua"

sed -i '/local n = 4/ {
	i \\tformspec[4]="style_type[image_button;bgcolor="..dreambuilder_theme.btn_color.."]"
	i \\tformspec[5]=
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t\t""
	a \\tlocal n = 6
	d
}' $workdir"/mods/unified_inventory/internal.lua"

sed -i '/1.175;ui_bags_header.png/ {
	a \\t\t\t"style_type[button;bgcolor="..dreambuilder_theme.btn_color.."]",
	}' $workdir"/mods/unified_inventory/bags.lua"

sed -i "0, /depends = /s//depends = dreambuilder_gui_theming, /" $workdir"/mods/unified_inventory/mod.conf"

sed -i '/"label\[0,0;"/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
}' $workdir"/mods/technic_chests/register.lua"

sed -i "0, /depends = /s//depends = dreambuilder_gui_theming, /" $workdir"/mods/technic_chests/mod.conf"

sed -i '/image\[2.75,1.5;1,1;/ {
	r /tmp/LISTCOLORS_HIDE_SLOTS
	a \\t\t"image[-0.1,4.15;10.03,4.95;default_standard_inventory_bg.png]"..
	a \\t\t"image[2.65,0.37;1.254,3.59;default_furnace_upper_middle_slots_bg.png]"..
	a \\t\t"image[4.64,0.83;2.52,2.44;default_furnace_upper_right_slots_bg_"..w.."x"..h..".png]"..
	}' $workdir"/mods/homedecor_common/furnaces.lua"

mv $workdir"/mods/dreambuilder_extras/dreambuilder_gui_theming" \
	$workdir"/mods/"

rm	$workdir"/mods/default/textures/gui_formbg.png" \
	$workdir"/mods/mesecons/textures/jeija_close_window.png" \
	$workdir"/mods/mesecons_luacontroller/textures/jeija_luac_background.png" \
	$workdir"/mods/mesecons_luacontroller/textures/jeija_luac_runbutton.png" \
	$workdir"/mods/unified_inventory/textures/ui_bags_header.png" \
	$workdir"/mods/unified_inventory/textures/ui_bags_inv"* \
	$workdir"/mods/unified_inventory/textures/ui_bags_trash.png" \
	$workdir"/mods/unified_inventory/textures/ui_crafting_form.png" \
	$workdir"/mods/unified_inventory/textures/ui_form_bg.png" \
	$workdir"/mods/unified_inventory/textures/ui_main_inventory.png" \
	$workdir"/mods/unified_inventory/textures/ui_single_slot.png" \
	$workdir"/mods/vessels/textures/vessels_shelf_slot.png" \
	$workdir"/mods/default/textures/gui_hotbar_selected.png" \
	$workdir"/mods/technic_chests/textures/technic_chest_form_bg.png" \
	$workdir"/mods/technic_chests/textures/"*"inventory.png"

rm /tmp/herefile* /tmp/LISTCOLORS_HIDE_SLOTS

# Add in all of the regular player skins for the player_textures mod

rm -f $workdir/mods/player_textures/textures/* 

LIST="player_Calinou.png
player_cheapie.png
player_kaeza.png
player_Sokomine.png
player_VanessaE.png"

while read -r FILE; do
cp $upstream_mods_path"/../player_skins/"$FILE \
    $workdir/mods/player_textures/textures
done <<< "$LIST"

rsync -aL \
	--exclude=".git*" \
	$workdir"/" \
	$workdir"_no_git"

rsync -aL \
	$workdir"_no_git/" \
	$game_path

rm -rf $workdir*


echo -e "\nCustomization completed.\n"

#echo -e "Here's what will be included in the game:\n"
#ls -a $game_path $game_path/mods
