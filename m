From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001628]: Unable to get digital surround sound out of via sound driver
Date: Tue, 13 Dec 2005 21:07:54 +0100
Message-ID: <e12472103b3d6005eb07887904367d82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 412F01C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 21:07:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1628> 
======================================================================
Reported By:                msillence
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1628
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             12-07-2005 21:34 CET
Last Modified:              12-13-2005 21:07 CET
======================================================================
Summary:                    Unable to get digital surround sound out of via
sound driver
Description: 
I can get digital sterio sound out OK but not surround.
======================================================================

----------------------------------------------------------------------
 msillence - 12-11-05 19:56 
----------------------------------------------------------------------
I was hoping to get 6 channel sound out of the driver thought the digital
SPDIF connector. I've got the front 2 channels OK but nothing out of the
other speakers.

----------------------------------------------------------------------
 msillence - 12-13-05 21:07 
----------------------------------------------------------------------
I've also found other references to this problem and there are links to the
sound test files here:
http://wastelands.net/d470k/index.php/SurroundSound

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-05 21:34 msillence      New Issue                                    
12-07-05 21:34 msillence      Distribution              => Debian          
12-07-05 21:34 msillence      Kernel Version            => 2.6.12          
12-08-05 17:23 tiwai          Note Added: 0006958                          
12-11-05 19:56 msillence      Note Added: 0006978                          
12-13-05 21:07 msillence      Issue Monitored: msillence                    
12-13-05 21:07 msillence      Note Added: 0007024                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
