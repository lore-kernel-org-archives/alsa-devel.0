From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000949]: Randomly, left and right tracks are swaped
Date: Tue, 22 Mar 2005 22:33:17 +0100
Message-ID: <26258d8b78b0a0d0c820677fa48d1176@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 865C3286
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:33:17 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000059.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=949> 
======================================================================
Reported By:                NorbertB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   949
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:              2.4.21-20.ELsmp
======================================================================
Date Submitted:             02-28-2005 00:08 CET
Last Modified:              03-22-2005 22:33 CET
======================================================================
Summary:                    Randomly, left and right tracks are swaped
Description: 
I'm running ALSA 1.0.8 on an APro 6224 (AMD8111, ac97' chipset Realtek
ALC655).
alsamixer is on, I can hear my audio OK but sometimes, randomly, left and
right channels are swapped.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000059 On au8820 left and right channels are s...
has duplicate       0000403 intel8x0 driver swaps channels
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-05 00:08 NorbertB       New Issue                                    
02-28-05 00:08 NorbertB       Kernel Version            =>  2.4.21-20.ELsmp
03-22-05 22:30 jdthood        Relationship added       has duplicate 0000403
03-22-05 22:33 jdthood        Relationship added       related to 0000059  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
