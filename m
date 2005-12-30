From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000024]: suspend-resume cycle either hardlocks or locks soundcard (reboot necessary)
Date: Fri, 30 Dec 2005 03:59:49 +0100
Message-ID: <dc6d712586577845bf3737c4f1cb5071@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22EE218F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 03:59:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24> 
======================================================================
Reported By:                runia
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   24
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               debian
Kernel Version:             2.4.22
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-01-2004 13:10 CET
Last Modified:              12-30-2005 03:59 CET
======================================================================
Summary:                    suspend-resume cycle either hardlocks or locks
soundcard (reboot necessary)
Description: 
See summary.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-10-05 15:20 
----------------------------------------------------------------------
Does version 1.0.8 of the intel8x0 driver still lock your soundcard or
your system after resume?

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:59 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-04 13:10 runia          New Issue                                    
02-02-04 15:23 tiwai          Note Added: 0000107                          
02-02-04 18:55 runia          File Added: alsadebug.log.bz2                    
02-02-04 18:56 runia          Note Added: 0000116                          
02-02-04 18:56 runia          Note Edited: 0000116                         
02-02-04 19:08 tiwai          Note Added: 0000117                          
02-02-04 19:22 runia          Note Added: 0000118                          
03-10-05 15:20 jdthood        Note Added: 0003862                          
12-30-05 03:59 rlrevell       Status                   new => closed       
12-30-05 03:59 rlrevell       Note Added: 0007195                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
