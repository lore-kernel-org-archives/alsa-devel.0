From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001478]: No sound after volume adjustment during playback
Date: Mon, 17 Oct 2005 00:57:52 +0200
Message-ID: <2a02b7f80a3fe1c6a10a833bab383e88@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 739F0158
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2005 00:57:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1478> 
======================================================================
Reported By:                dzi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1478
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2.6.13-r4
Kernel Version:             2.6.13
======================================================================
Date Submitted:             10-17-2005 00:57 CEST
Last Modified:              10-17-2005 00:57 CEST
======================================================================
Summary:                    No sound after volume adjustment during playback
Description: 
If I adjust volume during playback, there is no sound anymore. After
reinserting alsa modules sound is ok. I can adjust sound when playback is
stopped and then I can play sound again. But if I adjust volume during
playback, it disappears till reinserting of alsa modules.
I use alsa kernel modules.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-17-05 00:57 dzi            New Issue                                    
10-17-05 00:57 dzi            Distribution              => Gentoo 2.6.13-r4
10-17-05 00:57 dzi            Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
