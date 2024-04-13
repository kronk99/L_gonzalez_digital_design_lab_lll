set_global_assignment -entity "PLL2" -library "lib_PLL2" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL2" -library "lib_PLL2" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "PLL2" -library "lib_PLL2" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL2" -name SPD_FILE [file join $::quartus(sip_path) "PLL2.spd"]

set_global_assignment -library "lib_PLL2" -name MISC_FILE [file join $::quartus(sip_path) "PLL2_sim/PLL2.vo"]
