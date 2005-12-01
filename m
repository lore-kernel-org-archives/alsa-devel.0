From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000562]: No AC3 sound playable through S/PDIF with certain amplifiers
Date: Thu, 1 Dec 2005 02:24:17 +0100
Message-ID: <9eccce2364f9f9e9652ad9218afcbd6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 813C2177
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2005 02:24:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=562> 
======================================================================
Reported By:                herpes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   562
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             10-03-2004 10:38 CEST
Last Modified:              12-01-2005 02:24 CET
======================================================================
Summary:                    No AC3 sound playable through S/PDIF with certain
amplifiers
Description: 
This has already been on the mailing list, see also
http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg13822.html.

When playing AC3 through the S/PDIF out on my Terratec 512i, I get no
sound at all. Normal PCM and DTS streams work.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000481 IEC958 Output doesn't work
has duplicate       0001359 cs46xx DTS pass through works, but AC3/...
======================================================================

----------------------------------------------------------------------
 Gregoire - 09-22-05 16:10 
----------------------------------------------------------------------
Is there anything I could provide in order to have this bug resolved ?
My PC has also a SBLive and a via82xx in, for both AC3 works, but I need
the PCI of the SBLive and the quality of thevia82xx is not good (and I
need the firewire of the cs46xx card). Thank you very much :)

----------------------------------------------------------------------
 wolfman - 12-01-05 02:24 
----------------------------------------------------------------------
I would like this problem to be fixed, since all my dvds have AC-3 tracks
and only a few have DTS.  I don't have a problem compiling code, and I
would be happy to test some if someone would give me some instructions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 10:38 herpes         New Issue                                    
10-03-04 10:38 herpes         Distribution              => Debian          
10-03-04 10:38 herpes         Kernel Version            => 2.6.8.1         
10-06-04 12:14 tiwai          Note Added: 0002023                          
10-12-04 14:48 tiwai          Note Added: 0002097                          
10-19-04 00:46 herpes         File Added: codec-details-while-playing-dts.txt   
                
10-19-04 00:46 herpes         File Added: codec-details-while-playing-AC3.txt   
                
10-19-04 00:58 herpes         Note Added: 0002201                          
10-19-04 12:37 tiwai          Note Added: 0002203                          
04-09-05 16:20 jdthood        Relationship added       duplicate of 0000481
08-25-05 10:10 rjh            Issue Monitored: rjh                         
08-25-05 11:56 tiwai          Relationship added       has duplicate 0001359
09-22-05 16:10 Gregoire       Note Added: 0006353                          
12-01-05 01:05 wolfman        Issue Monitored: wolfman                     
12-01-05 02:24 wolfman        Note Added: 0006881                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
