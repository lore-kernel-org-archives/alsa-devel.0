From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000547]: Outdated pmac.patch
Date: Tue, 9 Nov 2004 16:38:15 +0100
Message-ID: <41288118f7d239c10239748834157862@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE2FE2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:38:15 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=547> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   547
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-26-2004 22:17 CEST
Last Modified:              11-09-2004 16:38 CET
======================================================================
Summary:                    Outdated pmac.patch
Description: 
Build fails because alsa-driver/ppc/pmac.patch doesn't apply to
alsa-kernel/ppc/pmac.c any more.

I include an updated patch which does apply.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-27-04 09:24 
----------------------------------------------------------------------
Summary: Fix pmac.patch

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-27-04 15:02 
----------------------------------------------------------------------
Thanks, applied to CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 22:17 jdthood        New Issue                                    
09-26-04 22:17 jdthood        File Added: pmac_jdth1.patch                    
09-27-04 09:24 jdthood        Note Added: 0001932                          
09-27-04 15:02 tiwai          Status                   assigned => resolved
09-27-04 15:02 tiwai          Resolution               open => fixed       
09-27-04 15:02 tiwai          Note Added: 0001937                          
11-09-04 16:38 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
