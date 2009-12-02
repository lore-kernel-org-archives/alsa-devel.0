From: Alberto Martinez de la Ossa <delaossa@mail.desy.de>
Subject: About TASCAM US-122 mkII support
Date: Wed, 02 Dec 2009 18:26:59 +0100
Message-ID: <4B16A363.50503@mail.desy.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020308060807060803090403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-3.desy.de (smtp-out-3.desy.de [131.169.56.86])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AAA8103819
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 18:27:00 +0100 (CET)
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-out-3.desy.de (DESY_OUT_3) with ESMTP id 6C4141105
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 18:27:00 +0100 (MET)
Received: from adserv71.win.desy.de (adserv71.win.desy.de [131.169.97.57])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 65A8310FE
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 18:27:00 +0100 (MET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, samuel.mimram@ens-lyon.org, fzu@wemgehoertderstaat.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020308060807060803090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I have just got the TASCAM US-122 mkI 
<http://www.tascam.com/products/us-122mkII.html>I audio/midi interface, 
which seemed to me a great product and a good deal.
The problem is that I use a linux system (ubuntu-studio karmic) for 
music production and the interface can not be recognized when plugged.
Among other reasons I chose this device because I thought it would work 
in linux:
There were alsa drivers for its predecessors, the us-122 
<http://alsa.opensrc.org/Tascam_US-122>  and the us-122l 
<http://www.pps.jussieu.fr/%7Esmimram/tascam/> models.
The latter, thanks to Karsten Wiese who wrote a patch for the us-122l 
version, which was latter included by default in newer alsa-firmware 
releases.

Unfortunately, the new model (US-122 mkII), the one I have, is not 
supported yet.
I have even tried to get it replaced by the previous us-122l model, but 
it is not available anymore in the music store -> http://www.justmusic.de
On the other hand, the "linux specialist" of the music store told me 
that a new linux driver for the us-122 mkII is been prepared,
although he doesn't know when it will be ready.
Being you the experts I have found in the web in regards with ALSA and 
TASCAM usb interfaces, I have decided to directly ask you about this.
I would really appreciate any information about the topic.

Thanks in advance for your attention.

Best regards,



--------------020308060807060803090403
Content-Type: text/x-vcard; charset=utf-8;
 name="delaossa.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="delaossa.vcf"

begin:vcard
fn;quoted-printable:Alberto Mart=C3=ADnez de la Ossa
n;quoted-printable:Mart=C3=ADnez de la Ossa;Alberto
org:@ DESY;University of Colorado
adr:;;Notkestrasse 85;Hamburg;;22607;Germany
email;internet:delaossa@mail.desy.de
title:Member, HERMES Collaboration
tel;work:+49-40-8998-4789
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------020308060807060803090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020308060807060803090403--
