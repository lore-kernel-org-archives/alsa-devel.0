From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001946]: cs46xx in Thinkapad A21m after suspend/resume doesn't play
Date: Mon, 20 Mar 2006 20:15:37 +0100
Message-ID: <8a2f4d02592300f31498d96d468c3959@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DF66219
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 20:15:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1946> 
======================================================================
Reported By:                marvin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1946
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.16-RC6
======================================================================
Date Submitted:             03-20-2006 20:15 CET
Last Modified:              03-20-2006 20:15 CET
======================================================================
Summary:                    cs46xx in Thinkapad A21m after suspend/resume
doesn't play
Description: 
When I suspend to Ram and resume cs46xx stop working. If I rmmod modprobe
snd_cs46xx sound start working, but If I do this often comp sometime
freeze when I try suspend to RAM.




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-20-06 20:15 marvin         New Issue                                    
03-20-06 20:15 marvin         Distribution              => Debian Sarge    
03-20-06 20:15 marvin         Kernel Version            => 2.6.16-RC6      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
