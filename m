From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000694]: USB Audio Card Giving Errors
Date: Wed, 1 Dec 2004 00:08:32 +0100
Message-ID: <b978e9b9e7f4b6a6d850636b73d06f95@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 492882B8
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2004 00:08:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=694> 
======================================================================
Reported By:                dave-lew99
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   694
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-01-2004 00:08 CET
Last Modified:              12-01-2004 00:08 CET
======================================================================
Summary:                    USB Audio Card Giving Errors
Description: 
When booting system with Creative MP3+ USB audio card, errors such as
snd_usb_audio: Unknown symbol usb_kill_urb 
snd_usb_lib: unsupported module, tainting kernel are given, these also
show up in dmesg. 

The onboard sound on my laptop works fine (Intel AC '97). The USB card is
detected by Yast in the hardware section but refuses to show up as an
audio card in either alsaconf or the sound section of Yast
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 00:08 dave-lew99     New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
