From: noreply@alsa-project.org
Subject: [ALSA - driver 0000273]: Terratec Aureon Universe 7.1 support.
Date: Fri, 16 Jul 2004 12:47:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104726.372C026009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 788CF255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:47:26 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000273
======================================================================
Reported By:                BugBuster
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     273
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-14-2004 02:05 CEST
Last Modified:              07-16-2004 12:47 CEST
======================================================================
Summary:                    Terratec Aureon Universe 7.1 support.
Description: 
The pci sub id was unknown. I've changed the aureon.{c,h} files to support
it. Patch attached. 
======================================================================

----------------------------------------------------------------------
 tiwai - 05-14-2004 13:00 CEST 
----------------------------------------------------------------------
thanks, i applied your patch to cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-14-04 02:05 BugBuster      New Bug                                      
05-14-04 02:05 BugBuster      File Added: aureon.diff                      
05-14-04 13:00 tiwai          Bugnote Added: 0001110                       
05-14-04 13:00 tiwai          Assigned To               => tiwai           
05-14-04 13:00 tiwai          Resolution               open => fixed       
05-14-04 13:00 tiwai          Status                   new => resolved     
07-16-04 12:47 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
