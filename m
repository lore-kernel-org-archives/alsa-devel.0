From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000706]: SERR: Status=4210 followed by NMI reason 34 leading to reboot
Date: Tue, 7 Dec 2004 18:52:39 +0100
Message-ID: <357a56521e102cef215de187e43e4436@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A785A3AD
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 18:52:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=706> 
======================================================================
Reported By:                dlc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   706
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               DeMuDi1.2.0
Kernel Version:             2.4.25
======================================================================
Date Submitted:             12-04-2004 00:36 CET
Last Modified:              12-07-2004 18:52 CET
======================================================================
Summary:                    SERR: Status=4210 followed by NMI reason 34 leading
to reboot
Description: 
System reboots when attempting to install a game under Wine.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-04 18:52 
----------------------------------------------------------------------
Too little information: Which sound card, which ALSA version?

Try to use snd-dummy driver instead of snd-ice1712, and see whether the
same problem occurs.  If it happens, the problem should be in others.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-04 00:36 dlc            New Issue                                    
12-04-04 00:36 dlc            Distribution              => DeMuDi1.2.0     
12-04-04 00:36 dlc            Kernel Version            => 2.4.25          
12-07-04 18:52 tiwai          Note Added: 0002760                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
