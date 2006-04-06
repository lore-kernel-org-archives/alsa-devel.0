From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001826]: No line, mic, front-mic
Date: Fri, 7 Apr 2006 00:54:05 +0200
Message-ID: <7fe82fe393f5e8e84eaa15cdaab9ff5d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44E1D15E
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 00:54:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1826> 
======================================================================
Reported By:                andreid1303
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1826
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-06-2006 22:35 CET
Last Modified:              04-07-2006 00:54 CEST
======================================================================
Summary:                    No line, mic, front-mic
Description: 
Line, mic, front-mic sound is dead on build-in Sigmatel 9221.
First I was not able to get it in Windows as well but found there a switch
assigning capture input then rised capture level and it is working now.
I tried to do the same via alsamixer but with no result.
======================================================================

----------------------------------------------------------------------
 mate - 04-06-06 03:42 
----------------------------------------------------------------------
I have same problem too (I tried the latest cvs version from 6. Apr.
2006).
Please fix this issue or if somebody have any idea please send me about
it.
Thanx.

----------------------------------------------------------------------
 sharpen047 - 04-07-06 00:54 
----------------------------------------------------------------------
i have seen several threads about this i have one too... and i cant find
ANY solution for me thus.. im on windows *bleh*

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 22:35 andreid1303    New Issue                                    
02-07-06 09:23 hweigel        Issue Monitored: hweigel                     
04-06-06 03:42 mate           Note Added: 0009122                          
04-07-06 00:54 sharpen047     Note Added: 0009128                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
