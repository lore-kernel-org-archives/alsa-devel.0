From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001431]: no sound with msi km4am-l
Date: Fri, 23 Sep 2005 09:53:24 +0200
Message-ID: <95e768a9fff8460ad5c88e19a11ab5fb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3F1D151
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 09:53:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1431> 
======================================================================
Reported By:                bunni
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1431
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               lfs
Kernel Version:             2.6.13.1
======================================================================
Date Submitted:             09-17-2005 02:33 CEST
Last Modified:              09-23-2005 09:53 CEST
======================================================================
Summary:                    no sound with msi km4am-l
Description: 
I hace an msi km4am-l with via 8237 onboard chip. First time i have
compiled the via82xx and bt87x modules (in 2.6.13.1), i haven't any sound
(test with aplay english.au and mythtv). I tried with the alsa 1.09
drivers same problem.
I have plugin my sb live 5.1 and compiled it's module in kernel as module
and it's work fine.
======================================================================

----------------------------------------------------------------------
 bunni - 09-23-05 09:53 
----------------------------------------------------------------------
There is no problem with the driver, i haven't jumper on my motherboard
where i can plug the frontpanel. Sorry

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-17-05 02:33 bunni          New Issue                                    
09-17-05 02:33 bunni          Distribution              => lfs             
09-17-05 02:33 bunni          Kernel Version            => 2.6.13.1        
09-23-05 09:53 bunni          Note Added: 0006364                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
