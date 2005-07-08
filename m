From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000947]: replace audigyls driver with ca0106
Date: Fri, 8 Jul 2005 10:34:54 +0200
Message-ID: <12d79dcd285db4abfc6de8c7c3a5fa6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CEE3917A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=947> 
======================================================================
Reported By:                roerich
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   947
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-27-2005 17:25 CET
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    replace audigyls driver with ca0106
Description: 
Hi,

I just took a look at the soundcard matrix.
There is a section stating that the Creative Labs Audigy LS uses the
audigyls driver. This is true für alsa 1.0.6. Afterwards James changed the
driver name to ca0106. Additionally the SoundBlaster Live 24bit card is
supported by the ca0106 driver.
======================================================================

----------------------------------------------------------------------
 perex - 03-01-05 10:50 
----------------------------------------------------------------------
Fixed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 17:25 roerich        New Issue                                    
03-01-05 10:50 perex          Status                   new => resolved     
03-01-05 10:50 perex          Resolution               open => fixed       
03-01-05 10:50 perex          Assigned To               => perex           
03-01-05 10:50 perex          Note Added: 0003756                          
03-01-05 10:50 perex          Assigned To              perex =>            
03-24-05 21:47 Ariel          Issue Monitored: Ariel                       
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
