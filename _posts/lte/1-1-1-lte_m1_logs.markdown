---
layout: post
title:  "TELDAT M1: LOGS LTE"

categories: lte
tag: lte
---

LOG M1 LTE
---------- 

En primer lugar accederemos remotamente al equipo mediante telnet os ssh a la looback desde el equipo de gestión dispuesto para ello.

Una vez en el equipo resulta de utilidad revisar el log de este, para ello accedemos al menú `process 2` que listará los útimos eventos. Al tratarese de un acceso LTE podemos activar un log específico para obtener mayor información.

Para activar las trazas AT debemos entrar en modo `monitor` o `process 3`.

{% highlight bash %}

NOMBRE_M1* monitor
NOMBRE_M1+

{% endhighlight %}

Después en `event`

{% highlight bash %}

NOMBRE_M1+event
NOMBRE_M1 ELS+
NOMBRE_M1 ELS+enable trace subsystem AT ALL

{% endhighlight %}

Si queremos verificar el eventos por pantalla saldremos de `process 3` mediante `CTRL+p` y accederemos a `Proccess 2`

{% highlight bash %}

NOMBRE_M1 *process 2
12/03/17 09:52:03  AT.020 ATCMD-->AT+COPS=3,2;+COPS?;+CGREG?;!PCTEMP? intf cellular1/0
12/03/17 09:52:03  AT.020 ATRSP-->+COPS: 0,2,"21403",7 intf cellular1/0
12/03/17 09:52:03  AT.020 ATRSP-->+CGREG: 2,1,"FFFE","DF4250B",7 intf cellular1/0
12/03/17 09:53:03  AT.020 ATCMD-->AT+COPS=3,2;+COPS?;+CGREG?;!PCTEMP? intf cellular1/0
12/03/17 09:53:03  AT.020 ATRSP-->+COPS: 0,2,"21403",7 intf cellular1/0
12/03/17 09:53:03  AT.020 ATRSP-->+CGREG: 2,1,"FFFE","DF4250B",7 intf cellular1/0
{% endhighlight %}

Los eventos anteriores muestran la operación normal del la tarjeta LTE conectando con el eNodeB --E-UTRAN Node B/Evolved Node B--, sustituyendo `trace` por syslog se guararán los eventos en el log del sistema. Si se desea eliminar la aparición de esta información ejecutaremos lo siguiente estando en `process 3`.

{% highlight bash %}

NOMBRE_M1+event
NOMBRE_M1 ELS+
NOMBRE_M1 ELS+disable trace subsystem AT ALL

{% endhighlight %}

Si queremos ver los log/trazas activas podemos ejecutar

{% highlight bash %}

NOMBRE_M1 ELS+list active AT
Actives      Count   Trace   Syslog  Snmp-Trap
AT.001       1       off     on      off

{% endhighlight %}

Otro log que puede ser útil ya que estamos aquí es el que muestra las conexiones, reinicios y el salvado de configuraciones.

{% highlight bash %}

NOMBRE_M1 ELS+nvrlog list 100

 12/03/17 11:13:02 -5- Remote terminal disconnected

 11/24/17 13:06:13 -5- Configuration saved on Flash

 09/04/17 12:48:27 -3- Restart issued by the user

 09/04/17 12:46:28 -5- FTP server ready, access from 62.36.193.80

{% endhighlight %}

Desde `ELS+` se podrán ver los logs también con `ELS+ view history`.

