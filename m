From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000821]: Audigy 2 NX USB
Date: Thu, 15 Sep 2005 15:07:19 +0200
Message-ID: <0d073500a5b45d838ce31e21e6b69686@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73BCA11F
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:07:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=821> 
======================================================================
Reported By:                clusty
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   821
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-16-2005 16:47 CET
Last Modified:              09-15-2005 15:07 CEST
======================================================================
Summary:                    Audigy 2 NX USB
Description: 
Whenever I play a song with XMMS using ALSA output plugin it works for 2-3
seconds and then it mutes. If I restart the player it does the same.
======================================================================

----------------------------------------------------------------------
 kempokaraterulz - 01-19-05 17:52 
----------------------------------------------------------------------
With a sound blaster live 24bit usb the sound works for anywhere between
several minutes and like an hour or so ... before muting itself ...
hitting stop then start again or pausing and unpausing the player restores
sound. nothing in dmesg or any logs either . i just compiled this kernel
with usb debugging so i will report back if i can find anything good in
there.

----------------------------------------------------------------------
 jdthood - 09-15-05 15:07 
----------------------------------------------------------------------
Submitter: Is there any improvement in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-05 16:47 clusty         New Issue                                    
01-16-05 16:49 clusty         Issue Monitored: clusty                      
01-19-05 17:52 kempokaraterulzNote Added: 0003308                          
09-15-05 15:07 jdthood        Note Added: 0006201                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
