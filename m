From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001964]: CMedia 9880 ECS 915p-a 1.2a NO MIC/LINE IN
Date: Sat, 25 Mar 2006 08:38:26 +0100
Message-ID: <74b27c566ecab1f4f81f4c032b46eda9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6EA941B5
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 08:38:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1964> 
======================================================================
Reported By:                sharpen047
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1964
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-25-2006 08:24 CET
Last Modified:              03-25-2006 08:38 CET
======================================================================
Summary:                    CMedia 9880 ECS 915p-a 1.2a NO MIC/LINE IN
Description: 
alsa mixer is up tried for about 2 months now to fix this... i dont know
what to do tell me what to post and youll get it 

thanks!
======================================================================

----------------------------------------------------------------------
 sharpen047 - 03-25-06 08:38 
----------------------------------------------------------------------
localhost ~ # modprobe snd-hda-intel
WARNING: Error inserting snd_timer
(/lib/modules/2.6.15-gentoo-r1/kernel/sound/acore/snd-timer.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm
(/lib/modules/2.6.15-gentoo-r1/kernel/sound/acore/snd-pcm.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.15-gentoo-r1/alsa-driver/pci/snd-hda-intel.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-06 08:24 sharpen047     New Issue                                    
03-25-06 08:38 sharpen047     Note Added: 0008943                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
