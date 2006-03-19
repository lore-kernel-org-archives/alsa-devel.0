From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001930]: Can`t get timidity woking in soft synth mode
Date: Sun, 19 Mar 2006 23:55:08 +0100
Message-ID: <f52c6fb4758c07d195bb1d01a1b8cad5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B84421E1
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 23:55:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1930> 
======================================================================
Reported By:                drolyk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1930
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-15-2006 23:41 CET
Last Modified:              03-19-2006 23:55 CET
======================================================================
Summary:                    Can`t get timidity woking in soft synth mode
Description: 
Can`t get timidity woking in "soft synth mode".
======================================================================

----------------------------------------------------------------------
 fdoffizi01 - 03-19-06 23:55 
----------------------------------------------------------------------
Well it seems it's not full of information here but it's something I can't
get to make work too.
I was using an intel8x0 and I had problems, now I've got a hda-intel and
still having similar problems.
I can start timidity as player without problem, I can start it as alsa
soft synth but when I use some apps to play with it through virtual port I
got no sound. It's the same with fluidsynth so maybe a problem with
something in new alsalib (can't say how much new)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 23:41 drolyk         New Issue                                    
03-15-06 23:41 drolyk         Distribution              => Debian          
03-15-06 23:41 drolyk         Kernel Version            => 2.6.15.6        
03-19-06 23:55 fdoffizi01     Note Added: 0008700                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
