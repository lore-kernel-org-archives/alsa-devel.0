From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001996]: Volume control missing (hda-intel, CMI9880)
Date: Fri, 7 Apr 2006 19:29:19 +0200
Message-ID: <76fa9bff24bb3a97cf21a65bb6172277@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D3A115C
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 19:29:19 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1996> 
======================================================================
Reported By:                babak
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1996
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core release 4
Kernel Version:             2.6.15-1.1833_FC4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-03-2006 10:20 CEST
Last Modified:              04-07-2006 19:29 CEST
======================================================================
Summary:                    Volume control missing (hda-intel, CMI9880)
Description: 
No volume controls found on my system, but playing music works properly
(without volume control).
======================================================================

----------------------------------------------------------------------
 tiwai - 04-07-06 19:29 
----------------------------------------------------------------------
CMI9880 codec has really no playback volume control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 10:20 babak          New Issue                                    
04-03-06 10:20 babak          Distribution              => Fedora Core release 4
04-03-06 10:20 babak          Kernel Version            => 2.6.15-1.1833_FC4
04-03-06 10:21 babak          Issue Monitored: babak                       
04-07-06 19:29 tiwai          Status                   assigned => resolved
04-07-06 19:29 tiwai          Resolution               open => not an issue
04-07-06 19:29 tiwai          Note Added: 0009151                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
