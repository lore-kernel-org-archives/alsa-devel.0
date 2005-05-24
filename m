From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001117]: Sequencer documentation for snd-trident-synth
Date: Tue, 24 May 2005 11:58:02 +0200
Message-ID: <49311d141f7f630693ae6d16d146d140@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28C391DD
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 11:58:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1117> 
======================================================================
Reported By:                keinstein
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1117
Category:                   PCI - trident
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-18-2005 17:18 CEST
Last Modified:              05-24-2005 11:58 CEST
======================================================================
Summary:                    Sequencer documentation for snd-trident-synth
Description: 
Im searching the net for years, but I didn't really find any documentation
about the snd-trident-synth module. I would like to know how does it work?
Does it work on SIS 7018 at all? Which programs do I have to use for it?
In the /proc tree  I get information that I have 8 MB Wavetable space, but
I really don't know, how to access them. 

Please add a Readme.trident to the alsa documentation directory
======================================================================

----------------------------------------------------------------------
 tiwai - 05-24-05 11:58 
----------------------------------------------------------------------
The implementation isn't complete.  Only a legacy module-player would work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-05 17:18 keinstein      New Issue                                    
05-24-05 11:58 tiwai          Note Added: 0004711                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
