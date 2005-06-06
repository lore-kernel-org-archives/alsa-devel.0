From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001150]: Insufficient info in INSTALL file
Date: Mon, 6 Jun 2005 11:09:52 +0200
Message-ID: <1f7751f4e6eed940077dcf76b7d604f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7F79189
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 11:09:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1150> 
======================================================================
Reported By:                davidramirez
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1150
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-01-2005 20:57 CEST
Last Modified:              06-06-2005 11:09 CEST
======================================================================
Summary:                    Insufficient info in INSTALL file
Description: 
Lines 82+83 of the INSTALL file (in alsa-driver-1.0.9) state that one
should "edit the kernel module config" but it doesn't say what to modify
there...?

Had same doubt with 1.0.8

I guess that for this reason I cant't get a working sound card.
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 11:09 
----------------------------------------------------------------------
I added a note about alsaconf script (in the alsa-utils package) to
alsa-driver/INSTALL now. Anyway, fixes / examples for documentation are
always appreciated.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-01-05 20:57 davidramirez   New Issue                                    
06-06-05 11:09 perex          Status                   new => resolved     
06-06-05 11:09 perex          Resolution               open => fixed       
06-06-05 11:09 perex          Assigned To               => perex           
06-06-05 11:09 perex          Note Added: 0004903                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
