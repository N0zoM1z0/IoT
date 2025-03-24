#!/bin/sh

dsl_stats_showtime()
{
	local showtime_info="`xdsl_cli info --showtime`"

	ATUCCRCErrors=`echo "${showtime_info}"  | grep "ATUCCRCErrors" | awk '{print $2}'`
	CRCErrors=`echo "${showtime_info}" | grep "CRCErrors" | awk '{print $2}'`
	ATUCHECErrors=`echo "${showtime_info}" | grep "ATUCHECErrors" | awk '{print $2}'`
	HECErrors=`echo "${showtime_info}" | grep "HECErrors" | awk '{print $2}'`
	ATUCFECErrors=`echo "${showtime_info}" | grep "ATUCFECErrors" | awk '{print $2}'`
	FECErrors=`echo "${showtime_info}" | grep "FECErrors" | awk '{print $2}'`
	SeverelyErroredSecs=`echo "${showtime_info}" | grep "SeverelyErroredSecs" | awk '{print $2}'`
	ErroredSecs=`echo "${showtime_info}" | grep "ErroredSecs" | awk '{print $2}'`
	LossOfFraming=`echo "${showtime_info}" | grep "LossOfFraming" | awk '{print $2}'`
	InitTimeouts=`echo "${showtime_info}" | grep "InitTimeouts" | awk '{print $2}'`
	InitErrors=`echo "${showtime_info}" | grep "InitErrors" | awk '{print $2}'`
	LinkRetrain=`echo "${showtime_info}" | grep "LinkRetrain" | awk '{print $2}'`
	CellDelin=`echo "${showtime_info}" | grep "CellDelin" | awk '{print $2}'`
	TransmitBlocks=`echo "${showtime_info}" | grep "TransmitBlocks" | awk '{print $2}'`
	ReceiveBlocks=`echo "${showtime_info}" | grep "ReceiveBlocks" | awk '{print $2}'`

	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCCRCErrors ${ATUCCRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.CRCErrors ${CRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCHECErrors ${ATUCHECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.HECErrors ${HECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCFECErrors ${ATUCFECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.FECErrors ${FECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.SeverelyErroredSecs ${SeverelyErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ErroredSecs ${ErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.LossOfFraming ${LossOfFraming} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.InitTimeouts ${InitTimeouts} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.InitErrors ${InitErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.LinkRetrain ${LinkRetrain} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.CellDelin ${CellDelin} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.TransmitBlocks ${TransmitBlocks} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ReceiveBlocks ${ReceiveBlocks} > /dev/null
}

dsl_stats_showtime

