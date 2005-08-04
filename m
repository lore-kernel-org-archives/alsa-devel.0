From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001311]: drivers load but unmuting channels / adjusting volumes does not produce any sound
Date: Fri, 5 Aug 2005 01:10:02 +0200
Message-ID: <0b885818367dc71c277032189c84b10c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5EDB51EE
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 01:10:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1311> 
======================================================================
Reported By:                hettar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1311
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.10
======================================================================
Date Submitted:             08-05-2005 01:10 CEST
Last Modified:              08-05-2005 01:10 CEST
======================================================================
Summary:                    drivers load but unmuting channels / adjusting
volumes does not produce any sound
Description: 
I have installed the 1.0.9b version of alsa kernel/libs and utils in an
attempt to get the intel high definition sound card working. These all
appear to work, I can unmute the various channels, adjust volumes etc,
however no matter what I do I can't get any sound out. Sound apps are all
playing fine but don't actually produce any sound.

This is the card in the new ASUS W2 laptop and could be slightly different
to other models.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-05 01:10 hettar         New Issue                                    
08-05-05 01:10 hettar         Distribution              => Ubuntu          
08-05-05 01:10 hettar         Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
