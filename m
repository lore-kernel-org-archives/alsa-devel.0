From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000400]: Support for NVidia NForce based AC97 modems
Date: Fri, 24 Sep 2004 13:30:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113005.8B4389073@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2BE35288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:30:06 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000400
======================================================================
Reported By:                sashak
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     400
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-21-2004 16:06 CEST
Last Modified:              09-24-2004 13:30 CEST
======================================================================
Summary:                    Support for NVidia NForce based AC97 modems
Description: 
Support for NVidia NForce based AC97 modems in 'intel8x0m' will be added.
======================================================================

----------------------------------------------------------------------
 sashak - 07-21-2004 16:13 CEST 
----------------------------------------------------------------------
Uploaded patch adds support for NVidia NForce 1,2,3 based AC97 modems.

Tested on NForce 1 with Linux Kernel 2.6.7 .

edited on: 07-21-04 16:13

----------------------------------------------------------------------
 tiwai - 07-30-2004 17:22 CEST 
----------------------------------------------------------------------
Thanks, I applied the patch to cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 16:06 sashak         New Bug                                      
07-21-04 16:09 sashak         File Added: nforce.patch                     
07-21-04 16:09 sashak         Bugnote Added: 0001462                       
07-21-04 16:13 sashak         Bugnote Edited: 0001462                      
07-30-04 17:22 tiwai          Bugnote Added: 0001499                       
07-30-04 17:22 tiwai          Assigned To               => tiwai           
07-30-04 17:22 tiwai          Resolution               open => fixed       
07-30-04 17:22 tiwai          Status                   new => resolved     
09-24-04 13:30 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
