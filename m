From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001256]: surround51: Master Volume control and Mute only have effect on FrontLeft & FrontRight channels.
Date: Mon, 14 Nov 2005 10:24:54 +0100
Message-ID: <292bde67b0c622199139f5f4d45d3ec8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 923CE19E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:24:54 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1256> 
======================================================================
Reported By:                Manolo
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1256
Category:                   2_mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
======================================================================
Date Submitted:             07-13-2005 18:11 CEST
Last Modified:              11-14-2005 10:24 CET
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
known bug, I believe it's #164 if you are using the emu10k1 driver.

----------------------------------------------------------------------
 rlrevell - 07-13-05 18:54 
----------------------------------------------------------------------
Sorry, its #154.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-05 18:11 Manolo         New Issue                                    
07-13-05 18:11 Manolo         Distribution              => Ubuntu          
07-13-05 18:11 Manolo         Kernel Version            => 2.6.11          
07-13-05 18:51 rlrevell       Note Added: 0005464                          
07-13-05 18:54 rlrevell       Note Added: 0005465                          
07-13-05 18:56 rlrevell       Relationship added       duplicate of 0000154
07-16-05 17:10 jdthood        Assigned To               => perex           
07-16-05 17:10 jdthood        Status                   new => acknowledged 
07-16-05 17:10 jdthood        Resolution               open => duplicate   
07-16-05 17:10 jdthood        Additional Information Updated                    
11-14-05 10:24 perex          Project                  ALSA - driver => ALSA -
lib
11-14-05 10:24 perex          Category                 1_OTHERS => 2_mixer 
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
