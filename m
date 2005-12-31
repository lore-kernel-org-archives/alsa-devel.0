From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000937]: No sound unless using OSS driver
Date: Sat, 31 Dec 2005 04:06:49 +0100
Message-ID: <6fc01d968f24cf46217aa9561abf309a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9CEE15E
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:06:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=937> 
======================================================================
Reported By:                ruffasdagut
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   937
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Fedora
Kernel Version:             2.6
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-24-2005 01:14 CET
Last Modified:              12-31-2005 04:06 CET
======================================================================
Summary:                    No sound unless using OSS driver
Description: 
I have no sound from the system unless using the OSS option in gstreamer
properties. If I do this I get sound but no control over the volume or
mute. I dont really need all the digital parts, but just the Basic sound
would be nice. I am going to include the ouput from the alsa debug program
I found online. Thanks for looking into this issue.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-13-05 17:24 
----------------------------------------------------------------------
Submitter: Any improvement in the 1.0.9rc2 release?

----------------------------------------------------------------------
 rlrevell - 12-31-05 04:06 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-05 01:14 ruffasdagut    New Issue                                    
02-24-05 01:14 ruffasdagut    File Added: debug.log                        
02-24-05 01:14 ruffasdagut    Distribution              => Fedora          
02-24-05 01:14 ruffasdagut    Kernel Version            => 2.6             
02-24-05 22:00 tiwai          Note Added: 0003725                          
02-24-05 23:27 ruffasdagut    Note Added: 0003730                          
02-24-05 23:29 ruffasdagut    Issue Monitored: ruffasdagut                    
02-24-05 23:29 ruffasdagut    Issue End Monitor: ruffasdagut                    
04-13-05 17:24 jdthood        Note Added: 0004475                          
12-31-05 04:06 rlrevell       Status                   new => closed       
12-31-05 04:06 rlrevell       Note Added: 0007337                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
