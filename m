From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000512]: [PATCH] 15_alsamixer_doc_mute
Date: Tue, 9 Nov 2004 16:35:30 +0100
Message-ID: <1e828781f99ec872e88c1de416af0cb2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DBB9E2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:35:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=512> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   512
Category:                   alsamixer
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-21-2004 19:45 CEST
Last Modified:              11-09-2004 16:35 CET
======================================================================
Summary:                    [PATCH] 15_alsamixer_doc_mute
Description: 
Patch for alsamixer.1 to make it mention that '<' and '>' 
mute channels separately only if the hardware supports this.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-23-04 19:47 
----------------------------------------------------------------------
Summary: mention that '<' and '>' mute channels separately only if the
hardware supports this

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-24-04 11:37 
----------------------------------------------------------------------
Applied.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 19:45 jdthood        New Issue                                    
09-21-04 19:45 jdthood        File Added: 15_alsamixer_doc_mute.dpatch          
         
09-23-04 14:13 tiwai          Note Added: 0001825                          
09-23-04 19:47 jdthood        Note Added: 0001835                          
09-24-04 11:37 tiwai          Status                   new => resolved     
09-24-04 11:37 tiwai          Resolution               open => fixed       
09-24-04 11:37 tiwai          Assigned To               => tiwai           
09-24-04 11:37 tiwai          Note Added: 0001862                          
11-09-04 16:35 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
