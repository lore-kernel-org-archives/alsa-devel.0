From: noreply@alsa-project.org
Subject: [ALSA - driver 0000269]: Microphone muting and volume control does not work
Date: Fri, 16 Jul 2004 14:40:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716124057.6A4912C003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A4B6D244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:40:57 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000269
======================================================================
Reported By:                walrus121
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     269
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.26
======================================================================
Date Submitted:             05-11-2004 05:27 CEST
Last Modified:              07-16-2004 14:40 CEST
======================================================================
Summary:                    Microphone muting and volume control does not work
Description: 
I cannot mute nor control the volume on the microphone using Alsamixer. 
The control is there and visually functions, but physically does not.  The
mic boost switch still works.  I don't really know where I should be
reporting this bug.
======================================================================

----------------------------------------------------------------------
 walrus121 - 05-11-2004 06:11 CEST 
----------------------------------------------------------------------
Restarting my computer seems to have fixed it.  Maybe I had some kind of
version conflict going on.  Close this bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-11-04 05:27 walrus121      New Bug                                      
05-11-04 05:27 walrus121      Kernel Version            => 2.4.26          
05-11-04 06:11 walrus121      Bugnote Added: 0001080                       
06-28-04 09:26 pzad           Assigned To               => pzad            
06-28-04 09:26 pzad           Resolution               open => not a bug   
06-28-04 09:26 pzad           Status                   new => resolved     
07-16-04 14:40 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
