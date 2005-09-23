From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001177]: Dell Inspiron 8500  + port replicator issues.
Date: Fri, 23 Sep 2005 20:27:14 +0200
Message-ID: <05afab39ad6e73fba5116f892ba4dbf0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02C12116
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 20:27:14 +0200 (MEST)
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
Last Modified:              09-23-2005 20:27 CEST
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
 sgoodall - 07-11-05 15:40 
----------------------------------------------------------------------
Added asound.state as well

----------------------------------------------------------------------
 sgoodall - 09-23-05 20:27 
----------------------------------------------------------------------
Is any more information needed?

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
