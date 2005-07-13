From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001256]: surround51: Master Volume control and Mute only have effect on FrontLeft & FrontRight channels.
Date: Wed, 13 Jul 2005 18:56:06 +0200
Message-ID: <bac1eac7390d9aa2870786286f14e02f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1BB91CD
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2005 18:56:11 +0200 (MEST)
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


The following issue has been set as DUPLICATE OF issue 0000154.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1256> 
======================================================================
Reported By:                Manolo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1256
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.11
======================================================================
Date Submitted:             07-13-2005 18:11 CEST
Last Modified:              07-13-2005 18:56 CEST
======================================================================
Summary:                    surround51: Master Volume control and Mute only have
effect on FrontLeft & FrontRight channels.
Description: 
The need for a common Volume Control for the surround51 6 channels is so
obvious that I must be doing something wrong. Please help!


I am newbie here. Is there a search tool to look for bugs/issues?


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000154 Master volume only controls front outpu...
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-13-05 18:51 
----------------------------------------------------------------------
Yes, the same tool you used to file this bug report.  And yes, this is a
known bug, I believe it's
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=164 if you are using the
emu10k1 driver.

----------------------------------------------------------------------
 rlrevell - 07-13-05 18:54 
----------------------------------------------------------------------
Sorry, its https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-05 18:11 Manolo         New Issue                                    
07-13-05 18:11 Manolo         Distribution              => Ubuntu          
07-13-05 18:11 Manolo         Kernel Version            => 2.6.11          
07-13-05 18:51 rlrevell       Note Added: 0005464                          
07-13-05 18:54 rlrevell       Note Added: 0005465                          
07-13-05 18:56 rlrevell       Relationship added       duplicate of 0000154
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
