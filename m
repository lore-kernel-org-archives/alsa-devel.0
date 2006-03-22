From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001342]: SOund is not working
Date: Wed, 22 Mar 2006 06:27:46 +0100
Message-ID: <9e0d5b5ce34265931583c16fe24c50c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5D391A3
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 06:27:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1342> 
======================================================================
Reported By:                taya
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1342
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.10-5-386
======================================================================
Date Submitted:             08-16-2005 20:11 CEST
Last Modified:              03-22-2006 06:27 CET
======================================================================
Summary:                    SOund is not working
Description: 
Hi, I have laptop: Asus w500
It has integrated sound card: Intel high definition audio.
It seems that alsa driver is working, but it does not.
Please correct this.
Thanks
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:03 
----------------------------------------------------------------------
Was this resolved in later ALSA releases?

----------------------------------------------------------------------
 taya - 03-22-06 06:27 
----------------------------------------------------------------------
In later alsa drivers, sound works visualy (I mean when I make sound up, or
down, or mute it shoes visualy, but still, no sound...)

It appears that it's maybe realtek soundcard..
Anyway, I have this laptop already 1 year, and on Linux sound is not
working :(
I have to still use windows for sound.....

The soundcard is: 	
Built-in Intel High Definition Audio chip, with 3D effect & full duplex
Built-in speaker and microphone

from:
http://www.asus.com/products4.aspx?modelmenu=2&model=414&l1=5&l2=75&l3=0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 20:11 taya           New Issue                                    
08-16-05 20:11 taya           Kernel Version            => 2.6.10-5-386    
03-22-06 03:03 rlrevell       Note Added: 0008792                          
03-22-06 06:27 taya           Note Added: 0008846                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
