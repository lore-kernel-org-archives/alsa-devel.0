From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000515]: [PATCH] 15_arecord_doc_duration
Date: Fri, 24 Sep 2004 11:52:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924095203.400F62A003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8B2EC2B7
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 11:52:03 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000515
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Bug ID:                     515
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             09-21-2004 19:49 CEST
Last Modified:              09-24-2004 11:52 CEST
======================================================================
Summary:                    [PATCH] 15_arecord_doc_duration
Description: 
Patch for aplay.1 to make it describe what happens if the
duration is set to zero
======================================================================

----------------------------------------------------------------------
 jdthood - 09-23-2004 19:51 CEST 
----------------------------------------------------------------------
Summary: Describe what happens if aplay's --duration is zero

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-24-2004 11:52 CEST 
----------------------------------------------------------------------
Applied.  Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 19:49 jdthood        New Bug                                      
09-21-04 19:49 jdthood        File Added: 15_arecord_doc_duration.dpatch                    
09-23-04 19:51 jdthood        Bugnote Added: 0001841                       
09-24-04 11:52 tiwai          Bugnote Added: 0001865                       
09-24-04 11:52 tiwai          Assigned To               => tiwai           
09-24-04 11:52 tiwai          Resolution               open => fixed       
09-24-04 11:52 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
