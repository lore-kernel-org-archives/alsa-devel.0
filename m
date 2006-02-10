From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001835]: Patch to add volume control per voice for au88x0
Date: Fri, 10 Feb 2006 03:28:37 +0100
Message-ID: <4f9f886345485ca26e31bcc562e621ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8CAFFA
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 03:28:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1835
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-10-2006 03:28 CET
Last Modified:              02-10-2006 03:28 CET
======================================================================
Summary:                    Patch to add volume control per voice for au88x0
Description: 
As the proposed API "PCM volume control per snd_pcm_open()" have not been
finalised, I upload the program ( a workaround tool instead of demo ) to
test the new feature "Volume control per voice" for au88x0 using
SNDRV_CTL_ELEM_IFACE_PCM
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 03:28 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
