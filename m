From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001085]: amd64 + snd-ioctl32 + totem = hang
Date: Wed, 4 Jan 2006 14:37:46 +0100
Message-ID: <09876a3c94e392a4df30e0b9f017f15b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 502BF184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:37:50 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1085> 
======================================================================
Reported By:                jdthood
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   1085
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-04-2005 10:20 CEST
Last Modified:              01-04-2006 14:37 CET
======================================================================
Summary:                    amd64 + snd-ioctl32 + totem = hang
Description: 
The submitter of Debian bug #298082 writes:

[On amd64] modprobe snd_ioctl32 takes down either X or my kernel when I
try and run totem.  I don't have another computer handy to log in, so I'm
not sure
which is crashing.  
======================================================================

----------------------------------------------------------------------
 jdthood - 01-04-06 14:37 
----------------------------------------------------------------------
Fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-04-05 10:20 jdthood        New Issue                                    
01-04-06 14:37 jdthood        Status                   new => resolved     
01-04-06 14:37 jdthood        Resolution               open => fixed       
01-04-06 14:37 jdthood        Assigned To               => jdthood         
01-04-06 14:37 jdthood        Note Added: 0007418                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
