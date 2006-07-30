From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001692]: sound doesn't work
Date: Sun, 30 Jul 2006 18:00:20 +0200
Message-ID: <0a394a6fe5eb713336ca1539f68aa8a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34323165
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 18:00:21 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1692> 
======================================================================
Reported By:                jra2003
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1692
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-29-2005 04:50 CET
Last Modified:              07-30-2006 18:00 CEST
======================================================================
Summary:                    sound doesn't work
Description: 
After folling the instructions to the letter, I restart the computer and it
finds the sound card and I let it configure it.  Once logged into root
with KDE I goto KMenu > system settings > soundcard detection and I click
'play test'  It might works once or twice with a sound being played then a
question asking if it worked.  When it doesn't work it doesn't ask if I
heard anything until a few seconds pass.  So the command to play the sound
went through, but the final result is that the sound went to the wrong
place and not to me sndcard and to my speakers.

BTW: I did check the mixer levels and if it was muted or not and no
problems there.
======================================================================

----------------------------------------------------------------------
 jra2003 - 07-24-06 18:54 
----------------------------------------------------------------------
sry, but I have not kept up with Linux, although I still have it on a
seperate HD ready to boot, I am now using windows most of the time.

If I remember correctly though, I think download a beta driver(at the
time) worked.  That beta driver is probably a regular driver now.

----------------------------------------------------------------------
 jcdutton - 07-30-06 18:00 
----------------------------------------------------------------------
User believes problem is solved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-05 04:50 jra2003        New Issue                                    
12-29-05 04:50 jra2003        Distribution              => Fedora Core 2   
12-29-05 04:50 jra2003        Kernel Version            => 2.6.5           
12-29-05 04:50 jra2003        Issue Monitored: jra2003                     
12-29-05 05:34 jra2003        Note Added: 0007187                          
07-23-06 19:10 jcdutton       Note Added: 0011202                          
07-23-06 19:10 jcdutton       Status                   assigned => feedback
07-24-06 18:54 jra2003        Note Added: 0011212                          
07-30-06 18:00 jcdutton       Status                   feedback => closed  
07-30-06 18:00 jcdutton       Note Added: 0011321                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
