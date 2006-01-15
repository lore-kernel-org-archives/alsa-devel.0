From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001750]: SPDIF sound only in stereo
Date: Sun, 15 Jan 2006 05:20:54 +0100
Message-ID: <f5ff7e6f5da559d27f2ee292c292b78e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B614E13E
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 05:20:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1750> 
======================================================================
Reported By:                MechCow
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1750
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.12
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-15-2006 04:57 CET
Last Modified:              01-15-2006 05:20 CET
======================================================================
Summary:                    SPDIF sound only in stereo
Description: 
I can only get stereo sound out of the ca0106. All other volumes are at
standard levels. 

I'm using the SB Live 24Bit card. 

0000:00:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

I'm using a 2.6.12 kernel I compiled myself and alsa installed from debian
unstable. 

I have connected the soundcard up as it specifies in the manual, the top
slot connected by a miniplug-to-rca into the coaxial of my panasonic 5.1
surround sound system. 
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-15-06 05:20 
----------------------------------------------------------------------
Dupe of 1749

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 04:57 MechCow        New Issue                                    
01-15-06 04:57 MechCow        Distribution              => Debian          
01-15-06 04:57 MechCow        Kernel Version            => 2.6.12          
01-15-06 05:20 rlrevell       Status                   assigned => closed  
01-15-06 05:20 rlrevell       Note Added: 0007660                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
