---
layout: post
title:  "Teldat M1: Comandos LTE"

categories: teldat
tags: teldat
---

Troubleshooting 4G
------------------ 

{% highlight bash %}

*monitor

+network cellular1/0

cellular1/0 AT+list
        Daughter Board               = CELLULAR WCDMA DATA card
        Module Manufacturer          = Sierra Wireless, Incorporated
        Module Model                 = MC7455
        Module Firmware              = SWI9X30C_02.20.03.00 r6691 CARMD-EV-FRMWR2 2016/06/30 10:54:05
        Module Boot Version          = SWI9X30C_02.20.03.00 r6691 CARMD-EV-FRMWR2 2016/06/30 10:54:05
        UQCN                         = 9906491 001.001
        Preferred Image              = 02.20.03.00_GENERIC_002.017_000
        Hardware Revision            = 1.0
        IMEI                         = 359072060719883
        IMSI                         = 214031530536273
        SIM Card ID                  = 8934011061722184273
        Interfaces                   = UMTS LTE
        Data Service Capability      = Nonsimultaneous CS/PS
        Voice Support Capability     = GW_CSFB 1xCSFB
        Maximun TX/RX rate supported = 50000/300000 Kbps
        Module temperature           = 42 deg. C
        Drop by ping failed          = 0
        Drop by tracert failed       = 0
        Drop by traffic failed       = 0
        Dialers registered           = none
        Current dialer registered    = none
        State                        = (1) DISCONNECT
        Call request                 = 0
        Telephone number             =
        Total connection time        = 0 seconds
        Current connection time      = 0 seconds
        Time to establish connection = 0 sec

{% endhighlight %}


******************** WCDMA ********************
-----------------------------------------------

{% highlight bash %}

cellular1/0 AT+network cell-info
Querying...Please wait...

========================================
..:: NETWORK CELL INFO ::..
========================================

- UMTS info:
        Cell ID: 21747
        PLMN ID coded: 21403
        Location Area Code: 13130
        UTRA absolute RF channel number: 10688
        Primary Scrambling Code: 64
        RSCP: -121 (dBm)
        ECIO: -31 (dB)
        WCDMA Cell #1
                UTRA absolute RF channel number: 10688
                PSC: 56
                RSCP: -113 (dBm)
                ECIO: -19 (dB)

- UMTS cellid avail info:
        Cell ID: 055354F3

- WCDMA info - Neighboring LTE:
        RRC state: 4

cellular1/0 AT+network status
Querying...Please wait...

========================================
..:: NETWORK STATUS ::..
========================================

        SIM status: OK
        Registration state: Registered
        Public Land Mobile Network code: 21403
        Public Land Mobile Network name: Orange
        Network technology currently in use: WCDMA <<<<<<<<<<<<<<<<<<<<<< Tecnología
        Current Service Domain registered: CS/PS (capable CS/PS)
        Current Roaming status: Off
        3GPP Location Area Code: 334A
        3GPP Cell ID: 055354F3
        Radio Band WCDMA2100
        Channel 10688
        WCDMA Primary Scrambling Code (PSC): 0040
        WCDMA High-Speed Call Status: DC-HSDPA+/64QAM/HSUPA
        WCDMA High-Speed Service Indication: HSDPA/HSUPA
        EcIo (dB): -3
        RX level (dBm): -99
        Coverage level: 2 (**   ) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Cobertura

========================================
..:: NETWORK DATA CONNECTION ::..
========================================

        Connection status: Connected
        Radio Access Technology: WCDMA HSUPA HSDPA+ 64QAM 
        Traffic channel status: Active
        Uplink Flow control: Deactivated
        Max. TX channel rate (bps): 8000000
        Max. RX channel rate (bps): 8682000
        IPv4 address: 172.28.254.152
        IPv4 mask: 255.255.255.240
        IPv4 gateway: 172.28.254.153
        IPv4 primary DNS: 85.62.229.133
        IPv4 secondary DNS: 85.62.229.134

cellular1/0 AT+network performance

RSCP (-dBm) measured during the last 60 samples
     111111111111111111111111111111111111111111111111111111111111
     222222222222222222222222222222222222222222222222222222222222
 20_ 111111111111111111111111111111111111111111111111111111111111
 30_|
 40_|
 50_|
 60_|
 70_|
 80_|
 90_|
100_|
110_|
120_|____________________________________________________________
     older                                                 newest

EcIo (-dB) measured during the last 60 samples


  0_ 336245422254434444436345743235233755424255548533442476445433
  2_|
  4_|.. :   :::   .     . .    .:. :..    : :      ..  :       ..
  6_|:: ::.::::.::::::::: ::. ::::.::: ..::::...: .::::::  ::.:::
  8_|::::::::::::::::::::::::.::::::::.:::::::::: :::::::.:::::::
 10_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 12_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 14_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 16_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 18_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 20_|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     older                                                 newest


{% endhighlight %}

******************** LTE ********************
---------------------------------------------

{% highlight bash %}


cellular1/0 AT+network cell-info
Querying...Please wait...

========================================
..:: NETWORK CELL INFO ::..
========================================

- LTE intrafrequency info:
        UE is not in idle mode
        PLMN ID coded: 21403
        Tracking Area Code: 346c
        Global cell ID in the system information block 09408f0b
        E-UTRA absolute radio frequency channel number of the serving cell: 1849
        LTE serving cell ID: 331 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< CELL
        Priority for serving frequency: 0
        S non-intra search threshold to control non-intrafrequency searches: 0
        Serving cell low threshold: 0
        S intra search threshold: 0
        Cell #1
                Physical cell ID: 331
                Current RSRQ as measured by L1: -7 (dB)  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< RSRQ (mirar tabla)
                Current RSRP as measured by L1: -105 (dBm) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< RSRP (mirar tabla)
                Current RSSI as measured by L1: -78 (dBm)
                Cell selection Rx Level: 0
        Cell #2
                Physical cell ID: 384
                Current RSRQ as measured by L1: -16 (dB)
                Current RSRP as measured by L1: -117 (dBm)
                Current RSSI as measured by L1: -93 (dBm)
                Cell selection Rx Level: 0
        Cell #3
                Physical cell ID: 17
                Current RSRQ as measured by L1: -19 (dB)
                Current RSRP as measured by L1: -119 (dBm)
                Current RSSI as measured by L1: -91 (dBm)
                Cell selection Rx Level: 0
        Cell #4
                Physical cell ID: 407
                Current RSRQ as measured by L1: -20 (dB)
                Current RSRP as measured by L1: -121 (dBm)
                Current RSSI as measured by L1: -91 (dBm)
                Cell selection Rx Level: 0

- LTE interfrequency info:
        UE is not in idle mode

- LTE info - Neighboring GSM:
        UE is not in idle mode

- LTE info - Neighboring WCDMA:
        UE is not in idle mode

{% endhighlight %}

Información de red

{% highlight bash %}

cellular1/0 AT+network status
Querying...Please wait...

========================================
..:: NETWORK STATUS ::..
========================================

        SIM status: OK
        Registration state: Registered
        Public Land Mobile Network code: 21403
        Public Land Mobile Network name: Orange
        Network technology currently in use: LTE <<<<<<<<<<<<<<<<<<<<<< Tecnología
        Current Service Domain registered: CS/PS (capable CS/PS)
        Current Roaming status: Off
        3GPP Cell ID: 09408F0B
        Radio Band EUTRABand3_1800_DCS
        LTE Rx chan: 1849
        LTE Tx chan: 19849
        LTE Network Bandwidth: 20 MHz
        LTE Advanced Carrier Aggregation Info: NOT ASSIGNED
        PS Attach State: Attached
        EMM State: (2) Registered
        EMM Substate: (0) Normal Service
        EMM Connection: (2) RRC Connected
        LTE Tracking Area Code (TAC): 346c
        RX level (dBm): -79
        Coverage level: 3 (***  ) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Cobertura

========================================
..:: NETWORK DATA CONNECTION ::..
========================================

        Connection status: Connected
        Radio Access Technology: LTE
        Traffic channel status: Active
        Uplink Flow control: Deactivated
        Max. TX channel rate (bps): 0
        Max. RX channel rate (bps): 0
        IPv4 address: 172.28.254.28
        IPv4 mask: 255.255.255.248
        IPv4 gateway: 172.28.254.29
        IPv4 primary DNS: 85.62.229.133
        IPv4 secondary DNS: 85.62.229.134

{% endhighlight %}

Información de la celda

{% highlight bash %}

cellular1/0 AT+network cell-info
Querying...Please wait...

========================================
..:: NETWORK CELL INFO ::..
========================================

- LTE intrafrequency info:
        UE is not in idle mode
        PLMN ID coded: 21403
        Tracking Area Code: 346c
        Global cell ID in the system information block 09408f0b
        E-UTRA absolute radio frequency channel number of the serving cell: 1849
        LTE serving cell ID: 331
        Priority for serving frequency: 0
        S non-intra search threshold to control non-intrafrequency searches: 0
        Serving cell low threshold: 0
        S intra search threshold: 0
        Cell #1
                Physical cell ID: 331
                Current RSRQ as measured by L1: -8 (dB)
                Current RSRP as measured by L1: -106 (dBm)
                Current RSSI as measured by L1: -78 (dBm)
                Cell selection Rx Level: 0
        Cell #2
                Physical cell ID: 384
                Current RSRQ as measured by L1: -16 (dB)
                Current RSRP as measured by L1: -118 (dBm)
                Current RSSI as measured by L1: -93 (dBm)
                Cell selection Rx Level: 0
        Cell #3
                Physical cell ID: 17
                Current RSRQ as measured by L1: -19 (dB)
                Current RSRP as measured by L1: -120 (dBm)
                Current RSSI as measured by L1: -90 (dBm)
                Cell selection Rx Level: 0
        Cell #4
                Physical cell ID: 407
                Current RSRQ as measured by L1: -20 (dB)
                Current RSRP as measured by L1: -122 (dBm)
                Current RSSI as measured by L1: -91 (dBm)
                Cell selection Rx Level: 0

- LTE interfrequency info:
        UE is not in idle mode

- LTE info - Neighboring GSM:
        UE is not in idle mode

- LTE info - Neighboring WCDMA:
        UE is not in idle mode

{% endhighlight %}
