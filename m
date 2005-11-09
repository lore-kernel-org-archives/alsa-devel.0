From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001497]: Problem with playing sound when turning on USB device
Date: Wed, 9 Nov 2005 21:53:57 +0100
Message-ID: <300dea94c884b618a8160bd7b36e8ac8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5617E1CA
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 21:53:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1497> 
======================================================================
Reported By:                kazuya
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1497
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               tried on Debian Sid and Gentoo but probably others
too
Kernel Version:             2.6.10 , 2.6.13.4 - almost every 2.6 - tried 2.6.8
and up
======================================================================
Date Submitted:             10-24-2005 21:50 CEST
Last Modified:              11-09-2005 21:53 CET
======================================================================
Summary:                    Problem with playing sound when turning on USB
device
Description: 
When I'm playing some sound and turn on my USB modem (Sagem F@st 800) or
any other USB device the sound suddenly get noisy, I can hear some cracks
and when PC sends or recieves data to or from device sound almost stops.
======================================================================

----------------------------------------------------------------------
 kazuya - 11-09-05 21:53 
----------------------------------------------------------------------
I've installed openSuSE 10.0 and the problem exists even on generic kernel
of this distro (linux 2.6.13-15-default)...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-05 21:50 kazuya         New Issue                                    
10-24-05 21:50 kazuya         Distribution              => tried on Debian Sid
and Gentoo but probably others too
10-24-05 21:50 kazuya         Kernel Version            => 2.6.10 , 2.6.13.4 -
almost every 2.6 - tried 2.6.8 and up
11-09-05 21:53 kazuya         Note Added: 0006657                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
