#!/bin/sh
# 
# set dsl attribute and enable dsl-line
# 

. /usr/syscfg/dsl.utils.sh

#check if G3 is ready
if [ `is_dev_ready` != "1" ]; then
        exit 0
fi

dsl_lock_flag="/tmp/dsl_lock_flag"
#waiting for unlock
while [ -f ${dsl_lock_flag} ]
do
        #this means this script already been called and not finish yet.
        usleep 100
done
#create lock flag
touch ${dsl_lock_flag}

DSL_LINE_Enable="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Enable)"
DSL_BS_Enable="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.BitSwapEnable)"
DSL_SRA_Enable="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.SRAEnable)"
DSL_US0_Enable="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.US0Enable)"
DSL_AllowedProfiles="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.AllowedProfiles)"
DSL_StandardsSupported="$(cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.StandardsSupported)"

if [ "${DSL_LINE_Enable}" = "0" ]; then
	xdsl_cli link --down
else
	profile="all"
	standards="all"

	if [ -n "${DSL_AllowedProfiles}" ]; then
		profile="$(gen_profile ${DSL_AllowedProfiles})"
	fi
	if [ -n "${DSL_StandardsSupported}" ]; then
		standards="$(gen_standards ${DSL_StandardsSupported})"
	fi

	xdsl_cli link --down
	if [ "${DSL_BS_Enable}" == "1" ]; then
		xdsl_cli set --bitswap on
	else
		xdsl_cli set --bitswap off
	fi

	if [ "${DSL_US0_Enable}" == "1" ]; then
		xdsl_cli set --us0 on
	else
		xdsl_cli set --us0 off
	fi
	
	if [ "${DSL_SRA_Enable}" == "1" ]; then
		xdsl_cli set --sra on
	else
		xdsl_cli set --sra off
	fi

	xdsl_cli set --standard ${standards} --profile ${profile}
	xdsl_cli link --up
fi

#delete lock flag
rm -f ${dsl_lock_flag}
