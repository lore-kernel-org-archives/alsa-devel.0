From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001527]: amixer fails to set right 'Capture Source' channel
Date: Sat, 18 Feb 2006 01:32:51 +0100
Message-ID: <d727763a513e79d7ab07977e73ffccbe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54BFB1AB
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 01:32:51 +0100 (MET)
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


The issue 0001824 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1527> 
======================================================================
Reported By:                tartif
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1527
Category:                   amixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-04-2005 16:11 CET
Last Modified:              11-04-2005 16:11 CET
======================================================================
Summary:                    amixer fails to set right 'Capture Source' channel
Description: 
I use the ice1724 driver (Prodigy 7.1 card), ALSA 1.0.10_rc2 (also happens
with 1.0.9).

amixer fails to set the 'capture source' for the right channel (left is
OK). Left channel is set to that requested, right channel always set to
0.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001824 Always mixed into one channel when reco...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-04-05 16:11 tartif         New Issue                                    
02-11-06 03:49 ikari_01       Issue Monitored: ikari_01                    
02-18-06 01:32 rlrevell       Relationship added       has duplicate 0001824
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
