From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000255]: CM9739 does not sound
Date: Wed, 23 Mar 2005 15:45:36 +0100
Message-ID: <09a5114608d1f8f5ec295d1e3b0da166@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7A56C27A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:45:36 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0000225.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=255> 
======================================================================
Reported By:                qeldroma
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   255
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2004.1
Kernel Version:             2.6.5
======================================================================
Date Submitted:             05-06-2004 13:06 CEST
Last Modified:              03-23-2005 15:45 CET
======================================================================
Summary:                    CM9739 does not sound
Description: 
I've got the Epox 8RDA3+ Board with this onboard-sound-chip.
The intel8x0 driver is loading without errors, i can adjust the mixers,
but there's definetely no sound.
Under WinXP all is ok.
I googled and found out, that there are several people with this problem.
However, i can give you no hint, where in detail the problem is, perhaps
the CM9739 isn't fully supported right now?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000225 No PCM-mixer on Epox 8RDA3I and no sound
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 13:06 qeldroma       New Issue                                    
05-06-04 13:06 qeldroma       Distribution              => Gentoo 2004.1   
05-06-04 13:06 qeldroma       Kernel Version            => 2.6.5           
03-23-05 15:45 jdthood        Relationship added       duplicate of 0000225
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
