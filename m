From: noreply@alsa-project.org
Subject: [ALSA - driver 0000281]: "mic as center/lfe" no longer available
Date: Fri, 16 Jul 2004 12:49:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104939.B185C26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF2FD255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:49:39 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000281
======================================================================
Reported By:                hengelman
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     281
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.6 (or 2.4.26)
======================================================================
Date Submitted:             05-17-2004 14:09 CEST
Last Modified:              07-16-2004 12:49 CEST
======================================================================
Summary:                    "mic as center/lfe" no longer available
Description: 
The "mic as center/lfe" option cannot be used anymore.
In version 1.0.3 the option is available.

I've got an asus-a7n8x mainboard.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-17-2004 15:05 CEST 
----------------------------------------------------------------------
try ALSA cvs version.

----------------------------------------------------------------------
 hengelman - 05-17-2004 19:47 CEST 
----------------------------------------------------------------------
CVS version works perfectly.

Thanks...

----------------------------------------------------------------------
 tiwai - 05-18-2004 11:21 CEST 
----------------------------------------------------------------------
ok, closed now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-17-04 14:09 hengelman      New Bug                                      
05-17-04 14:09 hengelman      Kernel Version            => 2.6.6 (or 2.4.26)
05-17-04 15:05 tiwai          Bugnote Added: 0001131                       
05-17-04 19:47 hengelman      Bugnote Added: 0001136                       
05-18-04 11:21 tiwai          Bugnote Added: 0001137                       
05-18-04 11:21 tiwai          Assigned To               => tiwai           
05-18-04 11:21 tiwai          Resolution               open => fixed       
05-18-04 11:21 tiwai          Status                   new => resolved     
07-16-04 12:49 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
