From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001007]: no audio in - unable to record
Date: Mon, 28 Mar 2005 01:43:48 +0200
Message-ID: <b3ce67991bc1823f651dafa69725973f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 270B6194
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 01:43:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1007> 
======================================================================
Reported By:                msillence
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1007
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-22-2005 21:44 CET
Last Modified:              03-28-2005 01:43 CEST
======================================================================
Summary:                    no audio in - unable to record
Description: 
I can only get a weak hiss from the card even with the recording level up
full
======================================================================

----------------------------------------------------------------------
 Cimmo - 03-27-05 17:51 
----------------------------------------------------------------------
I write here because don't want to make another new bug report to this
card.

I've this problem: I've tvtime and I can't here nothing.
I've a tv card, its output audio is plugged in the input jack of my MSI
Live 24 bit: CA0106 Live! by MSI [SB0438].

In tvtime video is ok, audio is absent, if I press '+' button, the volume
remain to 0.
In gnome's volume control all volumes are at 100% and unmuted: strange
that there are an Analog Unknown and an SPDIF Unknown

I've a Fedora Core 4 test 1, with alsa-lib 1.08 and kernel
2.6.11-1.1191_FC4 that has all 2.6.12rc1 patches including the one for my
MSI audio board.

please help!



----------------------------------------------------------------------
 msillence - 03-28-05 01:43 
----------------------------------------------------------------------
Forum info:

I would suggest you open a new thread on your local forum, if you can't
find an existing one.
It looks like they have forums for each country/area/language...

http://forums.creative.com/creativelabs/board/message?board.id=soundblaster&message.id=14182

Message:

Subject: Request for Linux support...

I recently purchased a soundblaster live 24 card.
As dramatic as the improvement is over the on boad sound, the board is
very poorly supported in linux and suffers from stuttering and can not
record (the main reason for purchase)

Please, please, please could you release enough documentation so someone
can write an open driver for your hardware...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 21:44 msillence      New Issue                                    
03-22-05 21:44 msillence      Kernel Version            => 2.6.11.5        
03-23-05 00:45 jcdutton       Status                   assigned => closed  
03-23-05 00:45 jcdutton       Note Added: 0004146                          
03-23-05 10:09 msillence      Status                   closed => feedback  
03-23-05 10:09 msillence      Resolution               open => reopened    
03-23-05 10:09 msillence      Note Added: 0004153                          
03-27-05 11:56 Alinoe         Note Added: 0004220                          
03-27-05 13:36 msillence      Note Added: 0004221                          
03-27-05 16:39 Alinoe         Note Added: 0004223                          
03-27-05 17:50 Cimmo          Note Added: 0004224                          
03-27-05 17:51 Cimmo          Note Edited: 0004224                         
03-28-05 01:30 Alinoe         Issue Monitored: Alinoe                      
03-28-05 01:43 msillence      Note Added: 0004226                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
