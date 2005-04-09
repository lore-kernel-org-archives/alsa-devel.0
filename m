From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000145]: Nforce2 Audio - Bacon Fry ssZzZZZZzzle
Date: Sat, 9 Apr 2005 14:36:58 +0200
Message-ID: <e78f876e580be38249d6ab8209216741@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7694521D
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 14:36:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=145> 
======================================================================
Reported By:                onemaN
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   145
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware!
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-18-2004 09:07 CET
Last Modified:              04-09-2005 14:36 CEST
======================================================================
Summary:                    Nforce2 Audio - Bacon Fry ssZzZZZZzzle
Description: 
Im using 2.6.4 with an abit nf7-s 2.0. Bacon fry is apparent on both analog
and spdif output (exactly the same effect). When playing music the pitch
is correct (with 2.6.2 everything was speeded up 20% it seemed) 

It does this every time when I play mp3 or flac files with xmms or any
other player. 

OK so when I got on this bug system I saw there was allready many bugs
listed simaler to this. The reason im making effort here, is because Im
willing to be contacted and work with you guys to get this one right, I
want of course to use this linux box as a half terabyte flac jukebox, and
I cant do that if the sound is anything less than perfect. ;P 

Let me know! I will do what I can to help debug!

-David 
david@wdtp.com
======================================================================

----------------------------------------------------------------------
 djtm - 09-28-04 16:17 
----------------------------------------------------------------------
Do you have any inputs connected? (Mic-In, Line-In, etc)
Have you tried muting and disconnecting inputs such as Mic-In, Line-In,
etc?
Does the same problem occur under Windows? (if possible to test)

----------------------------------------------------------------------
 jdthood - 04-09-05 14:36 
----------------------------------------------------------------------
Submitter: Does this solve the problem?:

> amixer set "Surround Down Mix" off

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-04 09:07 onemaN         New Issue                                    
03-18-04 09:07 onemaN         Distribution              => slackware!      
03-18-04 09:07 onemaN         Kernel Version            => 2.6.4           
03-18-04 09:11 onemaN         Note Added: 0000640                          
03-18-04 09:36 onemaN         Issue Monitored: onemaN                      
03-23-04 16:20 perex          Note Added: 0000666                          
03-23-04 18:15 onemaN         Note Added: 0000674                          
03-23-04 18:42 perex          Note Added: 0000686                          
03-23-04 19:16 onemaN         Note Added: 0000691                          
03-23-04 19:26 onemaN         Note Added: 0000692                          
07-22-04 05:44 cosmix         Note Added: 0001466                          
07-31-04 17:11 mcbridematt    Note Added: 0001510                          
09-28-04 02:57 rotech         Note Added: 0001944                          
09-28-04 16:17 djtm           Note Added: 0001951                          
04-09-05 14:36 jdthood        Note Added: 0004401                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
