From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001652]: ASUS P5AD2E-Premium CMI 9880 with HDA_INTEL driver output and input entry missing
Date: Thu, 13 Apr 2006 08:56:18 +0200
Message-ID: <358cdb8932784fb0aabbbcf00d69207f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 090D8147
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 08:56:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1652> 
======================================================================
Reported By:                dschaefer79
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1652
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux 2005.1 X86_64
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-15-2005 18:40 CET
Last Modified:              04-13-2006 08:56 CEST
======================================================================
Summary:                    ASUS P5AD2E-Premium CMI 9880 with HDA_INTEL driver
output and input entry missing
Description: 
Hi,

My onboard soundcard works great with linux but I don't have a Master
Output nor microphone ,cd, aux input under my linux. I try to use my tv
sound with input but it doesn't work.

Is it possible to add this ??
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-13-06 00:00 
----------------------------------------------------------------------
Should be fixed in 1.0.11-rc5

----------------------------------------------------------------------
 bduc - 04-13-06 08:56 
----------------------------------------------------------------------
Ok upgraded drivers to 1.0.11-rc5 :-( still the same; 

Maybe there is an option I have to specify ?
Any way I can further debug to help you all out ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-05 18:40 dschaefer79    New Issue                                    
12-15-05 18:40 dschaefer79    Distribution              => Gentoo Linux 2005.1
X86_64
12-15-05 18:40 dschaefer79    Kernel Version            => 2.6.14          
12-15-05 19:14 dschaefer79    Issue Monitored: dschaefer79                    
04-12-06 23:35 bduc           Note Added: 0009251                          
04-12-06 23:35 bduc           Issue Monitored: bduc                        
04-13-06 00:00 rlrevell       Note Added: 0009252                          
04-13-06 08:56 bduc           Note Added: 0009254                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
