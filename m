From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001378]: Surround Channel and Surround mixer doesn't work with a CM9761chip
Date: Tue, 30 Aug 2005 11:33:39 +0200
Message-ID: <c931d989b37d318af46821c4e93bbe3f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDA2D214
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 11:33:39 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1378> 
======================================================================
Reported By:                midnight
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1378
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sid
Kernel Version:             2.6.12.5
======================================================================
Date Submitted:             08-30-2005 11:33 CEST
Last Modified:              08-30-2005 11:33 CEST
======================================================================
Summary:                    Surround Channel and Surround mixer doesn't work
with a CM9761chip
Description: 
The sound works fine on the center, LFE an front channels but I have no
sound on the rear channel. also, I can't change the volume of the surround
mixer in alsamixer (I can juste mute/unmute it).

I use the surround51 device to play my test sound and my test sound is a 6
channels one.

I use the via82xx module

thanks
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 11:33 midnight       New Issue                                    
08-30-05 11:33 midnight       Distribution              => Debian Sid      
08-30-05 11:33 midnight       Kernel Version            => 2.6.12.5        
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
