From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001910]: No Sound for SB Extigy for volume below 30%
Date: Mon, 13 Mar 2006 15:45:42 +0100
Message-ID: <f28e5ea634529c1f690020c0814f8141@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9761D19F
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 15:45:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1910> 
======================================================================
Reported By:                andersin
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1910
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2006 16:40 CET
Last Modified:              03-13-2006 15:45 CET
======================================================================
Summary:                    No Sound for SB Extigy for volume below 30%
Description: 
The volume control for the SB Extigy only works accurately for values above
50%. Below that, sound is still detectable very faintly as low as 30%
(This is with my speakers set to full output which is unbearably loud if
the volume in alsamixer gets turned up again). Below 30% there is no sound
as far as I can tell. Effectively there's only half a volume control
(50%-100%).
======================================================================

----------------------------------------------------------------------
 andersin - 03-11-06 19:52 
----------------------------------------------------------------------
please close this. I opened a new report after being advised in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1911
that it should be reported for the usb-audio driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 16:40 andersin       New Issue                                    
03-11-06 19:52 andersin       Note Added: 0008426                          
03-13-06 15:45 tiwai          Status                   new => resolved     
03-13-06 15:45 tiwai          Resolution               open => not an issue
03-13-06 15:45 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
