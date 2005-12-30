From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0001119]: USB headset not working
Date: Fri, 30 Dec 2005 21:12:22 +0100
Message-ID: <e3304ec000061ec7834ea6fa9dd44c7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF324159
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 21:12:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1119> 
======================================================================
Reported By:                donlvnv
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   1119
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-20-2005 08:48 CEST
Last Modified:              12-30-2005 21:12 CET
======================================================================
Summary:                    USB headset not working
Description: 
using ac97 on a Shuttle SFF and suse 9.3 with a Logitech 300 headset.
The headset won't work. I have tried it with Knoppix 3.8 Livecd.
Kmix recognizes it and it work under knoppix, but as soon as I run
alsaconf.
The Headset stops working and there is no tab for it in Kmix.
Alsamixer has no place for it under suse or knoppix. I have got it to
output to the headset in Control Center,Sound & Multimedia,Sound
System.Hardware tab by overriding device location to /dev/dsp1, and then
in the general tab and selecting  the test sound.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 21:12 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-05 08:48 donlvnv        New Issue                                    
05-20-05 08:51 donlvnv        Issue Monitored: donlvnv                     
12-30-05 21:12 rlrevell       Note Added: 0007262                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
