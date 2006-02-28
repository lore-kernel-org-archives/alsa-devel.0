From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001485]: Sound disappears occasionally
Date: Wed, 1 Mar 2006 00:59:19 +0100
Message-ID: <e46510e395197f159897dd7b58af77bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 394791C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:59:19 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1485> 
======================================================================
Reported By:                jza
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1485
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.12
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-19-2005 20:56 CEST
Last Modified:              03-01-2006 00:59 CET
======================================================================
Summary:                    Sound disappears occasionally
Description: 
Sound disappears completely when doing rapid consecutive seeks in
applications (gxine, xmms). Restarting the application a few times usually
helps, sometimes a complete system freeze is the result.
======================================================================

----------------------------------------------------------------------
 jza - 10-21-05 09:27 
----------------------------------------------------------------------
When the bug appears, the player sometimes freezes.

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:07 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-05 20:56 jza            New Issue                                    
10-19-05 20:56 jza            Distribution              => Debian          
10-19-05 20:56 jza            Kernel Version            => 2.6.12          
10-20-05 09:57 jza            Note Added: 0006499                          
10-21-05 09:27 jza            Note Added: 0006510                          
12-31-05 00:07 rlrevell       Note Added: 0007308                          
03-01-06 00:59 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
