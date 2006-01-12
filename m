From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001742]: attachment download not possible
Date: Thu, 12 Jan 2006 20:59:26 +0100
Message-ID: <e9b78c880b67b0f35c735842c3cf1f42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D78613E
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 20:59:27 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1742> 
======================================================================
Reported By:                chrmue
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1742
Category:                   bad link
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-12-2006 18:04 CET
Last Modified:              01-12-2006 20:59 CET
======================================================================
Summary:                    attachment download not possible
Description: 
I tried to download
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=1000&type=bug
(issue 1733), but it doesn't work.
I found out that
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=999&type=bug
(issue 1731) doesn't work too. Older attachments are working.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-12-06 20:59 
----------------------------------------------------------------------
Works perfectly for me.  When I click the link I get a blank browser
window, then a few seconds later gedit opens with the patch.

Local issue.  Try wget or a different browser.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-06 18:04 chrmue         New Issue                                    
01-12-06 20:59 rlrevell       Status                   new => closed       
01-12-06 20:59 rlrevell       Note Added: 0007589                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
