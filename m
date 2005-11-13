From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001551]: No mute switch to mixer channel
Date: Sun, 13 Nov 2005 14:05:26 +0100
Message-ID: <611144d2f02ba6b0a9f768ca9a0f4e5c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59D3C161
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2005 14:05:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1551> 
======================================================================
Reported By:                Shogun
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1551
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.13-gentoo-r3
======================================================================
Date Submitted:             11-13-2005 13:16 CET
Last Modified:              11-13-2005 14:05 CET
======================================================================
Summary:                    No mute switch to mixer channel
Description: 
I have a SoundBlaster Audigy 2 ZS (without LiveDrive)...
When I load the modules the sound works perfectly, but in the mixer (both
alsa-mixer and kmix) I can't see any mute switch for the mixer
channel...The only channel which has the switch is the Headphone...

I don't know if previous version worked...
======================================================================

----------------------------------------------------------------------
 Shogun - 11-13-05 14:05 
----------------------------------------------------------------------
I forgot to mention that this issue is also present in 1.0.8 and in
1.0.10rc3...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 13:16 Shogun         New Issue                                    
11-13-05 13:16 Shogun         Distribution              => Gentoo Linux 2005.1
11-13-05 13:16 Shogun         Kernel Version            => 2.6.13-gentoo-r3
11-13-05 14:05 Shogun         Note Added: 0006691                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
