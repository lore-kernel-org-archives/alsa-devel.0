From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000512]: [PATCH] 15_alsamixer_doc_mute
Date: Fri, 24 Sep 2004 11:37:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924093719.701592A003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E075F1FE
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 11:37:19 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000512
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Bug ID:                     512
Category:                   alsamixer
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             09-21-2004 19:45 CEST
Last Modified:              09-24-2004 11:37 CEST
======================================================================
Summary:                    [PATCH] 15_alsamixer_doc_mute
Description: 
Patch for alsamixer.1 to make it mention that '<' and '>' 
mute channels separately only if the hardware supports this.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 14:13 CEST 
----------------------------------------------------------------------
Please provide a summary and a signed-off-by line.
(For other patches, too!)

----------------------------------------------------------------------
 jdthood - 09-23-2004 19:47 CEST 
----------------------------------------------------------------------
Summary: mention that '<' and '>' mute channels separately only if the
hardware supports this

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-24-2004 11:37 CEST 
----------------------------------------------------------------------
Applied.  Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 19:45 jdthood        New Bug                                      
09-21-04 19:45 jdthood        File Added: 15_alsamixer_doc_mute.dpatch                    
09-23-04 14:13 tiwai          Bugnote Added: 0001825                       
09-23-04 19:47 jdthood        Bugnote Added: 0001835                       
09-24-04 11:37 tiwai          Bugnote Added: 0001862                       
09-24-04 11:37 tiwai          Assigned To               => tiwai           
09-24-04 11:37 tiwai          Resolution               open => fixed       
09-24-04 11:37 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
