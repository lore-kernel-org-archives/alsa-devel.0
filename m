From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001322]: C-Media HD Audio 7.1 CODEC  of motherboard Asus P5GDC Deluxe NO MODULE
Date: Thu, 11 Aug 2005 14:29:11 +0200
Message-ID: <a7491f75c624f605c7676e110583503b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 468C81AF
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2005 14:29:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1322> 
======================================================================
Reported By:                SOHAM
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1322
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             08-08-2005 19:59 CEST
Last Modified:              08-11-2005 14:29 CEST
======================================================================
Summary:                    C-Media HD Audio 7.1 CODEC  of motherboard Asus
P5GDC Deluxe NO MODULE
Description: 
The chip C-Media 7.1 integrated in the motherboard Asus P5GDC Deluxe does
not work with none of the modules of Alsa. Can you send me one module of
sound for this motherboard? or can you say me what can I do?

Thanks.

======================================================================

----------------------------------------------------------------------
 tiwai - 08-11-05 14:29 
----------------------------------------------------------------------
The driver must be snd-hda-intel.  Try the latest version of ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 19:59 SOHAM          New Issue                                    
08-08-05 19:59 SOHAM          Kernel Version            => 2.6.11          
08-11-05 14:29 tiwai          Note Added: 0005757                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
