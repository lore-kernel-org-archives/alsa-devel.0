From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001339]: does audio driver for Intel 945 chipset exist?
Date: Fri, 26 Aug 2005 14:43:00 +0200
Message-ID: <2dd969221dfe5d579f041dd11625b441@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 221261E4
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:43:01 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1339> 
======================================================================
Reported By:                zhllg
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1339
Category:                   PCI - intel8x0m
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-15-2005 20:39 CEST
Last Modified:              08-26-2005 14:43 CEST
======================================================================
Summary:                    does audio driver for Intel 945 chipset exist?
Description: 
as stated in the title
======================================================================

----------------------------------------------------------------------
 tiwai - 08-16-05 18:17 
----------------------------------------------------------------------
It's either snd-hda-intel or snd-intel8x0, depending on the board.
ICH6/7 has both HDA and AC97 interface.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-05 20:39 zhllg          New Issue                                    
08-16-05 18:17 tiwai          Note Added: 0005831                          
08-26-05 14:43 tiwai          Status                   assigned => resolved
08-26-05 14:43 tiwai          Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
