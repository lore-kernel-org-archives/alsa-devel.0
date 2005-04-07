From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000335]: No support for Soundfont 2.1 modulators
Date: Thu, 7 Apr 2005 20:55:55 +0200
Message-ID: <ad3034e73b84ac46caebf8503f1366ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DD39223C
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 20:55:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=335> 
======================================================================
Reported By:                meneerdik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   335
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-15-2004 12:57 CEST
Last Modified:              04-07-2005 20:55 CEST
======================================================================
Summary:                    No support for Soundfont 2.1 modulators
Description: 
Most of my soundfonts are unusable on Linux because the modulator
definitions in the fonts are not used by the driver. For example, when the
soundfont contains a modulator definition that routes the Expression
controller to the cutoff frequency of a particular instument zone, ALSA
ignores it completely. 
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 20:55 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-04 12:57 meneerdik      New Issue                                    
04-07-05 20:55 jdthood        Note Added: 0004364                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
