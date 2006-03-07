From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001897]: Audio Driver crashes immediatly after login, sound is crackling
Date: Tue, 7 Mar 2006 19:23:23 +0100
Message-ID: <68a547f69c869b6d94fd56689d334a18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02BE21A3
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 19:23:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1897> 
======================================================================
Reported By:                dgopi81
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1897
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6
======================================================================
Date Submitted:             03-07-2006 19:04 CET
Last Modified:              03-07-2006 19:23 CET
======================================================================
Summary:                    Audio Driver crashes immediatly after login, sound
is crackling
Description: 
the sound driver crashes immediatly on logging as root and unable to
restart, but oss drivers works and sound is fine. when logged as normal
user alsa driver works but sound is choppy and crackling, oss drivers
works fine and sound quality is good but applications doesn't detect oss
and no audio playback in oss mode.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-07-06 19:23 
----------------------------------------------------------------------
You don't give NEARLY enough information for this bug report to be useful

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-06 19:04 dgopi81        New Issue                                    
03-07-06 19:04 dgopi81        Kernel Version            => 2.6             
03-07-06 19:23 rlrevell       Note Added: 0008373                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
