#!/bin/sh

dsl_stats_lastshowtime()
{
	ATUCCRCErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCCRCErrors`
	CRCErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.CRCErrors`
	ATUCHECErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCHECErrors`
	HECErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.HECErrors`
	ATUCFECErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ATUCFECErrors`
	FECErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.FECErrors`
	SeverelyErroredSecs=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.SeverelyErroredSecs`
	ErroredSecs=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ErroredSecs`
	LossOfFraming=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.LossOfFraming`
	InitTimeouts=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.InitTimeouts`
	InitErrors=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.InitErrors`
	LinkRetrain=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.LinkRetrain`
	CellDelin=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.CellDelin`
	TransmitBlocks=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.TransmitBlocks`
	ReceiveBlocks=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.Showtime.ReceiveBlocks`
	ShowtimeStart=`cfgcmd get InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.ShowtimeStart`

	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.ATUCCRCErrors ${ATUCCRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.CRCErrors ${CRCErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.ATUCHECErrors ${ATUCHECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.HECErrors ${HECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.ATUCFECErrors ${ATUCFECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.FECErrors ${FECErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.SeverelyErroredSecs ${SeverelyErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.ErroredSecs ${ErroredSecs} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.LossOfFraming ${LossOfFraming} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.InitTimeouts ${InitTimeouts} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.InitErrors ${InitErrors} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.LinkRetrain ${LinkRetrain} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.CellDelin ${CellDelin} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.TransmitBlocks ${TransmitBlocks} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Stats.LastShowtime.ReceiveBlocks ${ReceiveBlocks} > /dev/null
	cfgcmd sset InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.LastShowtimeStart ${ShowtimeStart} > /dev/null
}

dsl_stats_lastshowtime

