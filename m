From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001810]: pcm multi problem
Date: Fri, 3 Feb 2006 10:54:09 +0100
Message-ID: <554bfed9e6441b95346c82baaaddf2f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E57F16E
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 10:54:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1810> 
======================================================================
Reported By:                danhien_cz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1810
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo-linux
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-03-2006 10:46 CET
Last Modified:              02-03-2006 10:54 CET
======================================================================
Summary:                    pcm multi problem
Description: 
I'm using two sound cards - emu10k1 and via82xx.
I'cant play audio throu both cards togather. 
I've created pcm multi for this use.
Last alsa version in wich it vas working is 1.0.8

======================================================================

----------------------------------------------------------------------
 danhien_cz - 02-03-06 10:54 
----------------------------------------------------------------------
sound card chips
emu10k1 - Creative Labs SB Audigy (rev 03)
via82xx - VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller
(rev 60)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 10:46 danhien_cz     New Issue                                    
02-03-06 10:46 danhien_cz     Distribution              => gentoo-linux    
02-03-06 10:46 danhien_cz     Kernel Version            => 2.6.15          
02-03-06 10:54 danhien_cz     Note Added: 0007894                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
