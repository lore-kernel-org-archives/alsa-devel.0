From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001229]: Can't modprobe sound module
Date: Fri, 8 Jul 2005 10:21:10 +0200
Message-ID: <b7bd772cb91fd117ad3a3239166208b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB1B4181
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:21:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1229> 
======================================================================
Reported By:                oui
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1229
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-03-2005 11:48 CEST
Last Modified:              07-08-2005 10:21 CEST
======================================================================
Summary:                    Can't modprobe sound module
Description: 
I use sound card Intel 82801DB AC'97 .I download alsa-driver ,alsa-lib and
alsa-util and follow your instruction but I can't modprobe intel8x0 it
said not found module device .Please tell me what I should do?
======================================================================

----------------------------------------------------------------------
 oui - 07-04-05 17:06 
----------------------------------------------------------------------
To jcdutton 
Thanks for your answer but I type modprobe snd-intel8x0 
It said not find module device and now I can't use sound anymore.

----------------------------------------------------------------------
 perex - 07-08-05 10:21 
----------------------------------------------------------------------
Any messages in /var/log/messages? Please, copy and paste the commands and
output from them which you tried. Please, be verbose.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 11:48 oui            New Issue                                    
07-03-05 12:14 jcdutton       Note Added: 0005374                          
07-04-05 17:06 oui            Note Added: 0005386                          
07-08-05 10:21 perex          Note Added: 0005404                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
