From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000481]: IEC958 Output doesn't work
Date: Sat,  4 Sep 2004 13:17:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040904111730.CB8ED48008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 218EB233
	for <alsa-devel@alsa-project.org>; Sat,  4 Sep 2004 13:17:31 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id DAFD71F981
	for <alsa-devel@alsa-project.org>; Sat,  4 Sep 2004 13:17:30 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000481
======================================================================
Reported By:                somnione
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     481
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               LFS
Kernel Version:             2.4.23
======================================================================
Date Submitted:             09-04-2004 13:17 CEST
Last Modified:              09-04-2004 13:17 CEST
======================================================================
Summary:                    IEC958 Output doesn't work
Description: 
I had Version 0.9.8 and in the mixer i could switch on "IEC 958 Output"
wich would activate the optical out on the card, but with version 1.0.6a
I'm missing this option and thus the card is silent via optical out. It
has "IEC958" but nothing happens.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-04-04 13:17 somnione       New Bug                                      
09-04-04 13:17 somnione       Distribution              => LFS             
09-04-04 13:17 somnione       Kernel Version            => 2.4.23          
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
