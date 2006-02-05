From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001822]: Can't record with Hercules Fortissimo II
Date: Sun, 5 Feb 2006 16:16:11 +0100
Message-ID: <18650928c6db3452d02581d830516ba5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 333061A0
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 16:16:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822> 
======================================================================
Reported By:                atler
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1822
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               PLD
Kernel Version:             2.6.14.7
======================================================================
Date Submitted:             02-05-2006 16:16 CET
Last Modified:              02-05-2006 16:16 CET
======================================================================
Summary:                    Can't record with Hercules Fortissimo II
Description: 
I can hear my voice from speakers but "arecord -f cd -t wav out.wav" always
produces 19K-32K file with no sound. What is weird is that I can record
through alsa oss emulation in programs that use /dev/dsp.
Similar problems already appeard here, but none of the solutions worked
for me.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 16:16 atler          New Issue                                    
02-05-06 16:16 atler          File Added: asound.state                     
02-05-06 16:16 atler          Distribution              => PLD             
02-05-06 16:16 atler          Kernel Version            => 2.6.14.7        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
