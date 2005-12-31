From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000032]: PLS include this driver
Date: Sat, 31 Dec 2005 07:29:19 +0100
Message-ID: <26df82a1e89daf225e6ea9a4550b2276@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C02AF8
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 07:29:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=32> 
======================================================================
Reported By:                cijoml
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   32
Category:                   1_OTHERS
Reproducibility:            have not tried
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-03-2004 10:11 CET
Last Modified:              12-31-2005 07:29 CET
======================================================================
Summary:                    PLS include this driver
Description: 
On this site, there is driver for bluez-sco. Could you pls include finally
into main ALSA tree? I use it about 4 mounths without any problem

http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
======================================================================

----------------------------------------------------------------------
 tiwai - 03-10-05 15:24 
----------------------------------------------------------------------
Well, this patch wasn't submitted.

IIRC, the latest bluez CVS includes the external ALSA PCM plugin to
support similar stuff without kernel driver.

----------------------------------------------------------------------
 rlrevell - 12-31-05 07:29 
----------------------------------------------------------------------
Kernel driver is not needed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-04 10:11 cijoml         New Issue                                    
02-03-04 10:11 cijoml         File Added: snd-bluez-sco-2003-09-15.tar.gz       
            
02-06-04 18:34 tiwai          Note Added: 0000197                          
03-10-05 15:19 jdthood        Note Added: 0003861                          
03-10-05 15:24 tiwai          Note Added: 0003863                          
12-31-05 07:29 rlrevell       Status                   new => closed       
12-31-05 07:29 rlrevell       Note Added: 0007351                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
