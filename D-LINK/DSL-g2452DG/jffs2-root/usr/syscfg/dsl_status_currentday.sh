#!/bin/sh

dsl_status_currentday()
{
	local showtime_info="`xdsl_cli info --stats` | sed -n '/Latest 1 day time/{N;N;N;N;N;N;N;p;}'"

	ATUCCRCErrors=`echo "${showtime_info}" | grep "CRC" | awk '{print $3}'`
	    CRCErrors=`echo "${showtime_info}" | grep "CRC" | awk '{print $2}'`
	ATUCHECErrors=`echo "${showtime_info}" | grep "HEC" | awk '{print $3}'`
	    HECErrors=`echo "${showtime_info}" | grep "HEC" | awk '{print $2}'`
	ATUCFECErrors=`echo "${showtime_info}" | grep "FEC" | awk '{print $3}'`
	    FECErrors=`echo "${showtime_info}" | grep "FEC" | awk '{print $2}'`
	SeverelyErroredSecs=`echo "${showtime_info}"  | grep "SES" | awk '{print $3}'`
	ErroredSecs=`echo "${showtime_info}" | grep "ES" | awk '{print $3}'`
	LossOfFraming=`echo "${showtime_info}" | grep "LOF" | awk '{print $3}'`
	UAS=`echo "${showtime_info}" | grep "UAS" | awk '{print $3}'`

	ATUCLossOfFraming=`echo "${showtime_info}" | sed -n '/Total time/{N;N;N;N;N;N;N;p;}' | grep "LOF" | awk '{print $3}'`
  ATUCLossOfSignal=`echo "${showtime_info}" | sed -n '/Total time/{N;N;N;N;N;N;N;p;}' | grep "LOS" | awk '{print $3}'`
  ATUCErroredSecs=`echo "${showtime_info}" | sed -n '/Total time/{N;N;N;N;N;N;N;p;}' | grep "ES" | awk '{print $3}'`
  
#	echo "ATUCCRCErrors=${ATUCCRCErrors}"
#	echo "CRCErrors=${CRCErrors}"
#	echo "ATUCHECErrors=${ATUCHECErrors}"
#	echo "HECErrors=${HECErrors}"
#	echo "ATUCFECErrors=${ATUCFECErrors}"
#	echo "FECErrors=${FECErrors}"
#	echo "SeverelyErroredSecs=${SeverelyErroredSecs}"
#	echo "ErroredSecs=${ErroredSecs}"
#	echo "LossOfFraming=${LossOfFraming}"
#	echo "UAS=${UAS}"

	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCCRCErrors ${ATUCCRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.CRCErrors ${CRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCHECErrors ${ATUCHECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.HECErrors ${HECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCFECErrors ${ATUCFECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.FECErrors ${FECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.SeverelyErroredSecs ${SeverelyErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ErroredSecs ${ErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.LossOfFraming ${LossOfFraming} > /dev/null
	
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCLossOfFraming ${ATUCLossOfFraming} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCLossOfSignal ${ATUCLossOfSignal} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.CurrentDay.ATUCErroredSecs ${ATUCErroredSecs}	> /dev/null
}

dsl_status_currentday

