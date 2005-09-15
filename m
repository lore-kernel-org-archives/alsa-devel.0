From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000802]: ymfpci seems to export wrong values for period_count/period_size/buffer_size
Date: Thu, 15 Sep 2005 15:06:29 +0200
Message-ID: <0815f80f146b59cb866b62f2150c1ae4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 96585E3
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:06:28 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=802> 
======================================================================
Reported By:                slomosnail
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   802
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-10-2005 18:42 CET
Last Modified:              09-15-2005 15:06 CEST
======================================================================
Summary:                    ymfpci seems to export wrong values for
period_count/period_size/buffer_size
Description: 
See here: http://bugzilla.gnome.org/show_bug.cgi?id=162024
======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:32 
----------------------------------------------------------------------
The values are really bogus.
Could you create a small testcase to reproduce this?

----------------------------------------------------------------------
 jdthood - 09-15-05 15:06 
----------------------------------------------------------------------
Could you create a small testcase to reproduce this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 18:42 slomosnail     New Issue                                    
01-11-05 16:48 tiwai          Note Added: 0003156                          
01-18-05 13:28 LeRoutier      Note Added: 0003248                          
01-18-05 14:40 LeRoutier      Issue Monitored: LeRoutier                    
01-19-05 14:32 tiwai          Note Added: 0003270                          
01-27-05 00:39 adamk75        Issue Monitored: adamk75                     
09-15-05 15:06 jdthood        Note Added: 0006200                          
09-15-05 15:06 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
