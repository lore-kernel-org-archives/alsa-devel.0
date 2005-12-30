From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001485]: Sound disappears occasionally
Date: Sat, 31 Dec 2005 00:07:43 +0100
Message-ID: <c7d5d86e97e287dff029bb7b605466f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F979178
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:07:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1485> 
======================================================================
Reported By:                jza
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1485
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             10-19-2005 20:56 CEST
Last Modified:              12-31-2005 00:07 CET
======================================================================
Summary:                    Sound disappears occasionally
Description: 
Sound disappears completely when doing rapid consecutive seeks in
applications (gxine, xmms). Restarting the application a few times usually
helps, sometimes a complete system freeze is the result.
======================================================================

----------------------------------------------------------------------
 jza - 10-21-05 09:27 
----------------------------------------------------------------------
When the bug appears, the player sometimes freezes.

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:07 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-05 20:56 jza            New Issue                                    
10-19-05 20:56 jza            Distribution              => Debian          
10-19-05 20:56 jza            Kernel Version            => 2.6.12          
10-20-05 09:57 jza            Note Added: 0006499                          
10-21-05 09:27 jza            Note Added: 0006510                          
12-31-05 00:07 rlrevell       Note Added: 0007308                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
