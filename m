From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000821]: Audigy 2 NX USB
Date: Wed, 19 Jan 2005 17:53:00 +0100
Message-ID: <47dd381d56cf131a258cc8246dc43f1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6441226D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 17:53:00 +0100 (MET)
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
Last Modified:              01-19-2005 17:52 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-05 16:47 clusty         New Issue                                    
01-16-05 16:49 clusty         Issue Monitored: clusty                      
01-19-05 17:52 kempokaraterulzNote Added: 0003308                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
