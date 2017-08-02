---
layout: post
title:  "Juniper: Troubleshooting BGP"

categories: juniper
tags: bgp
---


Enrutamiento BGP
----------------

{% highlight bash %}
user@host> show version | match model
Model: mx480
{% endhighlight %}

Sacamos el vecino y el tiempo que lleva establecida la sesión.

{% highlight bash %}

user@host> show bgp summary instance ROUTE_TABLE
Groups: 2 Peers: 2 Down peers: 0
Table          Tot Paths  Act Paths Suppressed    History Damp State    Pending
ROUTE_TABLE.inet.0
                    1898        902          0          0          0          0
ROUTE_TABLE.inet6.0
                       0          0          0          0          0          0
ROUTE_TABLE.mdt.0
                       0          0          0          0          0          0
Peer                     AS      InPkt     OutPkt    OutQ   Flaps Last Up/Dwn State|#Active/Received/Accepted/Damped...
172.17.9.105          65001     125884     129946       0       3 2w5d 16:11:00 Establ
  ROUTE_TABLE.inet.0: 12/13/13/0
172.17.9.109          65001     126268     130889       0       0 2w5d 17:33:52 Establ
  ROUTE_TABLE.inet.0: 0/13/13/0

{% endhighlight %}

Revisamos si se recive la ruta de las WAN por BGP

{% highlight bash %}

user@host> show route receive-protocol bgp 172.17.9.105 table ROUTE_TABLE

ROUTE_TABLE.inet.0: 1155 destinations, 2153 routes (1155 active, 0 holddown, 0 hidden)
  Prefix                  Nexthop              MED     Lclpref    AS path
* 0.0.0.0/0               172.17.9.105         1                  65001 I
* 10.0.4.10/32            172.17.9.105                            65001 I
* 10.0.4.11/32            172.17.9.105                            65001 I
  10.0.4.12/32            172.17.9.105                            65001 I
* 10.0.5.10/32            172.17.9.105                            65001 I
* 10.0.5.11/32            172.17.9.105                            65001 I
* 10.0.6.10/32            172.17.9.105                            65001 I
* 10.0.6.11/32            172.17.9.105                            65001 I
* 10.0.7.10/32            172.17.9.105                            65001 I
* 10.0.7.11/32            172.17.9.105                            65001 I
* 10.0.150.136/30         172.17.9.105                            65001 I
* 10.0.150.140/30         172.17.9.105                            65001 I
* 172.17.9.208/30         172.17.9.105                            65001 I

{% endhighlight %}

Para ver el local preference de un prefijo (10.0.2.10/32) usaremos el siguiente comando

{% highlight bash %}

user@host> show route table ROUTE_TABLE 10.0.2.10/32

ROUTE_TABLE.inet.0: 515 destinations, 917 routes (515 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

10.0.2.10/32       *[BGP/170] 2w5d 16:31:05, localpref 160 <<<<<<<<<<<<<<< Principal
                      AS path: 65001 I, validation-state: unverified
                    > to 172.17.9.89 via ae2.10
                    [BGP/170] 2w5d 17:53:52, localpref 120 <<<<<<<<<<<<<<< Respaldo
                      AS path: 65001 I, validation-state: unverified
                    > to 172.17.9.93 via ae8.10

{% endhighlight %}


Mismo prefijo observado desde el PE de respaldo.

{% highlight bash %}

user@host2> show route table ROUTE_TABLE 10.0.2.10/32

ROUTE_TABLE.inet.0: 154 destinations, 374 routes (154 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

10.0.2.10/32       *[BGP/170] 2w5d 16:34:00, localpref 160, from 10.34.1.110
                      AS path: 65001 I, validation-state: unverified
                    > to 10.34.211.50 via ae0.0, Push 18, Push 35047(top)
                      to 10.34.211.54 via ae1.0, Push 18, Push 153231(top)
                    [BGP/170] 2w5d 16:33:59, localpref 160, from 10.34.1.125
                      AS path: 65001 I, validation-state: unverified
                    > to 10.34.211.50 via ae0.0, Push 18, Push 35047(top)
                      to 10.34.211.54 via ae1.0, Push 18, Push 153231(top)
                    [BGP/170] 02:15:42, localpref 80
                      AS path: 65001 I, validation-state: unverified
                    > to 172.17.9.129 via ae2.10

{% endhighlight %}

Listado de Vlan configurado en JUNOS
------------------------------------

{% highlight bash %}
user@CPD> show version | match model
Model: mx80
{% endhighlight %}

Filtramos en las interfaces del router para encontrar las VLAN configuradas en la sede ED6V7-25Q.


{% highlight bash %}

user@CPD> show interfaces descriptions | match CODIGO_SEDE
gr-1/1/0.742    up    up   CODIGO_SEDE
gr-1/1/0.1126   up    up   CODIGO_SEDE_2

{% endhighlight %}


Para saber las IP asignadas a las interfaces se emplea la "coletilla" terse, en este caso se trata de un túnel GRE.


{% highlight bash %}

user@CPD> show interfaces terse| match gr-1/1/0.742
gr-1/1/0.742            up    up   inet     172.28.27.62/30

user@CPD> show interfaces terse| match gr-1/1/0.1126
gr-1/1/0.1126           up    up   inet     172.28.31.234/30

{% endhighlight %}

Para obtener la configuración de las interfaces VLAN, la principal y la mochila, como se observa el túnel en los servicios 4G se establece contra la IP WAN.

{% highlight bash %}

user@CPD> show configuration interfaces gr-1/1/0 | display set | match 742
set interfaces gr-1/1/0 unit 742 description CODIGO_SEDE
set interfaces gr-1/1/0 unit 742 point-to-point
set interfaces gr-1/1/0 unit 742 tunnel source 10.0.6.11
set interfaces gr-1/1/0 unit 742 tunnel destination 172.28.254.25
set interfaces gr-1/1/0 unit 742 family inet mtu 1432
set interfaces gr-1/1/0 unit 742 family inet filter input MF_INPUT_GRE_2
set interfaces gr-1/1/0 unit 742 family inet address 172.28.27.62/30
set interfaces gr-1/1/0 unit 742 copy-tos-to-outer-ip-header

user@CPD> show configuration interfaces gr-1/1/0 | display set | match 1126
set interfaces gr-1/1/0 unit 1126 description CODIGO_SEDE_2
set interfaces gr-1/1/0 unit 1126 point-to-point
set interfaces gr-1/1/0 unit 1126 tunnel source 10.0.6.10
set interfaces gr-1/1/0 unit 1126 tunnel destination 172.28.249.211
set interfaces gr-1/1/0 unit 1126 family inet mtu 1432
set interfaces gr-1/1/0 unit 1126 family inet filter input MF_INPUT_GRE_2
set interfaces gr-1/1/0 unit 1126 family inet address 172.28.31.234/30
set interfaces gr-1/1/0 unit 1126 copy-tos-to-outer-ip-header

{% endhighlight %}

Enrutamiento BGP
----------------

Sacamos el vecino y el tiempo que lleva establecida la sesión.

{% highlight bash %}

user@CPD> show bgp summary
Groups: 1 Peers: 1 Down peers: 0
Table          Tot Paths  Act Paths Suppressed    History Damp State    Pending
inet.0
                    1002       1001          0          0          0          0
Peer                     AS      InPkt     OutPkt    OutQ   Flaps Last Up/Dwn State|#Active/Received/Accepted/Damped...
172.17.9.106          12479     129079     125139       0      19 2w5d 13:23:28 1001/1002/1002/0     0/0/0/0

{% endhighlight %}

Revisamos si se recive la ruta de las WAN por BGP

{% highlight bash %}

user@CPD> show route protocol bgp receive-protocol bgp 172.17.9.106 172.28.254.25 table inet.0

inet.0: 1502 destinations, 1503 routes (1502 active, 0 holddown, 0 hidden)
  Prefix                  Nexthop              MED     Lclpref    AS path
* 172.28.254.25/32        172.17.9.106         2                  12479 I

user@CPD> show route protocol bgp receive-protocol bgp 172.17.9.106 172.28.249.211 table inet.0

inet.0: 1502 destinations, 1503 routes (1502 active, 0 holddown, 0 hidden)
  Prefix                  Nexthop              MED     Lclpref    AS path
* 172.28.249.211/32       172.17.9.106         2                  12479 I

{% endhighlight %}

La WAN se recibe por BGP en los CPD

{% highlight bash %}

user@CPD> show route 172.28.254.152

inet.0: 566 destinations, 566 routes (566 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

172.28.254.152/32  *[BGP/140] 1w5d 14:08:39, MED 2, localpref 100
                      AS path: 12479 I, validation-state: unverified
                    > to 172.17.9.98 via ae0.10

PROBES.inet.0: 2513 destinations, 2575 routes (2513 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

172.28.254.152/32  *[BGP/140] 1w5d 14:08:39, MED 2, localpref 100
                      AS path: 12479 I, validation-state: unverified
                    > to 172.17.9.98 via ae0.10

{% endhighlight %}

Enrutamiento RIP
----------------

En este caso se observa que no se reciben rutas, el túnel debe estar caído.

{% highlight bash %}

user@CPD> show rip neighbor | match 742
gr-1/1/0.742         Dn zero-len        zero-len        mcast  both       1

user@CPD> show rip neighbor | match 1126
gr-1/1/0.1126        Dn zero-len        zero-len        mcast  both       1

{% endhighlight %}
