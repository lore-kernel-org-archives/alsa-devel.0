From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002248]: Sounds stops and continue
Date: Wed, 5 Jul 2006 16:48:29 +0200
Message-ID: <0ad7c2723be4231c82ccb4d2663ae6d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39D87256
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 16:48:30 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2248> 
======================================================================
Reported By:                gwagner
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2248
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-30-2006 06:05 CEST
Last Modified:              07-05-2006 16:48 CEST
======================================================================
Summary:                    Sounds stops and continue
Description: 
Every sounds "music movies" are having little pauses, it's pausing for few
miliseconds and continue. It's happen on every kind of aplication.
My matherborad is an Asus-A8V-Deluxe, chipset Via VT8237, Athlon 64 3000,
that should work with snd_via82xx. I have an soud blaster card too, but
that work fine.
======================================================================

----------------------------------------------------------------------
 gwagner - 07-05-06 15:40 
----------------------------------------------------------------------
I compiled 1.0.12-rc1 drives, libs... and it's work fine with my Via VT8237
chipset but  only if I get out with my "sound blaster live 24bit advanced
HD" but with both of them the via VT8237 has presented the same  problem
that presended with 1.0.11 the sound's stopping.

----------------------------------------------------------------------
 rlrevell - 07-05-06 16:48 
----------------------------------------------------------------------
I can't make any sense out of this comment.  Is there any improvement with
1.0.12-rc1?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-30-06 06:05 gwagner        New Issue                                    
06-30-06 16:36 rlrevell       Note Added: 0010740                          
07-05-06 15:40 gwagner        Note Added: 0010841                          
07-05-06 16:48 rlrevell       Note Added: 0010842                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
