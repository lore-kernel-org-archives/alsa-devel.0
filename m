From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001406]: Need help
Date: Fri, 30 Dec 2005 23:06:22 +0100
Message-ID: <4ca2576e2c3e0a8e443f8414dc59737c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E7DEE19A
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:06:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1406> 
======================================================================
Reported By:                jlway
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1406
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Sarge i386
Kernel Version:             2.4.27
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-09-2005 05:01 CEST
Last Modified:              12-30-2005 23:06 CET
======================================================================
Summary:                    Need help
Description: 
Where may I get help to complete installation?
I have compiled and installed but unable to get sound.
Perhaps your driver does not support my on-board sound: Analog
Devices SoundMax Integrated Digital Audio
Windows XP driver 5.12.1.3630 by Sensaura Ltd.
Is there a chat room where I can get help?
Thanks, John Way
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-11-05 20:51 
----------------------------------------------------------------------
Did you use alsamixer to unmute all channels and raise the volumes?

Also you can't just install the alsa-driver package, you also need
alsa-kernel and alsa-lib.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:06 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 05:01 jlway          New Issue                                    
09-09-05 05:01 jlway          Distribution              => Sarge i386      
09-09-05 05:01 jlway          Kernel Version            => 2.4.27          
09-11-05 15:14 csabo2         Note Added: 0006140                          
09-11-05 17:05 jlway          Note Added: 0006141                          
09-11-05 20:51 rlrevell       Note Added: 0006143                          
09-12-05 02:11 jlway          Note Edited: 0006141                         
09-13-05 04:27 jlway          Note Edited: 0006141                         
12-30-05 23:06 rlrevell       Status                   new => closed       
12-30-05 23:06 rlrevell       Note Added: 0007277                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
