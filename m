From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001574]: mpd loops in random manner.
Date: Thu, 17 Nov 2005 17:45:11 +0100
Message-ID: <2859910e2d28ae3947b31f440f5feb3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D548A1AA
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 17:45:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1574> 
======================================================================
Reported By:                dothebart
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1574
Category:                   0_general
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-17-2005 17:45 CET
Last Modified:              11-17-2005 17:45 CET
======================================================================
Summary:                    mpd loops in random manner.
Description: 
happenes once a week. mpd runs and runs, and suddenly, it loops over 3
seconds or so. Killing mpd and restarting it makes all work fine again.
While looping it starts consuming all cpu it can get.
The guys in #mpd told me, that this was an issue of mmap use in lib alsa.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 17:45 dothebart      New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
