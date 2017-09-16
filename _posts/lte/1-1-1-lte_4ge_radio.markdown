---
layout: post
title:  "TELDAT 4GE: RADIO LTE"

categories: lte
tag: lte
---

Acceso 4GE desde M1
-------------------

El equipo 4GE está conectado al M1 mediante una conexión ethernet, para acceder a él serán necesario hacer telnet a la IP adecuada.

{% highlight bash %}


NOMBRE_M1 *process 3
Console Operator


NOMBRE_M1 +protocol ip

-- IP protocol monitor --

NOMBRE_M1 IP+telnet IP_4GE
Trying to connect...
(Press Control S to come back to local router)
Connection established



4Ge login...


User: usuario
Password: ******



Teldat               (c)2001-2017

Router model 4Ge 35 1 CPU QorIQ P101X  S/N: 809/22174
1 LAN, 1 WWAN Line
CIT software version: 11.01.02 Mar 24 2017 21:40:18




4Ge *
{% endhighlight %}



Interfaces radio 4GE
--------------------

Las gestión de las interfaces radio es idéntica a las del M1 teniendo en cuenta que para acceder a la gestión es necesario usar 

`monitor` ya que `process 3` no es reconocido por este modelo.


{% highlight bash %}

4Ge *monitor
Console Operator


4Ge +
{% endhighlight %}
