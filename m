From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001398]: volume level either 0% or 100%
Date: Fri, 24 Mar 2006 02:25:35 +0100
Message-ID: <b1cd45519fd8c3a8c71844caa082dccf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 025A013A
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 02:25:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1398> 
======================================================================
Reported By:                KamMing
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1398
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-05-2005 06:33 CEST
Last Modified:              03-24-2006 02:25 CET
======================================================================
Summary:                    volume level either 0% or 100%
Description: 
The volume can be tuned by aumix. But sound level only 2 levels 0% and
100%.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-23-06 16:12 
----------------------------------------------------------------------
Also, let us know which volume you mean.

If the bug still exists in 1.0.11rc4, please report with more details.

----------------------------------------------------------------------
 KamMing - 03-24-06 02:25 
----------------------------------------------------------------------
It is fixed by 1.0.11rc4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-05-05 06:33 KamMing        New Issue                                    
09-05-05 06:33 KamMing        Kernel Version            => 2.6.13          
03-22-06 03:25 rlrevell       Note Added: 0008818                          
03-23-06 16:12 tiwai          Note Added: 0008886                          
03-24-06 02:25 KamMing        Note Added: 0008908                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
