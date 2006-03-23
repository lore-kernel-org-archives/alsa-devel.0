From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001951]: Microphone doesnt work
Date: Thu, 23 Mar 2006 17:04:11 +0100
Message-ID: <447be0e99b5a3e871dacabf89a56aab3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3EE731BB
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 17:04:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1951> 
======================================================================
Reported By:                crissi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1951
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 duplicate
Duplicate:                  1953
Fixed in Version:           
======================================================================
Date Submitted:             03-22-2006 01:31 CET
Last Modified:              03-23-2006 17:04 CET
======================================================================
Summary:                    Microphone doesnt work
Description: 
I cant get any input from mic.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001953 Onboard Soundcard (STAC9221) records on...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-23-06 16:47 
----------------------------------------------------------------------
Apply it on alsa-kernel directory.

----------------------------------------------------------------------
 crissi - 03-23-06 17:02 
----------------------------------------------------------------------
Cool! works fine now!!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-06 01:31 crissi         New Issue                                    
03-22-06 01:42 rlrevell       Note Added: 0008767                          
03-22-06 15:47 crissi         Note Added: 0008858                          
03-22-06 15:47 crissi         Issue Monitored: crissi                      
03-23-06 16:10 tiwai          Note Added: 0008885                          
03-23-06 16:24 crissi         Note Added: 0008887                          
03-23-06 16:47 tiwai          Note Added: 0008888                          
03-23-06 17:02 crissi         Note Added: 0008890                          
03-23-06 17:04 tiwai          Relationship added       duplicate of 0001953
03-23-06 17:04 tiwai          Duplicate ID             0 => 1953           
03-23-06 17:04 tiwai          Status                   assigned => resolved
03-23-06 17:04 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
