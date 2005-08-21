From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001355]: No sound after resume
Date: Sun, 21 Aug 2005 21:07:14 +0200
Message-ID: <e407a72264b50b6e00045ea51fe4c569@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FBEB1E9
	for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2005 21:07:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1355> 
======================================================================
Reported By:                Adrian Bunk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1355
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-21-2005 21:07 CEST
Last Modified:              08-21-2005 21:07 CEST
======================================================================
Summary:                    No sound after resume
Description: 
I'm currently trying suspend to disk for the first time.

After resuming, there is no sound.

If I build the driver modular and do manually unload and load it after
resuming, sound is working again.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 21:07 Adrian Bunk    New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
