From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001113]: application crash
Date: Sat, 31 Dec 2005 03:29:48 +0100
Message-ID: <3e607ed5c72dbab60b7e32421f748c8b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1FF0C12B
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:29:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1113> 
======================================================================
Reported By:                Yota_VGA
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1113
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.8-gentoo-r9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-16-2005 19:52 CEST
Last Modified:              12-31-2005 03:29 CET
======================================================================
Summary:                    application crash
Description: 
Some applications crash when i listen a wave with aplay (and in some other
circostances, i've not be tested very well), like as xmms (when I use the
alsa plugin and I play a song) and alsamixer.
======================================================================

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:33 
----------------------------------------------------------------------
This is most likely a bug in xmms.

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:29 
----------------------------------------------------------------------
Application bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-16-05 19:52 Yota_VGA       New Issue                                    
05-16-05 19:52 Yota_VGA       Distribution              => gentoo          
05-16-05 19:52 Yota_VGA       Kernel Version            => 2.6.8-gentoo-r9 
05-27-05 12:12 Stephan Wurm   Note Added: 0004745                          
05-27-05 12:13 Stephan Wurm   Issue Monitored: Stephan Wurm                    
05-27-05 12:13 Stephan Wurm   Note Added: 0004746                          
05-28-05 12:33 jcdutton       Note Added: 0004773                          
12-31-05 03:29 rlrevell       Status                   new => closed       
12-31-05 03:29 rlrevell       Note Added: 0007328                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
