From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001177]: Dell Inspiron 8500  + port replicator issues.
Date: Mon, 10 Apr 2006 12:51:56 +0200
Message-ID: <14596818d18e936035f8934f56b9e676@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88248143
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 12:51:56 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1177> 
======================================================================
Reported By:                sgoodall
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1177
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             kernel-2.6.11-1.27_FC3
======================================================================
Date Submitted:             06-09-2005 16:00 CEST
Last Modified:              04-10-2006 12:51 CEST
======================================================================
Summary:                    Dell Inspiron 8500  + port replicator issues.
Description: 
I have a dell inspiron 8500 and the port replicator. The has an additional
headphone socket, however the only mixer control that affects it is the
IEC958 checkbox  (when using gnome-alsamixer 0.9.6). This either disables
sound completely, or plays sound at full volume.
All other controls have no affect and, even if muted. The headphone socket
on the laptop itself still works however.
======================================================================

----------------------------------------------------------------------
 sgoodall - 09-23-05 20:27 
----------------------------------------------------------------------
Is any more information needed?

----------------------------------------------------------------------
 sgoodall - 04-10-06 12:51 
----------------------------------------------------------------------
Upgraded to Fedora Core 5 with alsa 1.0.11 and still have the same issues.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 16:00 sgoodall       New Issue                                    
06-09-05 16:00 sgoodall       Distribution              => Fedora Core 3   
06-09-05 16:00 sgoodall       Kernel Version            =>
kernel-2.6.11-1.27_FC3
07-07-05 12:01 sgoodall       Note Added: 0005399                          
07-08-05 11:55 tiwai          Note Added: 0005411                          
07-11-05 15:36 sgoodall       File Added: asound.conf                      
07-11-05 15:37 sgoodall       File Added: proc-asound                      
07-11-05 15:37 sgoodall       File Added: proc-asound-2                    
07-11-05 15:38 sgoodall       Note Added: 0005445                          
07-11-05 15:39 sgoodall       File Added: asound.state                     
07-11-05 15:40 sgoodall       Note Added: 0005446                          
09-23-05 20:27 sgoodall       Note Added: 0006368                          
04-10-06 12:51 sgoodall       Note Added: 0009189                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
