From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001284]: Soundfont notes problem -
	notes cut off too soon.
Date: Fri, 21 Jul 2006 20:35:39 +0200
Message-ID: <1485eeabd77c5c5b48cde0f6c71cc7e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EBFB183
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 20:35:40 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1284> 
======================================================================
Reported By:                terminator356
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1284
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-27-2005 06:36 CEST
Last Modified:              07-21-2006 20:35 CEST
======================================================================
Summary:                    Soundfont notes problem - notes cut off too soon.
Description: 
Playing a midi keyboard or a file, a note played twice will cut off 
 other notes.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001290 Re: Bug 0001284 + 0001289: Sorry, my fi...
related to          0001289 I fixed Bug 0001284.  Please reinstate ...
======================================================================

----------------------------------------------------------------------
 terminator356 - 07-19-06 05:36 
----------------------------------------------------------------------
I received a notice today that bugs 1284, 1289, and 1290
 have been assigned to you.
I fixed those bugs months ago, and the fixes are already
 in the tree. If you would like full exact details of 
 what was actually wrong, and fixed, contact 
 Takashi Iwai <tiwai at suse.de>, or me.
(He accepted my changes).
Please mark those bugs as fixed.
Thanks.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-05 06:36 terminator356  New Issue                                    
07-27-05 06:36 terminator356  File Added: drumtrack-test.mid                    
07-27-05 06:36 terminator356  Distribution              => Mandrake        
07-27-05 06:36 terminator356  Kernel Version            => 2.6.10          
08-03-05 11:30 perex          Relationship added       related to 0001290  
08-03-05 11:31 perex          Relationship added       related to 0001289  
07-18-06 14:45 jcdutton       Status                   new => assigned     
07-18-06 14:45 jcdutton       Assigned To               => jcdutton        
07-19-06 05:33 terminator356  Note Added: 0011079                          
07-19-06 05:36 terminator356  Note Edited: 0011079                         
07-21-06 20:35 tiwai          Status                   assigned => resolved
07-21-06 20:35 tiwai          Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
