From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000507]: Soundcard cannot play more than one thing at a time (but Stereo!)
Date: Sun, 19 Sep 2004 17:34:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040919153434.CC4292500C@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 372242C6
	for <alsa-devel@alsa-project.org>; Sun, 19 Sep 2004 17:34:39 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id ED0B225EB8
	for <alsa-devel@alsa-project.org>; Sun, 19 Sep 2004 17:34:34 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000507
======================================================================
Reported By:                DashX
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     507
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
======================================================================
Date Submitted:             09-19-2004 17:34 CEST
Last Modified:              09-19-2004 17:34 CEST
======================================================================
Summary:                    Soundcard cannot play more than one thing at a time (but Stereo!)
Description: 
Sound Card:   SoundMAX Integrated Digital Audio
HWBrowser says 82801DB (ICH4) AC'97 Audio Controller

2x xmms with esound = works
2x xmms with alsa = doesent work because of audio device in use.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 17:34 DashX          New Bug                                      
09-19-04 17:34 DashX          Distribution              => Fedora Core 2   
09-19-04 17:34 DashX          Kernel Version            => 2.6.8-1.521     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
