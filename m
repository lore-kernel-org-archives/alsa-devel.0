From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001399]: no more IR output after 10 seconds or so
Date: Mon, 5 Sep 2005 20:37:29 +0200
Message-ID: <a3a2148d079197e31e6e7c7aa352304f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1AD2317A
	for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2005 20:37:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1399> 
======================================================================
Reported By:                lbartholdi
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1399
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-05-2005 20:37 CEST
Last Modified:              09-05-2005 20:37 CEST
======================================================================
Summary:                    no more IR output after 10 seconds or so
Description: 
i have a Xitel DG2 usb-IR adapter.
the module compiles and installs with no problems. when selected as
output, works fine for about 10 seconds; and then no more IR output,
while from the computer's perspective everything is fine.
If i skip forward or backward in the player, output resumes; but again
disappears after about 10 seconds.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-05-05 20:37 lbartholdi     New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
