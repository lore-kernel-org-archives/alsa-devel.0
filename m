From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000692]: Possible ALSA support the EMU 0404 or other EMU card in the future?
Date: Fri, 3 Feb 2006 09:39:43 +0100
Message-ID: <bd58cac50e08bcd9b2c3769748977040@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D21D5190
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 09:39:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=692> 
======================================================================
Reported By:                comp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   692
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-29-2004 14:03 CET
Last Modified:              02-03-2006 09:39 CET
======================================================================
Summary:                    Possible ALSA support the EMU 0404 or other EMU card
in the future?
Description: 
It is possible that ALSA supports EMU cards in the future?

======================================================================

----------------------------------------------------------------------
 comp - 01-31-06 22:35 
----------------------------------------------------------------------
I have 0404 and 1212m cards, and some kernel driver writing experience (in
the past I am worked as SuSE Developer at Hungary, and some other company
projects which requires kernel driver), but I need deep soundcard
information from Creative to estimate the possibility of developing the
emu driver.

----------------------------------------------------------------------
 Henne - 02-03-06 09:39 
----------------------------------------------------------------------
I have an EMU 0404 too. It was recognized by an alsaconf (from 1.0.10
maybe) as an emu10k1, but nothing came out, so somebody must have added
the PciIDs, and hopefully with a little workaround the emu10k1 will work.
I found at the emu site some nice specs about that cards.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 14:03 comp           New Issue                                    
11-29-04 14:15 pzad           Note Added: 0002632                          
01-31-06 21:36 paperclip      Note Added: 0007853                          
01-31-06 22:35 comp           Note Added: 0007855                          
02-03-06 09:39 Henne          Note Added: 0007893                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
