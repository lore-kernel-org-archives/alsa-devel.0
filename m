From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000495]: XMMS does not resume after pausing with snd-usb-audio and XMMS set to ALSA output
Date: Fri, 10 Sep 2004 20:59:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910185954.D6EA01D00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 378AA179
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 20:59:55 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000495
======================================================================
Reported By:                Paul van Schayck
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     495
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.0
Kernel Version:             2.4.27
======================================================================
Date Submitted:             09-10-2004 20:59 CEST
Last Modified:              09-10-2004 20:59 CEST
======================================================================
Summary:                    XMMS does not resume after pausing with snd-usb-audio and XMMS set to ALSA output
Description: 
With the snd-usb-audio module with a Plantronics DSP-300 USB headset and
XMMS 1.2.10 (set to ALSA output) xmms will not resume playing after
pressing the pause button.

This does not happen with XMMS set to OSS with the snd-pcm-oss module. It
does also not happen with my SBLive! 5.1 card and XMMS set to ALSA.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-10-04 20:59 Paul van SchayckNew Bug                                      
09-10-04 20:59 Paul van SchayckDistribution              => Slackware 10.0  
09-10-04 20:59 Paul van SchayckKernel Version            => 2.4.27          
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
