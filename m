From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001560]: Right channel not working with CMI9761
Date: Mon, 14 Nov 2005 22:21:57 +0100
Message-ID: <52c379b5e84c848d59f93aa365bdc3a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D8BB1AC
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 22:21:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1560> 
======================================================================
Reported By:                NULL
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1560
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.2 (almost -current)
Kernel Version:             Linux 2.6.14 (i686)
======================================================================
Date Submitted:             11-14-2005 22:21 CET
Last Modified:              11-14-2005 22:21 CET
======================================================================
Summary:                    Right channel not working with CMI9761
Description: 
Right channel not working with CMI9761 chip in simple stereo mode. I tried
many different configurations, but works only left channel. Same problem
with latest ALSA CVS source and even pure OSS in *BSD systems.

Mainboard: ASrock K7Upgrade-880 VIA KT880
Audio chip: CMedia CMI9761 6 channel AC'97 audio codec

Any ideas? Thanks.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-05 22:21 NULL           New Issue                                    
11-14-05 22:21 NULL           Distribution              => Slackware 10.2
(almost -current)
11-14-05 22:21 NULL           Kernel Version            => Linux 2.6.14 (i686)
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
