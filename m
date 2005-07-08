From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000786]: Master can't handle all channel
Date: Fri, 8 Jul 2005 10:35:37 +0200
Message-ID: <08c08e7acf5c6e761cc0179ae9bbdf7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B13C186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:37 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=786> 
======================================================================
Reported By:                voroskoi
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   786
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 duplicate
Duplicate:                  154
Fixed in Version:           
======================================================================
Date Submitted:             01-05-2005 14:13 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    Master can't handle all channel
Description: 
I'm using ALSA on a 5.1 set, but i can't handle all the channels with the
master. Master only handle the front ones, not the center, bass and
rears.

Another similar problem, that i can't handle the rear ones and center at
all. So wheather I mute center and surround or not they sound on same
volume. 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000154 Master volume only controls front outpu...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-05 14:13 voroskoi       New Issue                                    
01-07-05 18:23 tiwai          Relationship added       duplicate of 0000154
01-07-05 18:23 tiwai          Duplicate ID             0 => 154            
01-07-05 18:23 tiwai          Status                   new => resolved     
01-07-05 18:23 tiwai          Resolution               open => duplicate   
01-07-05 18:23 tiwai          Assigned To               => tiwai           
01-07-05 18:23 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
