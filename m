From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000326]: Emagic EMI 6/2m: no recording
Date: Tue, 30 Aug 2005 12:17:20 +0200
Message-ID: <36e7bb19be38ca969f4910056c2052c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29E191DC
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:17:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=326> 
======================================================================
Reported By:                kompi
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   326
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.7-rc2 (also tested earlier stable versions)
======================================================================
Date Submitted:             06-07-2004 19:52 CEST
Last Modified:              08-30-2005 12:17 CEST
======================================================================
Summary:                    Emagic EMI 6/2m: no recording
Description: 
Cannot get a recording stream from the USB device Emagic EMI 6/2m running
with snd-usb-audio. 
No errors oder hangs are produced. Just a zero stream is outputted (in
every data rate the emi can work with).
The mixer controls are set correctly, nothing is muted.

======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 12:17 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-04 19:52 kompi          New Issue                                    
06-07-04 19:52 kompi          Distribution              => Gentoo Linux    
06-07-04 19:52 kompi          Kernel Version            => 2.6.7-rc2 (also
tested earlier stable versions)
08-30-05 12:17 jdthood        Note Added: 0005968                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
