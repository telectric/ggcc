---
layout: post
title:  "Troubleshooting básico OLT C300"

categories: ftth
tag: redes
---


Comandos de ZXAN product C300 (ZTE Corporation)
-----------------------------------------------

**Recepción de potencia en todas las ont del ramal** 

{% highlight bash %}
show pon power onu-rx gpon-olt_1/2/9

Onu                 Rx power
------------------------------------
gpon-onu_1/2/9:1    -22.070(dbm)
gpon-onu_1/2/9:2    -20.362(dbm)
	·
	·
	·
{% endhighlight %}

**Información detallada sobre una ONT dentro de la rama**

{% highlight bash %}
show gpon onu detail-info gpon-onu_1/2/9:1


ONU interface:         gpon-onu_1/2/9:1
  Name:                ONU-9:1
  Type:                ZTE-F660
  State:               ready
  Admin state:         enable
  Phase state:         working
  Authentication mode: pw
  SN Bind:             disable
  Serial number:       XXXXXXXXX
  Password:            XXXX
  Device ID:
  Description:         ONU-9:1
  Vport mode:          onu
  DBA Mode:            Hybrid
  ONU Status:          enable
  OMCI BW Profile:     enable
  Line Profile:        N/A
  Service Profile:     N/A
  Alarm Profile:       N/A
  Performance Profile: N/A
  ONU Distance:        2366m
  Online Duration:     156h 49m 50s
  FEC:                 none
  1PPS+ToD:            disable
  Multicast encryption:disable
  Multicast encryption current state:N/A
------------------------------------------
       Authpass Time          OfflineTime             Cause
   1   2016-03-27 22:02:11    2016-04-09 15:37:49     DyingGasp
   2   2016-04-09 15:38:52    2016-04-09 17:47:49     LOSi
   3   2016-04-09 17:48:53    2016-04-09 18:00:56     LOSi
   4   2016-04-09 18:02:04    2016-04-18 18:20:52     DyingGasp
   5   2016-04-18 18:21:56    2016-04-29 16:14:49     DyingGasp
   6   2016-04-29 16:15:57    2016-05-09 17:54:30     DyingGasp
   7   2016-05-09 17:55:30    2016-05-22 12:37:18     LOSi
   8   2016-05-22 12:38:17    2016-05-24 20:46:45     LOSi
   9   2016-05-24 20:47:49    2016-07-28 21:29:05     LOSi
  10   2016-07-28 21:30:08    0000-00-00 00:00:00
{% endhighlight %}


**Configuración de la onu/ont**

{% highlight bash %}

show onu running config gpon-onu_1/5/12:3
pon-onu-mng gpon-onu_1/5/12:3
  service BE gemport 1 cos 0 vlan 20
  service RT gemport 2 cos 5 vlan 20
  vlan port eth_0/1 mode transparent
!
{% endhighlight %}

**Configuración de la interfaz de la onu/ont**

{% highlight bash %}
show running-config interface gpon-onu_1/5/12:3
Building configuration...
interface gpon-onu_1/5/12:3
  fec upstream
  sn-bind disable
  vport-mode onu def-map-type 1:1
  tcont 1 name DATA profile 50M
  gemport 1 name DATOS tcont 1
  gemport 2 name VOZ tcont 1 queue 5
  gemport 2 traffic-limit upstream 512K_VOZ downstream 512K_VOZ
  vport 1 map-type cos+vlan
  vport-map 1 1 cos 0 vlan 1074
  vport-map 1 2 cos 5 vlan 1074
  switchport mode hybrid vport 1
  service-port 1 vport 1 user-vlan 1074 vlan 80
  service-port 1 description DATOS
  ip dhcp snooping enable vport 1
  port-identification format FLEXIBLE-SYNTAX sport 1
  dhcpv6-l2-relay-agent enable sport 1
  dhcpv4-l2-relay-agent enable sport 1
  ip-source-guard enable sport 1
  traffic-profile 50M vport 1 direction egress
  security max-mac-learn 1 vport 1
!
end
{% endhighlight %}

**Configuración de la interfaz de toda la rama**

{% highlight bash %}

show running-config interface gpon-olt_1/5/12
Building configuration...
interface gpon-olt_1/5/12
  no shutdown
  linktrap disable
  fec downstream
  onu 1 type modelo_onu pw xxxx vport-mode onu
  onu 2 type modelo_onu pw xxxx vport-mode onu
!
end
{% endhighlight %}

**Mostrar MAC**

{% highlight bash %}
show mac-real-time gpon onu gpon-onu_1/5/12:3
Total mac address : 1

Mac address      Vlan  Type      Port                     Vc        Time

-------------------------------------------------------------------------------
4c09.b4ff.9e78   500   Dynamic   gpon-onu_1/5/12:3        vport 1   N/A
{% endhighlight %}

**Estado del dhcp**

{% highlight bash %}
show ip dhcp snooping dynamic port pon gpon-onu_1/5/12:3



Current online users are 0.
Index MAC addr       IP addr         VLAN State   Interface    Expiration
{% endhighlight %}

**Potencia recibida** 

{% highlight bash %}
show pon power onu-rx gpon-onu_1/5/12:3
Onu                 Rx power
------------------------------------
gpon-onu_1/5/12:3   -20.222(dbm)
{% endhighlight %}

ONT en modo router
------------------

**Configurar onu/ont en modo router**

{% highlight bash %}
configure terminal
pon-onu-mng gpon-onu_1/3/1:1
vlan port eth_0/1 mode tag vlan 832
exit
exit
show onu running config gpon-onu_1/3/1:1
write
{% endhighlight %}

**Configurar onu/ont en modo transparente**

{% highlight bash %}
configure terminal
pon-onu-mng gpon-onu_1/3/1:1
vlan port eth_0/1 mode transparent
exit
exit
show onu running config gpon-onu_1/3/1:1
write
{% endhighlight %}
