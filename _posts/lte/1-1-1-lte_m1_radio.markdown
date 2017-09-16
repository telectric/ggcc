---
layout: post
title:  "TELDAT M1: RADIO LTE"

categories: lte
tag: lte
---

Interfaces radio M1
------------------- 

En los Teldat M1 encontramos dos interfaces radio, `cellular1/0` donde se pueden verificar el estado de la transmisión: 

{% highlight bash %}

NOMBRE_M1 *monitor
Console Operator


NOMBRE_M1  +network cellular1/0


--  AT Console --

NOMBRE_M1  cellular1/0 AT+list
        Daughter Board               = CELLULAR WCDMA DATA card
        Module Manufacturer          = Sierra Wireless, Incorporated
        Module Model                 = MC7455
        Module Firmware              = SWI9X30C_02.20.03.00 r6691 CARMD-EV-FRMWR2 2016/06/30 10:54:05
        Module Boot Version          = SWI9X30C_02.20.03.00 r6691 CARMD-EV-FRMWR2 2016/06/30 10:54:05
        UQCN                         = 9906491 001.001
        Preferred Image              = 02.20.03.00_GENERIC_002.017_000
        Hardware Revision            = 1.0
        IMEI                         = NUMERO_IMEI
        IMSI                         = 214031630866684
        SIM Card ID                  = 8934013081707086853
        Interfaces                   = UMTS LTE
        Data Service Capability      = Nonsimultaneous CS/PS
        Voice Support Capability     = GW_CSFB 1xCSFB
        Maximun TX/RX rate supported = 50000/300000 Kbps
        Module temperature           = 37 deg. C
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

Y `cellular1/1` dondes se muestra la capa de red.

{% highlight bash %}

NOMBRE_M1 +network cellular1/1

-- Direct IP Monitor --

NOMBRE_M1 cellular1/1 NIC+list
        Drop by ping failed          = 0
        Drop by tracert failed       = 0
        Drop by traffic failed       = 0
        Drop by carrier loss         = 0
        Dialers registered           = EECG
        Current dialer registered    = EECG
        State                        = (9) CONNECT
        Call request                 = 1
        Connections established      = 1
        Access Point Name            = nombre.apn.com
        Total connection time        = 1 day 17 hours 27 minutes 10 seconds
        Current connection time      = 1 day 17 hours 27 minutes 10 seconds
        Time to establish connection = 5 sec
        Hardware Interface address   = CAACFFB60108
        Low layer link state         = Up
        IP Interface addr.(reported) = dirección_IP
        DNS primary server address   = DNS_IP
        DNS secondary server address = DNS_IP

{% endhighlight %}


cellular1/0
-----------

Para mostrar la calidad de la conexión:

{% highlight bash %}


NOMBRE_M1  cellular1/0 AT+network quality

========================================
..:: NETWORK SIGNAL QUALITY ::..
========================================

        Network technology currently in use: E-UTRAN LTE
        Reference Signal Strength Indicator (RSSI): -62 (dBm)
        Reference Signal Received Power (RSRP): -90 (dBm)
        Reference Signal Received Quality (RSRQ): -7 (dB)
        Signal to noise ratio (SNR): 2 (dB)
        Rx chain 0 is tuned to a channel with instantaneous values:
                Rx level: -64 dBm, EcIo: -6 dB, RSRP: -88 dBm, Phase: 0 deg
        Rx chain 1 is tuned to a channel with instantaneous values:
                Rx level: -65 dBm, EcIo: -6 dB, RSRP: -89 dBm, Phase: 68 deg

{% endhighlight %}

Para mostrar la información de la celda a la que está conectada, la siguiente es correcta porque la conexión es LTE, al final del 

comando se muestran los vecinos de la celda.

{% highlight bash %}

NOMBRE_M1 cellular1/0 AT+network cell-info
Querying...Please wait...

========================================
..:: NETWORK CELL INFO ::..
========================================

- LTE intrafrequency info:
        UE is not in idle mode
        PLMN ID coded: XXXXX
        Tracking Area Code: HHHH (hexadecimal)
        Global cell ID in the system information block HHHHHHHH (hexadecimal)
        E-UTRA absolute radio frequency channel number of the serving cell: XXXX
        LTE serving cell ID: XXX
        Priority for serving frequency: 0
        S non-intra search threshold to control non-intrafrequency searches: 0
        Serving cell low threshold: 0
        S intra search threshold: 0
        Cell #1
                Physical cell ID: 175
                Current RSRQ as measured by L1: -6 (dB)
                Current RSRP as measured by L1: -88 (dBm)
                Current RSSI as measured by L1: -62 (dBm)
                Cell selection Rx Level: 0

- LTE interfrequency info:
        UE is not in idle mode
        Cell #1
        E-UTRA absolute radio frequency channel number: 6200
        Cell Srxlev low threshold:  0
        Cell Srxlev high threshold: 0
        Cell reselection priority: 0
        Cell #1
                Physical cell ID: 247
                Current RSRQ: -7 (dB)
                Current RSRP: -80 (dBm)
                Current RSSI: -66 (dBm)
                Cell selection Rx Level
        Cell #2
                Physical cell ID: 248
                Current RSRQ: -14 (dB)
                Current RSRP: -92 (dBm)
                Current RSSI: -66 (dBm)
                Cell selection Rx Level
        Cell #3
                Physical cell ID: 302
                Current RSRQ: -20 (dB)
                Current RSRP: -102 (dBm)
                Current RSSI: -66 (dBm)
                Cell selection Rx Level

- LTE info - Neighboring GSM:
        UE is not in idle mode

- LTE info - Neighboring WCDMA:
        UE is not in idle mode

{% endhighlight %}

El siguiente comando aporta información de la conexión y de la capa de red.

{% highlight bash %}

NOMBRE_M1 cellular1/0 AT+network status
Querying...Please wait...

========================================
..:: NETWORK STATUS ::..
========================================

        SIM status: OK
        Registration state: Registered
        Public Land Mobile Network code: XXXXX
        Public Land Mobile Network name: OPERADOR
        Network technology currently in use: LTE
        Current Service Domain registered: CS/PS (capable CS/PS)
        Current Roaming status: Off
        3GPP Cell ID: HHHHHHH
        Radio Band EUTRABand3_1800_DCS
        LTE Rx chan: 1849
        LTE Tx chan: 19849
        LTE Network Bandwidth: 20 MHz
        LTE Advanced Carrier Aggregation Info:
                Secondary Cell Info:
                        Downlink Bandwidth: 10 MHz
                        Frequency: 6200
                        LTE Band Value: E-UTRA Band 20
                        Physical cell ID: 247
                        Cell State: INACTIVE
                Primary Cell Info
                        Downlink Bandwidth: 20 MHz
                        Frequency: 1849
                        LTE Band Value: E-UTRA Band 3
                        Physical cell ID: XXX
        PS Attach State: Attached
        EMM State: (2) Registered
        EMM Substate: (0) Normal Service
        EMM Connection: (2) RRC Connected
        LTE Tracking Area Code (TAC): HHHH
        RX level (dBm): -63
        Coverage level: 5 (*****)

========================================
..:: NETWORK DATA CONNECTION ::..
========================================

        Connection status: Connected
        Radio Access Technology: LTE
        Traffic channel status: Active
        Uplink Flow control: Deactivated
        Max. TX channel rate (bps): 50000000
        Max. RX channel rate (bps): 300000000
        IPv4 address: DIRECCIÓN_IP
        IPv4 mask: MÁSCARA
        IPv4 gateway: DIRECCIÓN_IP_PUERTA_DE_ENLACE
        IPv4 primary DNS: DNS_1
        IPv4 secondary DNS: DNS_2

{% endhighlight %}

cellular1/1
-----------

En esta interfaz podremos ver el tráfico instantaneo.

{% highlight bash %}

NOMBRE_M1 cellular1/1 NIC+bitrate

             Interface cellular1/1
 Trx rate ( bps/pps)  Rcv rate ( bps/pps)
 ----------------------------------------
      10504/   10         6872/   13
      11200/   10         2688/    4
       2688/    4         2240/    4

{% endhighlight %}

O las estadísticas en otros periodos

{% highlight bash %}

NOMBRE_M1 cellular1/1 NIC+statistics layer3-stats
Total
Rx pkts:        493461   Tx pkts:        586633
Rx bytes:     45433214   Tx bytes:     69423440
Throughput (bps)
Last sec   Rx:         6752    Tx:        20248
Last 1 min Rx:         3363    Tx:         7750
Last 5 min Rx:         2668    Tx:         5153

{% endhighlight %}
