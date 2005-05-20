From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0001119]: USB headset not working
Date: Fri, 20 May 2005 08:48:36 +0200
Message-ID: <a76aa99f8be328c8685ddbafc45e54b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C04D225
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2005 08:48:37 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              05-20-2005 08:48 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-05 08:48 donlvnv        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
