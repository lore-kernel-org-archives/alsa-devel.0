From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio adapter
Date: Wed, 2 Mar 2005 12:34:34 +0100
Message-ID: <5870dd5afc6fe7314e2c21cd10d0f21b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 929ED1F1
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2005 12:34:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=955> 
======================================================================
Reported By:                mano1979
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   955
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.1
Kernel Version:             2.6.10.3
======================================================================
Date Submitted:             03-02-2005 00:13 CET
Last Modified:              03-02-2005 12:34 CET
======================================================================
Summary:                    CN-126 - USB 5.1 Audio adapter
Description: 
I am in really need of a driver for this card. It needs to support 5.1
surround and speaker setup....... well like the original software.

Please let me know if you're able to make it.

Regards, 

Armand Blaaker
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-02-05 09:28 
----------------------------------------------------------------------
The manual (a .doc file, ouch) says that the device is Audio Class
compliant, so it should work with the standard driver.

What is the problem?

----------------------------------------------------------------------
 mano1979 - 03-02-05 12:34 
----------------------------------------------------------------------
The problem is that i want to use my 5.1 speakerset and my sound driver
doesn't support that at this moment. I can't setup the speakers(volume per
speaker) and i have no downmix driver for 2 channelled audio to 5.1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 00:13 mano1979       New Issue                                    
03-02-05 00:13 mano1979       Distribution              => Mandrake 10.1   
03-02-05 00:13 mano1979       Kernel Version            => 2.6.10.3        
03-02-05 00:14 mano1979       Issue Monitored: mano1979                    
03-02-05 09:28 Clemens LadischNote Added: 0003762                          
03-02-05 12:34 mano1979       Note Added: 0003763                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
