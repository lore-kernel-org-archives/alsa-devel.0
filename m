From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000672]: alternate ALS0200 ident string
Date: Wed, 24 Nov 2004 12:16:57 +0100
Message-ID: <442e3160c6e658de3dab90202f9ef13a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98093223
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 12:16:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=672> 
======================================================================
Reported By:                basic
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   672
Category:                   ISA - als100
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-24-2004 07:31 CET
Last Modified:              11-24-2004 12:16 CET
======================================================================
Summary:                    alternate ALS0200 ident string
Description: 
recently dug up some older hardware to put togather a pc for my brother,
found this OEM ALS0200 card, couldn't get the module to load, so
downloaded pnptools and used pnpdump... long story short, here's the patch
to get it to work.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-24-04 12:16 
----------------------------------------------------------------------
Please provide the summary, description and signed-off-by lines.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 07:31 basic          New Issue                                    
11-24-04 07:31 basic          File Added: als100.c.patch                    
11-24-04 12:16 tiwai          Note Added: 0002546                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
