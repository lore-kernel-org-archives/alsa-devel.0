From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001989]: cannot record on ALC880
Date: Fri, 31 Mar 2006 23:56:09 +0200
Message-ID: <e5e5d7d9f9ef39bc988b47cdeebddcc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36A4E184
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 23:56:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1989> 
======================================================================
Reported By:                pomense
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1989
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core release 3
Kernel Version:             2.6.11.8
======================================================================
Date Submitted:             03-31-2006 23:56 CEST
Last Modified:              03-31-2006 23:56 CEST
======================================================================
Summary:                    cannot record on ALC880
Description: 
the snd_hda_intel module loads and recognize tha ALC880 sound card on my
Acer TM 8104WLMi, but I cannot record anything, neither via Front Mic or
using Mic as recording source. I can play sound very well.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 23:56 pomense        New Issue                                    
03-31-06 23:56 pomense        File Added: lspc-nv                          
03-31-06 23:56 pomense        Distribution              => Fedora Core release 3
03-31-06 23:56 pomense        Kernel Version            => 2.6.11.8        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
