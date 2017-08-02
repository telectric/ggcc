---
layout: post
title:  "Ejemplos de uso SNMPWALK"

categories: sistemas
---


SNMPwalk
--------

**Prueba de conexión con snmpwalk**

{% highlight bash %}
#snmpwalk -Os -c comunidad_configurada -v 2c ip_equipo_remoto iso.3.6.1.2.1.1.1
sysDescr.0 = STRING: Router model M1 1GEWAN 4GESW SLOT1 IPSec SNA VoIP T+ UP-1 34 3060 CPU QorIQ P101X  S/N: xxx/xxxxxx  Teldat               (c)1996 - 2017
{% endhighlight %}

