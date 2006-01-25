From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001782]: really poor sound with my SB Live 1024 and ALSA
Date: Wed, 25 Jan 2006 06:30:56 +0100
Message-ID: <31d005f67af7a2a75d5c2424d6e21565@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4539C172
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 06:30:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1782> 
======================================================================
Reported By:                novazur
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1782
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             all what I tried, actually 2.6.15-1
======================================================================
Date Submitted:             01-25-2006 06:30 CET
Last Modified:              01-25-2006 06:30 CET
======================================================================
Summary:                    really poor sound with my SB Live 1024 and ALSA
Description: 
Each time I tried to use ALSA with my SB Live, I always had a really very
bad sound.
I spent hours and hours to make it working better, but always had to come
back to OSS. And, with OSS, I have a real perfect sound, on my 5.1 Altec
Lansing kit.

I'm afraid now to see OSS will definitively be removed from kernel.

My english is too poor too, to explain exactly what I mean by "poor
sound", but I can tell you the sound isn't good at all with ALSA and my
card.


00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
        Subsystem: Creative Labs SBLive! 5.1 Digital Model SB0220
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-06 06:30 novazur        New Issue                                    
01-25-06 06:30 novazur        Distribution              => Gentoo          
01-25-06 06:30 novazur        Kernel Version            => all what I tried,
actually 2.6.15-1
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
