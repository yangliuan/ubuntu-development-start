#!/bin/bash
custom_dir=$(dirname "`readlink -f $0`")

# install ubsoft use costom agruments
bash ${custom_dir}/install/ubsoft.sh --input_method_option 2 --chrome --indicator_sysmonitor --qv2ray --theme_tools --custom

# install devbase use costom agruments 
bash ${custom_dir}/install/devbase.sh

# install devtools use costom agruments 
bash ${custom_dir}/install/devtools.sh

# install devaddons use costom agruments 
bash ${custom_dir}/install/devaddons.sh