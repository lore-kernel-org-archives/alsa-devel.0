From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001415]: No sound after adjustment of volume
Date: Tue, 20 Sep 2005 05:19:26 +0200
Message-ID: <def46ec67c2fd3b893723243531f1a13@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10350196
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2005 05:19:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1415> 
======================================================================
Reported By:                war0060
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1415
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.12-r10
======================================================================
Date Submitted:             09-12-2005 11:49 CEST
Last Modified:              09-20-2005 05:19 CEST
======================================================================
Summary:                    No sound after adjustment of volume
Description: 
I'm using the snd-hda-intel driver, everything seems ok, but when I
adjusted the volume, there will be no sound anymore. After reboot, it
works again, the main problem is the volume cannot be adjusted.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-15-05 16:01 
----------------------------------------------------------------------
No.

----------------------------------------------------------------------
 war0060 - 09-20-05 05:19 
----------------------------------------------------------------------
I've tried 1.010rc1, still have the problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-12-05 11:49 war0060        New Issue                                    
09-12-05 11:49 war0060        Distribution              => Gentoo          
09-12-05 11:49 war0060        Kernel Version            => 2.6.12-r10      
09-12-05 16:24 tiwai          Note Added: 0006145                          
09-15-05 04:30 war0060        Note Added: 0006191                          
09-15-05 16:01 tiwai          Note Added: 0006210                          
09-20-05 05:19 war0060        Note Added: 0006310                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
