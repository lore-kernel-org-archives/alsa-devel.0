From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0001119]: USB headset not working
Date: Sun, 6 Aug 2006 01:33:32 +0200
Message-ID: <f549d471e6ce9232984131a707d470c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A210613C
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 01:33:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1119> 
======================================================================
Reported By:                donlvnv
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   1119
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             05-20-2005 08:48 CEST
Last Modified:              08-06-2006 01:33 CEST
======================================================================
Summary:                    USB headset not working
Description: 
using ac97 on a Shuttle SFF and suse 9.3 with a Logitech 300 headset.
The headset won't work. I have tried it with Knoppix 3.8 Livecd.
Kmix recognizes it and it work under knoppix, but as soon as I run
alsaconf.
The Headset stops working and there is no tab for it in Kmix.
Alsamixer has no place for it under suse or knoppix. I have got it to
output to the headset in Control Center,Sound & Multimedia,Sound
System.Hardware tab by overriding device location to /dev/dsp1, and then
in the general tab and selecting  the test sound.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 21:12 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-05 08:48 donlvnv        New Issue                                    
05-20-05 08:51 donlvnv        Issue Monitored: donlvnv                     
12-30-05 21:12 rlrevell       Note Added: 0007262                          
08-06-06 01:33 Adrian Bunk    Status                   new => closed       
08-06-06 01:33 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
