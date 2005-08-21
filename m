From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001320]: CA0106 with Soundblaster 24-bit live does not allow recording
Date: Sun, 21 Aug 2005 23:56:08 +0200
Message-ID: <5c1cdb7d6b1e5e5525ee1c927d6bade2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73117208
	for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2005 23:56:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1320> 
======================================================================
Reported By:                ammiellodebar
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1320
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Arch Linux
Kernel Version:             
======================================================================
Date Submitted:             08-08-2005 06:03 CEST
Last Modified:              08-21-2005 23:56 CEST
======================================================================
Summary:                    CA0106 with Soundblaster 24-bit live does not allow
recording
Description: 
When I use the line in on the card, it will not capture unless i crank up
the mixer to near peak, and then its garbled and distorted sound, my
capture is up all the way and i know its not a dumb mistake of mine


======================================================================

----------------------------------------------------------------------
 ammiellodebar - 08-13-05 03:40 
----------------------------------------------------------------------
Unfortunately it doesnt work with 1.0.9b, still the same problem

----------------------------------------------------------------------
 ammiellodebar - 08-21-05 23:56 
----------------------------------------------------------------------
i see jcdutton has fixed this! now..... if only the development version
would compile right without errors!!!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 06:03 ammiellodebar  New Issue                                    
08-08-05 06:03 ammiellodebar  Distribution              => Arch Linux      
08-09-05 04:13 ammiellodebar  Note Added: 0005717                          
08-12-05 23:11 jcdutton       Note Added: 0005791                          
08-12-05 23:11 jcdutton       Status                   assigned => feedback
08-13-05 03:40 ammiellodebar  Note Added: 0005800                          
08-21-05 23:56 ammiellodebar  Note Added: 0005887                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
