From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001482]: Front channels distorsions in Phase 28
Date: Sat, 31 Dec 2005 00:17:31 +0100
Message-ID: <65e27e5685678e1eadf1e91ae4c6a8c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3882B181
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:17:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1482> 
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1482
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1 Custom epia
======================================================================
Date Submitted:             10-18-2005 11:45 CEST
Last Modified:              12-31-2005 00:17 CET
======================================================================
Summary:                    Front channels distorsions in Phase 28
Description: 
Hello , i have problems on Terratec Phase 28 :

front channels distortions, other no problems (rear , center , side ...)

you can view for sample screenshots of 1000Hz signal applied of front and
rear channels

I use last alsa drivers 1.0.9b and last library on Debian sarge 3.1

thanks 
======================================================================

----------------------------------------------------------------------
 eric - 10-25-05 20:05 
----------------------------------------------------------------------
Hi , with last alsa cvs , same problem.

i don't understand why six channels works perfectly and two have strange 
distortion.

thanks

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:17 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 11:45 eric           New Issue                                    
10-18-05 11:45 eric           File Added: screenshot.zip                    
10-18-05 11:45 eric           Kernel Version            => 2.6.8.1 Custom epia
10-25-05 20:05 eric           Note Added: 0006550                          
10-25-05 20:06 eric           Note Added: 0006551                          
10-25-05 20:09 eric           Note Deleted: 0006551                        
12-31-05 00:17 rlrevell       Note Added: 0007313                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
