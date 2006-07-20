From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001415]: No sound after adjustment of
	volume
Date: Thu, 20 Jul 2006 10:50:28 +0200
Message-ID: <409c961e91e7cb1040b6b07a30d6e82b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5C8BD226
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 10:50:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1415> 
======================================================================
Reported By:                war0060
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1415
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.12-r10
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             09-12-2005 11:49 CEST
Last Modified:              07-20-2006 10:50 CEST
======================================================================
Summary:                    No sound after adjustment of volume
Description: 
I'm using the snd-hda-intel driver, everything seems ok, but when I
adjusted the volume, there will be no sound anymore. After reboot, it
works again, the main problem is the volume cannot be adjusted.
======================================================================

----------------------------------------------------------------------
 war0060 - 09-20-05 05:19 
----------------------------------------------------------------------
I've tried 1.010rc1, still have the problem

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:31 
----------------------------------------------------------------------
Try 1.0.11-rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-12-05 11:49 war0060        New Issue                                    
09-12-05 11:49 war0060        Distribution              => Gentoo          
09-12-05 11:49 war0060        Kernel Version            => 2.6.12-r10      
09-12-05 16:24 tiwai          Note Added: 0006145                          
09-15-05 04:30 war0060        Note Added: 0006191                          
09-15-05 16:01 tiwai          Note Added: 0006210                          
09-20-05 05:19 war0060        Note Added: 0006310                          
12-13-05 21:18 dzi            Issue Monitored: dzi                         
12-19-05 02:31 rlrevell       Note Added: 0007085                          
01-25-06 20:52 Ka-Ka          Issue Monitored: Ka-Ka                       
07-20-06 10:50 Adrian Bunk    Status                   assigned => closed  
07-20-06 10:50 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
