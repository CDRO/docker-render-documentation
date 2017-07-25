#!/bin/bash

# provide default
OUR_IMAGE=${OUR_IMAGE:-t3docs/render-documentation}
OUR_IMAGE_SHORT=${OUR_IMAGE_SHORT:-t3rd}

cat <<EOT

# NOTE
# You can 'source' the following directly into the shell of your commandline with:
#     source <(docker run --rm $OUR_IMAGE show-shell-commands)
# ATTENTION:
#     No whitespace between '<('

# the usual worker command
function dockrun_$OUR_IMAGE_SHORT () {
mkdir Documentation-GENERATED-temp 2>/dev/null
docker run --rm \\
-v "\$PWD":/PROJECT/:ro \\
-v "\$PWD"/Documentation-GENERATED-temp/:/RESULT/ \\
--user=\$(id -u):\$(id -g) \\
$OUR_IMAGE \$@
}

# switch to the container's bash
function dockbash_$OUR_IMAGE_SHORT() {
mkdir Documentation-GENERATED-temp 2>/dev/null
docker run --rm -it \\
--entrypoint /bin/bash \\
-v "\$PWD":/PROJECT/:ro \\
-v "\$PWD"/Documentation-GENERATED-temp/:/RESULT/ \\
--user=\$(id -u):\$(id -g) \\
$OUR_IMAGE ;
}


echo "These functions are now defined FOR THIS terminal window."
echo "    dockrun_$OUR_IMAGE_SHORT, dockbash_$OUR_IMAGE_SHORT"

EOT