From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000832]: sound randomly distorts, clicks, pops and low level
Date: Thu, 15 Sep 2005 16:16:04 +0200
Message-ID: <62bda5a2acac5aac53e9647c22fb13f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26D59178
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 16:16:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=832> 
======================================================================
Reported By:                Alister
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   832
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse linux
Kernel Version:             2.6.5-7.111.19-default
======================================================================
Date Submitted:             01-17-2005 22:07 CET
Last Modified:              09-15-2005 16:16 CEST
======================================================================
Summary:                    sound randomly distorts, clicks, pops and low level
Description: 
reported here:
http://forums.suselinuxsupport.de/index.php?showtopic=7828

but in summary:
HW works perfectly under windows partition.
Despite several (hopeful) upgrades, sound persists in randomly becoming
low- level and/or VERY distorted (clipped?). Occurs anytime from few
seconds to many minutes after being cleared. Occassionally corrects itself
(temporary) just as randomly. But spends most of the time being badly
distorted, low level and no left channel.
Can always clear (temporarily) by using volume control in YaST to set max
volumes and play high level sound through card.
Left channel always affected worse than right.
======================================================================

----------------------------------------------------------------------
 Alister - 01-28-05 11:06 
----------------------------------------------------------------------
I am very willing to help test any proposed solutions, please contact me if
required.

----------------------------------------------------------------------
 jdthood - 09-15-05 16:16 
----------------------------------------------------------------------
Is this problem fixed in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 22:07 Alister        New Issue                                    
01-17-05 22:07 Alister        Distribution              => Suse linux      
01-17-05 22:07 Alister        Kernel Version            =>
2.6.5-7.111.19-default
01-28-05 11:06 Alister        Note Added: 0003425                          
09-15-05 16:16 jdthood        Note Added: 0006214                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
