From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000679]: No sound on rear speakers
Date: Fri, 26 Nov 2004 11:24:51 +0100
Message-ID: <798351ce242651c1bde7e8b2df23ff1b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3DB7239
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2004 11:24:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=679> 
======================================================================
Reported By:                NosyMan
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   679
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-26-2004 10:24 CET
Last Modified:              11-26-2004 11:24 CET
======================================================================
Summary:                    No sound on rear speakers
Description: 
I have no sound on rear speakers in ALSA 1.0.7. The sound was ok in
previous version tested 1.0.5 :-(
======================================================================

----------------------------------------------------------------------
 pzad - 11-26-04 11:02 
----------------------------------------------------------------------
Is this SB Live ????

Please do
alsactl -f test.state store

and attach test.state file

----------------------------------------------------------------------
 NosyMan - 11-26-04 11:24 
----------------------------------------------------------------------
It is SB Live

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-26-04 10:24 NosyMan        New Issue                                    
11-26-04 10:24 NosyMan        Kernel Version            => 2.6.9           
11-26-04 10:51 NosyMan        Issue Monitored: NosyMan                     
11-26-04 11:02 pzad           Note Added: 0002596                          
11-26-04 11:23 NosyMan        Issue End Monitor: NosyMan                    
11-26-04 11:24 NosyMan        File Added: test.state                       
11-26-04 11:24 NosyMan        Note Added: 0002597                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
