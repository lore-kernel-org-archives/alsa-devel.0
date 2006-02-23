From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001871]: A possible (??) new feature? - volume normalisation
Date: Thu, 23 Feb 2006 01:55:53 +0100
Message-ID: <0935b10b39b26a00910ec367f1ce930a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C3CA1A2
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 01:55:53 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1871> 
======================================================================
Reported By:                noremac
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1871
Category:                   alsamixer
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-23-2006 01:55 CET
Last Modified:              02-23-2006 01:55 CET
======================================================================
Summary:                    A possible (??) new feature? - volume normalisation
Description: 
I was pointed here from the gento forum
http://forums.gentoo.org/viewtopic-t-436425.html?sid=afbe87e55c4b71954a0e6d8e55d3028b

but am not sure this is the best place for a feature request. (sorry if it
is not)

Would it be possible to build into alsa a volume modulatation of
normalisation feature? This would accomadate for listening to music with
huge dynamic range (I find when I turn the volume up high enough to hear
the soft parts, the loud parts nearly deafen me).
The feature I had in mind would be such that when this feature was
switched off the volume controll would act as it does (as an amplification
adjustment). When the modulation feature was activated the volume control
would become an absolute-volume control.  
If, for example, the modulation control was set at 50% the computor would
calculate the difference between the volume of music and the volume as set
with the volume control, and halve that difference. In this way the soft
would be bought louder, and the loud softened. 
If the modulation control was set at 100% everything would be at the same
volume.

thanks for your time
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 01:55 noremac        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
