From: "Juan Antonio Zapatero Campo" <jazc@gmvsistemas.es>
Subject: Force mono audio playback to go through left channel.
Date: Fri, 3 Mar 2006 13:50:25 +0100
Message-ID: <000901c63ec1$0abce680$8ca8a8c0@gmvsistemas.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPartTM-000-6c278fd8-d76a-47af-9c8f-bc31ef3e231e"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------=_NextPartTM-000-6c278fd8-d76a-47af-9c8f-bc31ef3e231e
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0006_01C63EC9.6C7A2290"

------=_NextPart_000_0006_01C63EC9.6C7A2290
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,
first let me introduce a little bit what I am trying to do so that you can =
give me best help. I am building a onboard system for city-buses, which tak=
es car of different tasks. Some of them are VoIP calling, audio reporting t=
o passengers and external speaker. To make it possible through just one ste=
reo soundcard, I need to force voice (the one caming out of alsa drivers) t=
o go into one of stereo channels, let's say on the left one. Is there any w=
ay of performing this through the API?

Thanks a lot.
______________________
Este mensaje, y en su caso, cualquier fichero anexo al mismo,
 puede contener informacion clasificada por su emisor como confidencial
 en el marco de su Sistema de Gestion de Seguridad de la=20
Informacion siendo para uso exclusivo del destinatario, quedando=20
prohibida su divulgacion copia o distribucion a terceros sin la=20
autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20
 erroneamente, se ruega lo notifique al remitente y proceda a su borrado.=
=20
Gracias por su colaboracion.
______________________
This message including any attachments may contain confidential=20
information, according to our Information Security Management System,
 and intended solely for a specific individual to whom they are addressed.
 Any unauthorised copy, disclosure or distribution of this message
 is strictly forbidden. If you have received this transmission in error,
 please notify the sender immediately and delete it.
______________________

------=_NextPart_000_0006_01C63EC9.6C7A2290
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>first let me introduce a little bit what I=
 am=20
trying to do so that you can give me best help. I am building a onboard sys=
tem=20
for city-buses, which takes car of different tasks. Some of them are VoIP=
=20
calling, audio reporting to passengers and external speaker. To make it pos=
sible=20
through just one stereo soundcard, I need to force voice (the one caming ou=
t of=20
alsa drivers) to go into one of stereo channels, let's say on the left one.=
 Is=20
there any way of performing this through the API?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot.</FONT></DIV>________________=
______<br>Este mensaje, y en su caso, cualquier fichero anexo al mismo,<br>=
 puede contener informacion clasificada por su emisor como confidencial<br>=
 en el marco de su Sistema de Gestion de Seguridad de la <br>Informacion si=
endo para uso exclusivo del destinatario, quedando <br>prohibida su divulga=
cion copia o distribucion a terceros sin la <br>autorizacion expresa del re=
mitente. Si Vd. ha recibido este mensaje <br> erroneamente, se ruega lo not=
ifique al remitente y proceda a su borrado. <br>Gracias por su colaboracion=
.<br>______________________<br>This message including any attachments may c=
ontain confidential <br>information, according to our Information Security =
Management System,<br> and intended solely for a specific individual to who=
m they are addressed.<br> Any unauthorised copy, disclosure or distribution=
 of this message<br> is strictly forbidden. If you have received this trans=
mission in error,<br> please notify the sender immediately and delete it.<b=
r>______________________
</BODY></HTML>

------=_NextPart_000_0006_01C63EC9.6C7A2290--


------=_NextPartTM-000-6c278fd8-d76a-47af-9c8f-bc31ef3e231e--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
