From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001861]: Computer crashes when any alsa software is ran
Date: Tue, 21 Feb 2006 05:39:34 +0100
Message-ID: <2621a09b3ff86cbc1acf08db43b3cf5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55088196
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 05:39:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1861> 
======================================================================
Reported By:                sdistefano
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1861
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-21-2006 05:39 CET
Last Modified:              02-21-2006 05:39 CET
======================================================================
Summary:                    Computer crashes when any alsa software is ran
Description: 
When running alsaconf, alsamixer or soundgarden (as it handles MIDI) the PC
crashes with the message
Code:Bad EIP value
Kernel panic - not syncing : Fatal exception in interrupt
Same thing happens whenever I try to unload the sound modules.

But it does work great for PCM and DVD playback on SPDIF
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 05:39 sdistefano     New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
