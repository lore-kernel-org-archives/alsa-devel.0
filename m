From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000464]: Right Channel always +6dB Louder than Left Channel while recording in Stereo
Date: Thu, 26 Aug 2004 07:48:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040826054830.0218D24005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5911B293
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 07:48:31 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 16B6A1ADCE
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 07:48:31 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000464
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     464
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandrake Linux
Kernel Version:             2.4.19-16mdk
======================================================================
Date Submitted:             08-26-2004 07:48 CEST
Last Modified:              08-26-2004 07:48 CEST
======================================================================
Summary:                    Right Channel always +6dB Louder than Left Channel while recording in Stereo
Description: 
The sound card is Turtle Beach Santa Cruz (CS4630). When trying to record
from any stereo source (Line In, Aux, CDROM, Mix) the right channel is
always +6dB louder than left channel. This happens with arecord, mencoder,
audacity, or any program that can record audio. Recording in mono works
perfectly.


======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 07:48 Electro        New Bug                                      
08-26-04 07:48 Electro        Distribution              => Mandrake Linux  
08-26-04 07:48 Electro        Kernel Version            => 2.4.19-16mdk    
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
