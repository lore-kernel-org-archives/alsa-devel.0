From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000222]: Request for Microphone support.
Date: Wed, 22 Mar 2006 02:44:57 +0100
Message-ID: <21324751fb34695d1b41bdb6fcd497e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FB9D18D
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 02:44:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=222> 
======================================================================
Reported By:                dolphy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   222
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-19-2004 13:47 CEST
Last Modified:              03-22-2006 02:44 CET
======================================================================
Summary:                    Request for Microphone support.
Description: 
I know my imac (ilamp model) has a microphone but no way to get it working
with alsa. Is it supported ? Is it just alsamixer not supporting it ?
======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-04 17:37 
----------------------------------------------------------------------
the codec chip on snapper is different from the tumbler, so it's
not easy.  looking at the source code of drawin would be the only
proper way.

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:44 
----------------------------------------------------------------------
Is this fixed in recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-04 13:47 dolphy         New Issue                                    
04-19-04 13:47 dolphy         Distribution              => Debian          
04-19-04 13:47 dolphy         Kernel Version            => 2.6.5           
04-20-04 12:47 tiwai          Note Added: 0000874                          
04-20-04 12:53 dolphy         Note Added: 0000877                          
04-20-04 12:56 tiwai          Note Added: 0000879                          
04-20-04 17:27 dolphy         Note Added: 0000887                          
04-23-04 17:37 tiwai          Note Added: 0000910                          
01-04-06 17:14 schwab         Issue Monitored: schwab                      
03-22-06 02:44 rlrevell       Note Added: 0008784                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
