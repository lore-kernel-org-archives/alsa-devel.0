From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001363]: OPL3SA2 PCM mixer needs touched in order for sound to work
Date: Wed, 24 Aug 2005 00:00:20 +0200
Message-ID: <9d216f6cd250f61d437983e3f9b2b557@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF5DB24F
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 00:00:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1363> 
======================================================================
Reported By:                ahaning
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1363
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 9.1
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             08-24-2005 00:00 CEST
Last Modified:              08-24-2005 00:00 CEST
======================================================================
Summary:                    OPL3SA2 PCM mixer needs touched in order for sound
to work
Description: 
On my system with a OPL3SA2 chip, I need to touch the PCM mixer each time I
start to play audio before I hear anything. Touching can consist of moving
the PCM volume up or down a notch or muting/unmuting the mixer.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 00:00 ahaning        New Issue                                    
08-24-05 00:00 ahaning        Distribution              => Slackware 9.1   
08-24-05 00:00 ahaning        Kernel Version            => 2.6.12.2        
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
