From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000592]: Need addition to the INSTALL file please
Date: Thu, 16 Dec 2004 18:12:05 +0100
Message-ID: <45328613d88cfd2a1e4ae34a3bb22327@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ACD3D245
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:12:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=592> 
======================================================================
Reported By:                JColeman
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   592
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-21-2004 11:16 CEST
Last Modified:              12-16-2004 18:12 CET
======================================================================
Summary:                    Need addition to the INSTALL file please
Description: 
bash-2.05b# alsaconf
/usr/sbin/alsaconf: line 33: [: too many arguments
/usr/sbin/alsaconf: line 35: [: too many arguments
modinfo: could not find module snd
modinfo: could not find module snd
modinfo: could not find module snd
which: no dialog in
(/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin)
which: no whiptail in
(/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin)
Error, dialog or whiptail not found.
bash-2.05b#

======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:40 
----------------------------------------------------------------------
I added the requirements section in INSTALL.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-04 11:16 JColeman       New Issue                                    
10-21-04 11:17 JColeman       Issue Monitored: JColeman                    
11-09-04 19:40 tiwai          Status                   new => resolved     
11-09-04 19:40 tiwai          Resolution               open => fixed       
11-09-04 19:40 tiwai          Assigned To               => tiwai           
11-09-04 19:40 tiwai          Note Added: 0002348                          
12-16-04 18:12 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
