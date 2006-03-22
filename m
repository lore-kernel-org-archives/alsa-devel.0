From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001952]: Simultaneous sound from speakers and headphone on DELL Inspiron 9400
Date: Wed, 22 Mar 2006 15:48:55 +0100
Message-ID: <049e06de838b99f4eb59d218b3e01910@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2B831A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 15:48:55 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1952> 
======================================================================
Reported By:                crissi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1952
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-22-2006 02:12 CET
Last Modified:              03-22-2006 15:48 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone on
DELL Inspiron 9400
Description: 
This still happens with cvs.
======================================================================

----------------------------------------------------------------------
 crissi - 03-22-06 15:45 
----------------------------------------------------------------------
it works only if model=test, I found that later ;)

----------------------------------------------------------------------
 tiwai - 03-22-06 15:48 
----------------------------------------------------------------------
It can't be.  There is no "test" model for sigmatel codecs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-06 02:12 crissi         New Issue                                    
03-22-06 04:54 crissi         Note Added: 0008843                          
03-22-06 05:15 rlrevell       Status                   assigned => resolved
03-22-06 05:15 rlrevell       Resolution               open => fixed       
03-22-06 05:15 rlrevell       Note Added: 0008844                          
03-22-06 15:45 crissi         Status                   resolved => feedback
03-22-06 15:45 crissi         Resolution               fixed => reopened   
03-22-06 15:45 crissi         Note Added: 0008857                          
03-22-06 15:48 tiwai          Status                   feedback => resolved
03-22-06 15:48 tiwai          Resolution               reopened => fixed   
03-22-06 15:48 tiwai          Note Added: 0008859                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
