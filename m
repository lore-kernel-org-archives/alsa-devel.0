From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001325]: Support for CMMS for SB Live!/Audigy series
Date: Fri, 30 Dec 2005 04:27:45 +0100
Message-ID: <80bc2b471fdb29ac5e34a4d1990abb31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 37D5E1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:27:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1325> 
======================================================================
Reported By:                lolliestick
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1325
Category:                   alsamixer
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-10-2005 00:38 CEST
Last Modified:              12-30-2005 04:27 CET
======================================================================
Summary:                    Support for CMMS for SB Live!/Audigy series
Description: 
Hi,

On my Windows system i always use the default settings for my SB Audigy.
In Linux i also use the default settings. The difference between this two
is that on Windows CMMS is enabled wich isn't the clue with Linux. The
result of that is the huge difference in volume and sound quality.
Ofcourse many people should say to avoid CMMS, but i'm glad it's there and
i use it. Is there a way to implement this feature into Alsa?

Thanks
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:27 
----------------------------------------------------------------------
CMMS is not a hardware feature, it's software upmixing that's done in the
Windows driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-10-05 00:38 lolliestick    New Issue                                    
10-19-05 16:43 lolliestick    Issue Monitored: lolliestick                    
12-30-05 04:27 rlrevell       Status                   new => closed       
12-30-05 04:27 rlrevell       Note Added: 0007208                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
