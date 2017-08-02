---
layout: post
title:  "Teldat M1: Trobleshooting IP"

categories: teldat
tags: ip
---

Salir de un process
------------------- 

CTRL+p

Troubleshooting IP 
------------------- 

Mostrar el listado de interfaces y sus IP

{% highlight bash %}

*P 3
+protocol ip
IP+interface-addresses
Interface IP Addresses:
-----------------------
ethernet0/1        1.1.1.1/30
direct-ip1         dhcp-negotiated - 172.28.254.34/32
tnip1              172.28.27.25/30
tnip2              172.28.31.197/30
loopback1          100.127.72.219/32
loopback2          172.28.254.34/32
ethernet0/0.2      10.46.116.2/24
ethernet0/0.100    10.146.116.2/24
ethernet0/0.16     10.86.116.2/24
ethernet0/1.463    dhcp-negotiated - 172.28.249.220/29

Special IP Addresses:
---------------------
internal-address    0.0.0.0
management-address  0.0.0.0
router-id           0.0.0.0
global-address      1.1.1.1


{% endhighlight %}

Prueba de ping a la DNS de Google

{% highlight bash %}

+ping 8.8.8.8 num-pings 4 source 10.46.116.2

PING : 56 data bytes
64 bytes from 8.8.8.8: icmp_seq=0. time=130. ms
64 bytes from 8.8.8.8: icmp_seq=1. time=99. ms
64 bytes from 8.8.8.8: icmp_seq=2. time=129. ms
64 bytes from 8.8.8.8: icmp_seq=3. time=125. ms

---- PING Statistics----
4 packets transmitted, 4 packets received, 0% packet loss
round-trip (ms)  min/avg/max = 99/120/130

{% endhighlight %}

Y traceroute

{% highlight bash %}
+traceroute 8.8.8.8 source 10.46.116.2

Press any key to abort.

 Tracing the route to: 8.8.8.8 [],
 Protocol: UDP, 30 hops max, 56 byte packets

 1    77 ms   80 ms   67 ms   172.28.31.198
 2    68 ms   77 ms   76 ms     172.17.9.41
 3    63 ms   75 ms   92 ms      172.30.6.1
 4    81 ms   83 ms   77 ms        10.6.1.1
 5    87 ms   82 ms   74 ms     172.19.0.70
 6     *       *       *       Time exceeded in transit
 7     *       *       *       Time exceeded in transit
 8     *       *       *       Time exceeded in transit
 9    89 ms  192 ms   94 ms  130.206.195.57
10     *       *       *       Time exceeded in transit
11     *       *       *       Time exceeded in transit
12   105 ms  107 ms  119 ms 108.170.253.241
13   134 ms    *       *     209.85.240.251
14   110 ms   97 ms   98 ms         8.8.8.8
 Trace complete.
{% endhighlight %}

Trabla de rutas.

{% highlight bash %}
+dump-routing-table
Type                Dest net/Mask  Cost Age  Next hop(s)

 rip(1)[0]          0.0.0.0/0  [100/2 ] 5   172.28.27.25 (tnip1) (C)
                                        5   172.28.31.197 (tnip2)
sbnt(0)[0]          1.0.0.0/8  [240/1 ] 0   none
 dir(0)[1]          1.1.1.0/30 [  0/1 ] 0   ethernet0/1
sbnt(0)[0]         10.0.0.0/8  [240/1 ] 0   none
stat(1)[0]         10.0.0.0/21 [ 60/1 ] 0   direct-ip1
stat(1)[0]        10.0.6.10/32 [ 60/1 ] 0   172.28.249.221 (ethernet0/1.463)
stat(1)[0]        10.0.6.11/32 [ 60/1 ] 0   direct-ip1
 dir(0)[1]      10.46.116.0/24 [  0/1 ] 0   ethernet0/0.2
 dir(0)[57]      10.46.116.1/32 [  0/1 ] 0   snk
 dir(0)[1]      10.86.116.0/24 [  0/1 ] 0   ethernet0/0.16
 dir(0)[8]      10.86.116.1/32 [  0/1 ] 0   snk
stat(1)[0]      10.113.12.7/32 [ 60/1 ] 0   direct-ip1
stat(1)[0]    10.118.212.28/32 [ 60/1 ] 0   direct-ip1
stat(1)[0]   10.118.213.168/30 [ 60/1 ] 0   direct-ip1

Default gateway in use.
Type Cost Age  Next hop
 rip 2    10  172.28.27.25 (tnip1) (C)
          10  172.28.31.197 (tnip2)

Routing table size: 33 nets (3432 bytes), 33 nets known, 33 shown
{% endhighlight %}


Mostrar el log de eventos
-------------------------

{% highlight bash %}

*process 2
10/12/00 01:00:00  GW.001 System restarted -- M1 1GEWAN 4GESW SLOT1 IPSec SNA VoIP T+ router cold start
10/12/00 01:00:00  GW.002 Portable CGW M1 1GEWAN 4GESW SLOT1 IPSec SNA VoIP T+ Rel 11.01.01.10.07 strtd
10/12/00 01:00:00  GW.005 Bffrs: 12355 avail 12355 idle   fair 573 low 2211
10/12/00 01:00:00  ethernet0/0: PHY is Marvell Switch Fixed MII Phy (01410000)
10/12/00 01:00:00  ethernet0/1: PHY is Marvell 88E1510 (01410dd1)
10/12/00 01:00:00  GW.021 Nt up ifc cellular1/1
.
.
.
{% endhighlight %}


{% highlight bash %}
 +uptime

Date:    Monday, 10/09/17     Time: 08:41:00
Router uptime: 2w5d21h39m17s
{% endhighlight %}

Listar el estado del protocolo TVRP 
-----------------------------------

Introducir lo siguientes comandos

{% highlight bash %}

*process 3

+protocol ip

IP+tvrp

TVRP++list all

              ===== Global TVRP Parameters =====

  TVRP is currently: ENABLED
  TVRP port (UDP):   1985
  Virtual redirects: ENABLED
  Unknown packets:   65517
  Authentication Failed packets:   0


                ===== List of TVRP groups =====

 +------------------------------------------------------------+
 |                      TVRP GROUP:   3                       |
 +------------------------------------------------------------+
   Virtual IP:  10.142.141.1
   Virtual MAC: 00-00-0c-07-ac-03
   Current local IP/Interface: 10.142.141.2
   ACTIVE Router:  10.142.141.3
   STANDBY Router: 10.142.141.2
   Hellotime: 3               Holdtime: 10
   TVRP state:  STANDBY       Previous state:    SPEAK
   Currently  RUNNING         Last event: HI_H_ACT
   Initial: 1           Learn: 0           Listen: 1
   Speak: 2           Standby: 2           Active: 1
     Hello messages -->  sent:    2642,   received:   65491
     Coup messages --->  sent:       0,   received:       0
     Resign messages ->  sent:       0,   received:       0


 +------------------------------------------------------------+
 |                      TVRP GROUP:   1                       |
 +------------------------------------------------------------+
   Virtual IP:  10.42.141.1
   Virtual MAC: 00-00-0c-07-ac-01
   Current local IP/Interface: 10.42.141.2
   ACTIVE Router:  10.42.141.2
   STANDBY Router: 10.42.141.3
   Hellotime: 3               Holdtime: 10
   TVRP state:   ACTIVE       Previous state:   LISTEN
   Currently  RUNNING         Last event: HELO_EXP
   Initial: 1           Learn: 0           Listen: 1
   Speak: 0           Standby: 0           Active: 1
     Hello messages -->  sent:    2636,   received:    2680
     Coup messages --->  sent:       2,   received:       0
     Resign messages ->  sent:       0,   received:       0


{% endhighlight %}
