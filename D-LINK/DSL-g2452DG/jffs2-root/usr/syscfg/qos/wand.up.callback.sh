#!/bin/sh

# usage: linkup_callback.sh

S_DIR="/tmp/.qos"

. /usr/syscfg/qos/wan.param.export.sh

${S_DIR}/mngmt.config.sh
${S_DIR}/queue.config.sh

