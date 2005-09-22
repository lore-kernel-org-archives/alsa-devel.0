From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001441]: snd-powermac: Burgundy: controls for headphones and speakers inverted
Date: Thu, 22 Sep 2005 10:12:57 +0200
Message-ID: <030e0e2538013c9c592e41527f8ee995@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB821192
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 10:12:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1441> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1441
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.13.2
======================================================================
Date Submitted:             09-22-2005 10:12 CEST
Last Modified:              09-22-2005 10:12 CEST
======================================================================
Summary:                    snd-powermac: Burgundy: controls for headphones and
speakers inverted
Description: 
The control sliders for the volume of the stereo speakers and of the
headphones are reversed. Additionally, the speaker controls are wrongfully
a single mono slider. Another headphone-related issue is that the
automatic muting of the speakers upon connection of headphones does not
work. Likewise, the muting status of headphones and speakers is not saved.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 10:12 Quietti        New Issue                                    
09-22-05 10:12 Quietti        Distribution              => Debian          
09-22-05 10:12 Quietti        Kernel Version            => 2.6.13.2        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
