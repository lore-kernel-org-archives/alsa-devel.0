From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000466]: tumbler_init_client error
Date: Fri, 27 Aug 2004 19:37:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827173734.C1FB62C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F1C111E5
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 19:37:34 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000466
======================================================================
Reported By:                schwab
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     466
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-26-2004 22:36 CEST
Last Modified:              08-27-2004 19:37 CEST
======================================================================
Summary:                    tumbler_init_client error
Description: 
After waking up the driver is unable to restore the sound settings.  I have
to explicitly load the settings to make sound working again.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-27-2004 19:37 CEST 
----------------------------------------------------------------------
Can you try mm tree?  Many ppc fixes are there.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 22:36 schwab         New Bug                                      
08-27-04 19:37 tiwai          Bugnote Added: 0001647                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
