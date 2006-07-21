From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001897]: Audio Driver crashes
	immediatly after login, sound is crackling
Date: Fri, 21 Jul 2006 09:48:18 +0200
Message-ID: <83e3ec43dae77fb8753bd4d0571cf0fb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10C8F17A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 09:48:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1897> 
======================================================================
Reported By:                dgopi81
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1897
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-07-2006 19:04 CET
Last Modified:              07-21-2006 09:48 CEST
======================================================================
Summary:                    Audio Driver crashes immediatly after login, sound
is crackling
Description: 
the sound driver crashes immediatly on logging as root and unable to
restart, but oss drivers works and sound is fine. when logged as normal
user alsa driver works but sound is choppy and crackling, oss drivers
works fine and sound quality is good but applications doesn't detect oss
and no audio playback in oss mode.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-07-06 19:23 
----------------------------------------------------------------------
You don't give NEARLY enough information for this bug report to be useful

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-06 19:04 dgopi81        New Issue                                    
03-07-06 19:04 dgopi81        Kernel Version            => 2.6             
03-07-06 19:23 rlrevell       Note Added: 0008373                          
07-21-06 09:48 Adrian Bunk    Status                   assigned => closed  
07-21-06 09:48 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
