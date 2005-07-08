From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000710]: Alsa-oss works with mpg123 too...fast!!!
Date: Fri, 8 Jul 2005 10:38:36 +0200
Message-ID: <0ac957b7cd9aa1de047e92bc7f387df0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F888E3
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=710> 
======================================================================
Reported By:                booxter
Assigned To:                jdthood
======================================================================
Project:                    ALSA - liboss
Issue ID:                   710
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             12-05-2004 20:22 CET
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    Alsa-oss works with mpg123 too...fast!!!
Description: 
When I run
aoss mpg123 some.mp3,
I hear all the sound, but too fast (about a 3-5 seconds for a 4minutes
mp3). Other programs that works primarily through OSS (I tested with
mp3blaster and mplayer with -o oss) works with aoss fine.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 23:58 
----------------------------------------------------------------------
Submitter: Is this still a problem in ALSA 1.0.8?

----------------------------------------------------------------------
 jdthood - 03-28-05 04:06 
----------------------------------------------------------------------
Not confirmed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 20:22 booxter        New Issue                                    
12-05-04 20:42 booxter        Note Added: 0002723                          
12-05-04 22:14 eradicator     Issue Monitored: eradicator                    
03-20-05 23:58 jdthood        Note Added: 0004103                          
03-28-05 04:06 jdthood        Status                   new => closed       
03-28-05 04:06 jdthood        Note Added: 0004230                          
03-28-05 04:09 jdthood        Status                   closed => resolved  
03-28-05 04:09 jdthood        Resolution               open => unable to
duplicate
03-28-05 04:09 jdthood        Assigned To               => jdthood         
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
