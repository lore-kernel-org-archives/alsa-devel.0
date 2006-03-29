From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001974]: Error to add a note in a issue.
Date: Wed, 29 Mar 2006 18:50:45 +0200
Message-ID: <dd699f751c58e2de52f338c485e2c98b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7393132
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:50:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1974> 
======================================================================
Reported By:                flujan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1974
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-28-2006 16:14 CEST
Last Modified:              03-29-2006 18:50 CEST
======================================================================
Summary:                    Error to add a note in a issue.
Description: 
APPLICATION ERROR #401

Database query failed. Error received from database was #1062: Duplicate
entry '8994' for key 1 for the query: INSERT INTO
mantis_bugnote_text_table
( note )
VALUES
( 'I have this error with the snd-page-alloc even after a reboot. :( I
tried to add another note but the site presents a error message.
:(\r\n\r\nHow can diagnose this more precisely?\r\n\r\nThanks in advance.'
)
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 18:50 
----------------------------------------------------------------------
Fixed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 16:14 flujan         New Issue                                    
03-29-06 18:50 tiwai          Status                   new => resolved     
03-29-06 18:50 tiwai          Resolution               open => fixed       
03-29-06 18:50 tiwai          Assigned To               => tiwai           
03-29-06 18:50 tiwai          Note Added: 0009001                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
