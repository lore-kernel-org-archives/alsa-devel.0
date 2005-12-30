From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000802]: ymfpci seems to export wrong values for period_count/period_size/buffer_size
Date: Fri, 30 Dec 2005 22:14:25 +0100
Message-ID: <e2b2e5ff6545cfe88ef6efb90c52f979@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53331190
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 22:14:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=802> 
======================================================================
Reported By:                slomosnail
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   802
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2005 18:42 CET
Last Modified:              12-30-2005 22:14 CET
======================================================================
Summary:                    ymfpci seems to export wrong values for
period_count/period_size/buffer_size
Description: 
See here: http://bugzilla.gnome.org/show_bug.cgi?id=162024
======================================================================

----------------------------------------------------------------------
 jdthood - 09-15-05 15:06 
----------------------------------------------------------------------
Could you create a small testcase to reproduce this?

----------------------------------------------------------------------
 rlrevell - 12-30-05 22:14 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 18:42 slomosnail     New Issue                                    
01-11-05 16:48 tiwai          Note Added: 0003156                          
01-18-05 13:28 LeRoutier      Note Added: 0003248                          
01-18-05 14:40 LeRoutier      Issue Monitored: LeRoutier                    
01-19-05 14:32 tiwai          Note Added: 0003270                          
01-27-05 00:39 adamk75        Issue Monitored: adamk75                     
09-15-05 15:06 jdthood        Note Added: 0006200                          
09-15-05 15:06 jdthood        Status                   new => feedback     
12-30-05 22:14 rlrevell       Status                   feedback => closed  
12-30-05 22:14 rlrevell       Note Added: 0007270                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
