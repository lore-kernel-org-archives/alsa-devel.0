From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001364]: Channel mapping mixed-up for SB Extigy
Date: Wed, 24 Aug 2005 01:00:18 +0200
Message-ID: <333da743fa284a7a092922e77c0ebbc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 01C7B23E
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 01:00:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1364> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1364
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.12.1
======================================================================
Date Submitted:             08-24-2005 01:00 CEST
Last Modified:              08-24-2005 01:00 CEST
======================================================================
Summary:                    Channel mapping mixed-up for SB Extigy
Description: 
The channels mapping for my Extigy seems to be wrong.
"Rear Left" controls the Subwoofer
"Rear Right" controls the left rear speaker
"Subwoofer" controls the right rear speaker
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 01:00 andersin       New Issue                                    
08-24-05 01:00 andersin       Distribution              => Gentoo Linux    
08-24-05 01:00 andersin       Kernel Version            => 2.6.12.1        
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
